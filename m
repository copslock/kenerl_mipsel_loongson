Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 08:46:15 +0100 (BST)
Received: from p0241.as-l042.contactel.cz ([IPv6:::ffff:194.108.237.241]:4100
	"EHLO kopretinka") by linux-mips.org with ESMTP id <S8225235AbTEHHqB>;
	Thu, 8 May 2003 08:46:01 +0100
Received: from ladis by kopretinka with local (Exim 3.35 #1 (Debian))
	id 19Dfsm-0000Gf-00; Thu, 08 May 2003 09:32:00 +0200
Date: Thu, 8 May 2003 09:32:00 +0200
To: Keith M Wesolowski <wesolows@foobazco.org>
Cc: linux-mips@linux-mips.org, Guido Guenther <agx@sigxcpu.org>
Subject: Re: [PATCH] Highmem detection for Indigo2
Message-ID: <20030508073200.GA837@kopretinka>
References: <20030428071639.GA7578@simek> <20030508061117.GA30191@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508061117.GA30191@foobazco.org>
User-Agent: Mutt/1.3.28i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 07, 2003 at 11:11:17PM -0700, Keith M Wesolowski wrote:
> On Mon, Apr 28, 2003 at 09:16:39AM +0200, Ladislav Michl wrote:
> 
> > Following patch builds whole RAM map based of MC's memory configuration
> > registers, does some samity checks adds high system memory (if any) to
> > bootmem.
> 
> > +static void init_bootmem(void)
> ...
> > +	init_bootmem();
> 
> This is a pretty unfortunate choice of names for this function.  See
> mm/bootmem.c.

what about probe_memory or detect_memory?

> Other than that, your patch works fine for me; my Indy has 192MB
> memory and it's detected properly.  I do get an oops in do_be from
> xdm, but I get that without the patch also.
> 
> Determined physical RAM map:
>  memory: 00001000 @ 00000000 (reserved)
>  memory: 00001000 @ 00001000 (reserved)
>  memory: 001e1000 @ 08002000 (reserved)
>  memory: 0055d000 @ 081e3000 (usable)
>  memory: 000c0000 @ 08740000 (ROM data)
>  memory: 0b800000 @ 08800000 (usable)

that's not relevant part. information from memconfig registers is
printed above "Determined physical RAM map" [1]
MC: Probing memory configuration:
 Bank0:  32M @ 10000000
 Bank1: 128M @ 08000000
  
> I need to do the same kind of thing for ip32 as the ARC memory
> detection has the same shortcoming on that platform.  No sense having
> a machine support 1GB memory and only looking for 256MB of it,
> especially in a 64-bit kernel.  ARC[S] really does seem to be useless.

[1] This patch still uses ARCS to determine low 256M of memory, because
Indy can't have more anyway, it is useful only for FullHouse machines.
Purpose of this patch is to detect memory above 0x20000000. Idea was to
let people test if memconfig registers provides relevant informations
and then get rid of ARCS based memory probing completely. Kernel
reserves its memory itself and we know where exceptions vectors are (do
i need reserve space for them explicitly?), so the only problem is ARCS
data (it's not possible to detect where ARCS stores them without asking
it). If no ARCS call will be made after mm initialization (thoose few
remaining is easy to avoid) this should be also no problem.

Guido told me he is working device detection based on ARCS calls. I'm
not sure is this way will be acceptale for him...

	ladis
