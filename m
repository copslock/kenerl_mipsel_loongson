Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2004 18:32:37 +0000 (GMT)
Received: from jeeves.momenco.com ([IPv6:::ffff:64.169.228.99]:29966 "EHLO 
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S8225419AbUANSch>; Wed, 14 Jan 2004 18:32:37 +0000
Received: from BULLDOG (natbox.momenco.com [64.169.228.98])
	by  host099.momenco.com (8.11.6/8.11.6) with ESMTP id i0EIWZM13042;
	Wed, 14 Jan 2004 10:32:35 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "'Samuel Agarwal'" <sagarwal10@hotmail.com>,
	<linux-mips@linux-mips.org>, <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Intel Pro 82546 chipset performance
Date: Wed, 14 Jan 2004 10:32:32 -0800
Organization: Momentum Computer, Inc.
Message-ID: <001101c3dacc$c5e182a0$7200a8c0@internal.momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <BAY10-F117sntMQN8zy00008864@hotmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

We use this chip (actually, the entire family) on many of our products (PPC,
x86, and MIPS).

Our data indicates that the chip can sustain wire-saturation with minimum
size packets.  However, many CPUs cannot keep up with the load created by
interrupts coming in at that rate.

There are probably some driver enhancements (interrupt combining, etc.)
which could be made to improve the situation.  But it's not a silicon
problem.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com


> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Samuel Agarwal
> Sent: Tuesday, January 13, 2004 10:37 PM
> To: linux-mips@linux-mips.org; linuxppc-embedded@lists.linuxppc.org
> Subject: Intel Pro 82546 chipset performance
> 
> 
> Hi
> 
> We're trying to use the Intel Pro 1000 adapters with the 
> 82546 chipset for a packet switching application. Has anyone 
> investigated performance on this chipset? With minimum sized 
> ethernet frames, the maximum throughput I can get is about 1 
> million packets per second (versus a 1.4 mill for line 
> rate
> on a gigethernet) and it looks that performance is skewed 
> towards receiving traffic (rather than sending out).
> 
> If anyone has any opinions or thoughts I'd appreciate them. 
> It's hard to get information out of Intel.
> 
> _________________________________________________________________
> Find out everything you need to know about Las Vegas here for 
> that getaway.  
> http://special.msn.com/msnbc/vivalasvegas.armx
> 
> 
