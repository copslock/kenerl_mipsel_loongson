Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2004 23:25:22 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:20218 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225214AbUHDWZS>;
	Wed, 4 Aug 2004 23:25:18 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i74MP7ar014157;
	Wed, 4 Aug 2004 15:25:07 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i74MP6fD014156;
	Wed, 4 Aug 2004 15:25:06 -0700
Date: Wed, 4 Aug 2004 15:25:06 -0700
From: Jun Sun <jsun@mvista.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Song Wang <wsonguci@yahoo.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: 2.6 preemptive kernel on mips
Message-ID: <20040804152506.C6269@mvista.com>
References: <20040803192244.5889.qmail@web40002.mail.yahoo.com> <20040803124048.C1926@mvista.com> <20040804215140.GP9235@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040804215140.GP9235@smtp.west.cox.net>; from trini@kernel.crashing.org on Wed, Aug 04, 2004 at 02:51:40PM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Aug 04, 2004 at 02:51:40PM -0700, Tom Rini wrote:
> On Tue, Aug 03, 2004 at 12:40:48PM -0700, Jun Sun wrote:
> 
> > On Tue, Aug 03, 2004 at 12:22:44PM -0700, Song Wang wrote:
> > > Hi,
> > > 
> > > Has anyone tried to enable kernel preemption on
> > > Linux mips 2.6 kernel (mips32) and test it? If
> > > so, which version does it work?
> > > 
> > > I tried on 2.6.3 and it didn't work.
> > > 
> > 
> > Try the latest kernel.  I checked preemption around 2.6.5 time
> > and I believe all the obvious problems are fixed then.
> > 
> > There are still some issues with both SMP and PREEMPT, but most
> > people won't see them in normal cases.
> 
> MIPS or generic?  It's claimed, at least, that SMP&&PREEMPT have no
> fatal, generic, issues now (I forget if that was the case around 2.6.5).
> 

It is MIPS specific problems I was referring to (such as unsafe 
smp_processor_id() reference etc).

If you think about it the real problem is that kernel has non-migratable
regions, a section where process should not migrate from one CPU to
another.  Before preemtible kernel is introduced such non-migratable
regions are not a problem because they can't migrate during those
regions.

So a potentially better solution is to introduce non-migratable
regions during which scheduler promises not to migrate the processes.
Under such promises a process can actually be preempted while
it is in such a region.

Jun
