Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 09:29:21 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:51377
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225561AbUJNI3Q>; Thu, 14 Oct 2004 09:29:16 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id i9E8T3iP008392;
	Thu, 14 Oct 2004 01:29:04 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.11/8.12.11) with SMTP id i9E8T10B004482;
	Thu, 14 Oct 2004 01:29:01 -0700 (PDT)
Message-ID: <01d901c4b1c8$996b7b30$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Dmitriy Tochansky" <toch@dfpost.ru>, <linux-mips@linux-mips.org>
References: <20041014115304.3edbe141.toch@dfpost.ru>
Subject: Re: Strange instruction
Date: Thu, 14 Oct 2004 10:34:18 +0200
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

That's a 64-bit add, which is actually being used as a 64-bit move
of the "sp" register to k1.  Try "objdump -m mips:isa64" (or whatever
variant gives your version of objdump the right to disassemble the
MIPS III+/MIPS64 instructions.

One might suspect that your board monitor ROM was built for a 64-bit CPU.
This illustrates why, if one want to write portable assembler code for MIPS,
one should implement "move" operations as OR Target,$0,Source rather than
using an ADDU or DADDU...

----- Original Message ----- 
From: "Dmitriy Tochansky" <toch@dfpost.ru>
To: <linux-mips@linux-mips.org>
Sent: Thursday, October 14, 2004 13:53
Subject: Strange instruction


> Hello!
> 
> When starts kernel for my au1500 board reseting board. After disassembling I found instruction
> which reseting board. Here is few strings of "mipsel-linux-objdump -D vmlinux" output:
> 
> ---
> 
> a0000650:       07400003        bltz    k0,a0000660 <nmi_handler+0x1c>          
> a0000654:       03a0d82d        0x3a0d82d                                       
> a0000658:       3c1ba020        lui     k1,0xa020 
> 
> ---
> 
> Base address changed by me.
> 
> What is A0000654? There is board resets.
> 
> 
