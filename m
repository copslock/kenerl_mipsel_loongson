Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 06:07:21 +0100 (BST)
Received: from h081217049130.dyn.cm.kabsi.at ([IPv6:::ffff:81.217.49.130]:49583
	"EHLO phobos.hvrlab.org") by linux-mips.org with ESMTP
	id <S8225561AbVD1FHG>; Thu, 28 Apr 2005 06:07:06 +0100
Received: from mini.intra (dhcp-1334-4.blizz.at [213.143.126.4])
	(authenticated bits=0)
	by phobos.hvrlab.org (8.13.4/8.13.4/Debian-1) with ESMTP id j3S56ttq006615
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Thu, 28 Apr 2005 07:06:56 +0200
Subject: Re: iptables/vmalloc issues on alchemy
From:	Herbert Valerio Riedel <hvr@hvrlab.org>
To:	Dan Malek <dan@embeddededge.com>
Cc:	Josh Green <jgreen@users.sourceforge.net>,
	linux-mips@linux-mips.org, Pete Popov <ppopov@embeddedalley.com>
In-Reply-To: <4bf8c757c3a4d32177ab90b92eace823@embeddededge.com>
References: <1114505009.11315.37.camel@mini.intra>
	 <1114627785.17008.21.camel@SillyPuddy.localdomain>
	 <4bf8c757c3a4d32177ab90b92eace823@embeddededge.com>
Content-Type: text/plain
Date:	Thu, 28 Apr 2005 07:06:52 +0200
Message-Id: <1114664812.4647.6.camel@mini.intra>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Return-Path: <hvr@hvrlab.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@hvrlab.org
Precedence: bulk
X-list: linux-mips

On Wed, 2005-04-27 at 15:06 -0400, Dan Malek wrote:
> On Apr 27, 2005, at 2:49 PM, Josh Green wrote:
> 
> > ...... I was
> > planning on doing some additional gdb debugging of the failure
> > (especially the initial large MMAP attempt by iptables, which was 1.5GB
> > in my case).
> 
> Oh wait ....  I found a bug a while ago from someone trying to load
> large modules.  There is a problem if the kernel grows to need
> additional PTE tables, the top level pointers don't get propagated
> correctly and subsequent access by a thread that didn't actually
> do the allocation would fail.  I'm looking into this, including your
> past message about 64-bit PTEs.

additional note:

the problem only shows up for me only when enabling
CONFIG_64BIT_PHYS_ADDR, in case someone had problems reproducing the
issue...

regards,
-- 
Herbert Valerio Riedel <hvr@hvrlab.org>
