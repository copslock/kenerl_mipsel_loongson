Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jul 2004 23:35:50 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:64985
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225763AbUGLWfq>; Mon, 12 Jul 2004 23:35:46 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id i6CMS4pN028506;
	Mon, 12 Jul 2004 15:28:04 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by mercury.mips.com (8.12.11/8.12.11) with SMTP id i6CMS316007379;
	Mon, 12 Jul 2004 15:28:03 -0700 (PDT)
Message-ID: <021201c4685f$2925ee30$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <KevinK@mips.com>
To: "Kevin D. Kissell" <KevinK@mips.com>,
	"S C" <theansweriz42@hotmail.com>,
	"Ralf Baechle" <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
References: <BAY2-F27mxl2RtYP35u0000d191@hotmail.com> <020201c46859$fa6b98b0$0deca8c0@Ulysses>
Subject: Re: Strange, strange occurence
Date: Tue, 13 Jul 2004 00:25:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
X-Scanned-By: MIMEDefang 2.39
Return-Path: <KevinK@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KevinK@mips.com
Precedence: bulk
X-list: linux-mips

> Your intuition is correct, and the code in r4k_tlb_init() does look scary.
> But at least in the linux-mips CVS tree, flush_icache_range() tests to see
> if "cpu_has_ic_fills_f_dc" (CPU has Icache fills from Dcache, I presume)
> is set, and if it isn't, it pushes the specified range out of the Dcache before
> flushing the Icache.  I would speculate that either your c-r4k.c is out of
> sync with yout tlb-r4k.c, or you erroneously have cpu_has_ic_fills_f_dc
> set.

Hmm.  On closer examination, there *is* a bug in the current r4k_flush_icache_range(),
in that it computes its cache flush loop for the I-cache based on the D-cache line size.
Those line sizes are *usually* the same.  By any chance are they different for the
TX49 family?  If the icache line is longer than the dcache line, there should be no
functional problem, just some wasted cycles.  But if the dcache line were, say, 
twice the length of the Icache line, only half of the icache lines would be invalidated...

            Regards,

            Kevin K.
