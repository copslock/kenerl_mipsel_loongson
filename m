Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 19:41:18 +0100 (BST)
Received: from web81009.mail.yahoo.com ([IPv6:::ffff:206.190.37.154]:34960
	"HELO web81009.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225351AbUJNSlH>; Thu, 14 Oct 2004 19:41:07 +0100
Message-ID: <20041014184051.89443.qmail@web81009.mail.yahoo.com>
Received: from [216.98.102.225] by web81009.mail.yahoo.com via HTTP; Thu, 14 Oct 2004 11:40:51 PDT
X-RocketYMMF: pvpopov@pacbell.net
Date: Thu, 14 Oct 2004 11:40:51 -0700 (PDT)
From: Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
Subject: Re: Hi-Speed USB controller and au1500
To: "Yates, John" <jpy@sparta.com>, linux-mips@linux-mips.org
In-Reply-To: <CECB0B0453C6D511BEB800104B70FA47B4A01D@STARBASE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


--- "Yates, John" <jpy@sparta.com> wrote:

> Hello all,
> 
> I am having a problem using a PCI USB 2.0 Hi-Speed
> controller (EHCI) with
> the dbau1500 eval kit with kernel 2.4.26. I have
> traced the problem down to
> a call to atomic_add() (in
> include/asm-mips/atomic.h) that uses assembly to
> access ll/sc registers of the mips architecture.  If
> I override CPU options
> and disable ll/sc when configuring the kernel, 
> everything works fine.

Hmm, that sounds suspicuous. I would guess the ll/sc
is just a symptom you're seeing, but that's probably
not the root of the problem. If you disable ll/sc, the
kernel has to emulate those instructions, if your
userland code uses them, which changes the
characteristics of the system, including timings.
There's probably a timing problem somewhere, but ...
that's just a guess.

Pete

> However this causes the atomic_add() to use
> local_irq_save()/local_irq_restore().  I am assuming
> this will cause quite a
> performance hit since atomic_add() gets called all
> over the place.  I should
> include that the ll/sc version of atomic_add() seems
> to work fine until the
> call from the usb infrastructure. 
> 
> Below is a code trail that leads to the call to
> atomic_add():
> 
>  
> hub.c:			usb_hub_port_connect_change()
> usb.c: 			usb_set_address()
> usb.c: 			usb_control_msg()
> usb.c: 			usb_internal_control_msg()
> usb.c: 			usb_start_wait_urb()
> usb.c: 			usb_submit_urb()
> usb.c: 			submit_urb()
> hcd.c: 			hcd_submit_urb()	
> host/ehci-hcd.c: 		ehci_urb_enqueue() 	(urb_enqueue
> function ptr)
> host/ehci-q.c: 		submit_async()  
> host/ehci-q.c: 		qh_append_tds()
> host/ehci-mem.c: 		qh_get()
> atomic.h			atomic_inc()
> atomic.h			#define atomic_inc(v) atomic_add(1,(v))
> <-
> uses ll/sc
> 
> To reproduce my results:
> 
> Plug in a Hi-Speed USB 2.0 controller into your pci
> slot and boot with a usb
> ehci enabled  kernel. Be sure to disable the non-pci
> usb host that is
> built-in to the au1500 when building the  kernel. (I
> have tried two
> controllers (NEC and ALi) with identical results.) 
> 
> Plug a Hi-Speed device (thumb drive or external HD)
> into the controller.
> (system stops responding here)
> 
> Low/Full speed devices work without a problem
> because they use the ohci or
> uhci drivers. 
> 
> 
> Any help or direction will be greatly appreciated.
> 
> John
> 
> 
