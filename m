Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 18:28:42 +0100 (BST)
Received: from M4.sparta.com ([IPv6:::ffff:157.185.61.2]:26331 "EHLO
	M4.sparta.com") by linux-mips.org with ESMTP id <S8225346AbUJNR2i>;
	Thu, 14 Oct 2004 18:28:38 +0100
Received: from Beta5.sparta.com (beta5.sparta.com [157.185.63.21])
	by M4.sparta.com (8.12.8/8.12.8) with ESMTP id i9EHSZOU030735
	for <linux-mips@linux-mips.org>; Thu, 14 Oct 2004 12:28:36 -0500
Received: from postoffice.centreville.sparta.com (postoffice.centreville.sparta.com [157.185.36.11])
	by Beta5.sparta.com (8.12.11/8.12.11) with ESMTP id i9EHSW0B010603
	for <linux-mips@linux-mips.org>; Thu, 14 Oct 2004 12:28:34 -0500
Received: from starbase.mclean.sparta.com (starbase [157.185.36.3])
	by postoffice.centreville.sparta.com (8.11.6/8.11.6) with ESMTP id i9EIABc14220
	for <linux-mips@linux-mips.org>; Thu, 14 Oct 2004 14:10:12 -0400
Received: by STARBASE with Internet Mail Service (5.5.2653.19)
	id <47WTJQA5>; Thu, 14 Oct 2004 13:35:28 -0400
Message-ID: <CECB0B0453C6D511BEB800104B70FA47B4A01D@STARBASE>
From: "Yates, John" <jpy@sparta.com>
To: linux-mips@linux-mips.org
Subject: Hi-Speed USB controller and au1500
Date: Thu, 14 Oct 2004 13:35:27 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <jpy@sparta.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jpy@sparta.com
Precedence: bulk
X-list: linux-mips

Hello all,

I am having a problem using a PCI USB 2.0 Hi-Speed controller (EHCI) with
the dbau1500 eval kit with kernel 2.4.26. I have traced the problem down to
a call to atomic_add() (in include/asm-mips/atomic.h) that uses assembly to
access ll/sc registers of the mips architecture.  If I override CPU options
and disable ll/sc when configuring the kernel,  everything works fine.
However this causes the atomic_add() to use
local_irq_save()/local_irq_restore().  I am assuming this will cause quite a
performance hit since atomic_add() gets called all over the place.  I should
include that the ll/sc version of atomic_add() seems to work fine until the
call from the usb infrastructure. 

Below is a code trail that leads to the call to atomic_add():

 
hub.c:			usb_hub_port_connect_change()
usb.c: 			usb_set_address()
usb.c: 			usb_control_msg()
usb.c: 			usb_internal_control_msg()
usb.c: 			usb_start_wait_urb()
usb.c: 			usb_submit_urb()
usb.c: 			submit_urb()
hcd.c: 			hcd_submit_urb()	
host/ehci-hcd.c: 		ehci_urb_enqueue() 	(urb_enqueue
function ptr)
host/ehci-q.c: 		submit_async()  
host/ehci-q.c: 		qh_append_tds()
host/ehci-mem.c: 		qh_get()
atomic.h			atomic_inc()
atomic.h			#define atomic_inc(v) atomic_add(1,(v)) <-
uses ll/sc

To reproduce my results:

Plug in a Hi-Speed USB 2.0 controller into your pci slot and boot with a usb
ehci enabled  kernel. Be sure to disable the non-pci usb host that is
built-in to the au1500 when building the  kernel. (I have tried two
controllers (NEC and ALi) with identical results.) 

Plug a Hi-Speed device (thumb drive or external HD) into the controller.
(system stops responding here)

Low/Full speed devices work without a problem because they use the ohci or
uhci drivers. 


Any help or direction will be greatly appreciated.

John
