Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 07:11:32 +0100 (BST)
Received: from janus.foobazco.org ([IPv6:::ffff:198.144.194.226]:10501 "EHLO
	mail.foobazco.org") by linux-mips.org with ESMTP
	id <S8225192AbTEHGLa>; Thu, 8 May 2003 07:11:30 +0100
Received: from fallout.sjc.foobazco.org (fallout.sjc.foobazco.org [192.168.21.20])
	by mail.foobazco.org (Postfix) with ESMTP
	id 64DB91BD8D; Wed,  7 May 2003 23:11:23 -0700 (PDT)
Received: by fallout.sjc.foobazco.org (Postfix, from userid 1014)
	id B8C2624; Wed,  7 May 2003 23:11:17 -0700 (PDT)
Date: Wed, 7 May 2003 23:11:17 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Highmem detection for Indigo2
Message-ID: <20030508061117.GA30191@foobazco.org>
References: <20030428071639.GA7578@simek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428071639.GA7578@simek>
User-Agent: Mutt/1.5.4i
Return-Path: <wesolows@foobazco.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wesolows@foobazco.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 28, 2003 at 09:16:39AM +0200, Ladislav Michl wrote:

> Following patch builds whole RAM map based of MC's memory configuration
> registers, does some samity checks adds high system memory (if any) to
> bootmem.

> +static void init_bootmem(void)
...
> +	init_bootmem();

This is a pretty unfortunate choice of names for this function.  See
mm/bootmem.c.

Other than that, your patch works fine for me; my Indy has 192MB
memory and it's detected properly.  I do get an oops in do_be from
xdm, but I get that without the patch also.

Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 00001000 @ 00001000 (reserved)
 memory: 001e1000 @ 08002000 (reserved)
 memory: 0055d000 @ 081e3000 (usable)
 memory: 000c0000 @ 08740000 (ROM data)
 memory: 0b800000 @ 08800000 (usable)

I need to do the same kind of thing for ip32 as the ARC memory
detection has the same shortcoming on that platform.  No sense having
a machine support 1GB memory and only looking for 256MB of it,
especially in a 64-bit kernel.  ARC[S] really does seem to be useless.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
