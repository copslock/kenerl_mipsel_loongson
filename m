Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2014 19:28:36 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41616 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843089AbaEAR21y-69L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 May 2014 19:28:27 +0200
Date:   Thu, 1 May 2014 18:28:26 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: Malta: support powering down
In-Reply-To: <20140422100713.GC42386@pburton-linux.le.imgtec.org>
Message-ID: <alpine.LFD.2.11.1404221540540.11598@eddie.linux-mips.org>
References: <1395415232-42288-1-git-send-email-paul.burton@imgtec.com> <1395415232-42288-2-git-send-email-paul.burton@imgtec.com> <alpine.LFD.2.11.1404191624180.11598@eddie.linux-mips.org> <20140422100713.GC42386@pburton-linux.le.imgtec.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, 22 Apr 2014, Paul Burton wrote:

> >  First of all, shouldn't all of this stuff be wired into 
> > mips_machine_power_off rather than mips_machine_halt?  I would have 
> > thought mips_machine_halt is supposed to get back to the console monitor 
> > prompt (YAMON in this case) without restarting or powering off the system, 
> > and if that's impossible, then loop indefinitely (that's the -H vs -P 
> > action option to shutdown(8); see the details in the manual).
> 
> Perhaps. Currently there is no mips_machine_power_off - both
> _machine_halt & pm_power_off point at mips_machine_halt and its existing
> behaviour is to reset the system. That is, regardless of whether you
> intend to halt, power off or reset you always get a reset.

 Fair enough.  With no sophisticated handlers in place this could have 
made sense, although issuing a reset on a halt is IMO dangerous as a 
system may be set up for auto-boot, and that's certainly not what one 
wants with `shutdown -h'.  However as you improve handling I think it'll 
make sense to make it more accurate too.

> Returning to
> the monitor/bootloader prompt (which may or may not be YAMON) is not
> generally possible since the memory it was using has probably been
> overwritten.

 It depends on whether the YAMON memory (first 1MB IIRC) is claimed by the 
kernel or not; I don't remember offhand.  Also I don't know if YAMON 
reinstalls its exception handlers on application return.  In principle it 
should be doable.

> It may make sense to separate halt & power off though, with
> halt simply executing an infinite loop as you suggest.

 Yes, that would be great if YAMON return turns out infeasible.

> >  Shouldn't the handle on the device and the resource be requested early 
> > on, where mips_machine_halt (mips_machine_power_off) is installed as the 
> > halt (power-off) handler?  Especially requesting the resource here seems 
> > to make little sense to me -- we're about to kill the box, so why bother 
> > verifying whether it's going to interfere with a random driver?
> 
> Well requesting the I/O region was more about sanity checking that it's
> present. This could be done earlier I guess, it would just mean keeping
> around the needed I/O & PCI bus pointers in globals and I don't see the
> issue with just acquiring them when they're needed.

 I have two issues with that:

1. Drivers generally claim resources at initialisation, not at the time 
   the resources need to be used.  While the power-off driver is very 
   simple and single-use only, I see no reason for it to be different.  
   I find it useful to see what hardware has drivers attached in 
   /proc/iomem or /proc/ioports too.

2. Any resource claim error message seen at boot can prompt the system 
   operator to take a corrective action.  When it's only issued at system 
   shutdown, it's likely it'll be too late already.

Do you think there's anything wrong with these obervations?

> >  I know all the three of the GT-64120/64120A, Bonito and SOC-it system 
> > controllers support software generation of PCI special cycles, but is the 
> > method the same across them all?
> 
> It's the same for the Galileo GT-64120 & the SOC-it/ROC-it/ROC-it2
> system controllers. I'm unsure about Bonito, however there is the
> fallback to the existing reset behaviour if it fails. Working on the
> GT-64120 & SOC-it+derivatives covers the cases in wide use, ie current
> physical Malta systems & QEMU (although QEMU doesn't seem to need the
> special cycle anyway).

 ISTR now it may actually be specified like this by the PCI spec, so any 
PCI host bridge would behave the same.  You should have a copy of the spec 
available somewhere I presume. :)

  Maciej
