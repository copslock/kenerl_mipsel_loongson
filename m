Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Dec 2002 20:46:02 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:27387 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225243AbSLPUqB>;
	Mon, 16 Dec 2002 20:46:01 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gBGKjuW11530;
	Mon, 16 Dec 2002 12:45:56 -0800
Date: Mon, 16 Dec 2002 12:45:56 -0800
From: Jun Sun <jsun@mvista.com>
To: Colin.Helliwell@Zarlink.Com
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Problems with CONFIG_PREEMPT
Message-ID: <20021216124556.E10178@mvista.com>
References: <OF9DA9DC55.9D9F4E46-ON80256C91.002C0064@zarlink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF9DA9DC55.9D9F4E46-ON80256C91.002C0064@zarlink.com>; from Colin.Helliwell@Zarlink.Com on Mon, Dec 16, 2002 at 01:58:11PM +0000
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


Several possibilities:

1) Not all MIPS boards can run pre-k.  At minimum, you need to use
NEW_TIME_C, Or else you have to take a lot of stuff youself. 

2) Not sure if all MIPS patches are in RML's patch.  If you pass the URL
pointer, I can take a look.

3) Even with all above taken care of, there are still unsolved issues
(such as math emul not pre-k safe, some cache operations, etc).
However, these problems usually are much harder to show up.  You won't
see them unless you delibrately want to. :-)

Jun

On Mon, Dec 16, 2002 at 01:58:11PM +0000, Colin.Helliwell@Zarlink.Com wrote:
> I've been porting the MIPS kernel to our system-on-chip hardware
> (4KEc-based) and have encountered a problem with a pre-emptible patch. The
> original kernel was the 2.4.19 from the CVS server, onto which I applied
> Robert Love's preemptible patch (preempt-kernel-rml-2.4.19-2.patch), plus
> the addition of a #include to softirq.h, and a missing definition for
> release_irqlock() in hardirq.h.
> I've found that when CONFIG_PREEMPT is set, it no longer loads the
> (non-compressed) initrd correctly - about 1.8MB through loading (2MB total)
> I get a Data Bus Error. A typical call trace shown by the oops is shown
> below, and looks a little 'confused' to me, so I'm thinking there may be
> some stack corruption going on?
> 
> Address         Function
> 
> 801174fc        tasklet_hi_action
> 801af0a4        printChipInfo
> 801af0a4        printChipInfo
> 8013bf50        sys_write
> 801089c4        stack_done
> 80108b28        reschedule
> 801133d0        _call_console_drivers
> 80113ad8        release_console_sem
> 80113848        printk
> 801506b8        sys_ioctl
> 801af0f8        printChipInfo
> 8014ccd4        sys_mkdir
> 801af0a4        printChipInfo
> 80100470        init
> 80100470        init
> 80100840        prepare_namespace
> 80100470        init
> 8010049c        init
> 8010352c        kernel_thread
> 80100420        _stext
> 8010351c        kernel_thread
> 
> 
> I wondered if anyone had any thoughts about what might be causing this, or
> had seen this occuring before - were there perhaps some changes made just
> after this point in time (now in the 2.5.x kernel)?
> 
> 
> 
> Thanks.
> 
> 
> 
> 
