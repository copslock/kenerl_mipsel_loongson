Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Nov 2002 14:20:43 +0100 (CET)
Received: from mx2.mips.com ([206.31.31.227]:46792 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123974AbSKRNUm>;
	Mon, 18 Nov 2002 14:20:42 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gAIDKSNf003314
	for <linux-mips@linux-mips.org>; Mon, 18 Nov 2002 05:20:28 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA19818
	for <linux-mips@linux-mips.org>; Mon, 18 Nov 2002 05:20:29 -0800 (PST)
Message-ID: <015201c28f05$cb583800$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <linux-mips@linux-mips.org>
Subject: Alignment of FP Context Storage
Date: Mon, 18 Nov 2002 14:24:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

I'm cleaning up some old Linux kernel sandboxes, and
came across a patch which I had long ago made in a
local copy of include/asm-mips/processor.h but which
does not seem to have been propagated more widely.
I had added "__attribute__((aligned(8))))" to the
declarations of the mips_fpu_hard_struct and
mips_fpu_soft_struct data structures, presumably
because there was a need to ensure 64-bit alignment
of the elements so that LDC1 instructions would work.
We don't generally have a problem here, presumably
because either the previous data declarations naturally
align things to 64-bits, or because we've ensured things 
at a higher level of makfile compiler directives.  Are we 
in fact guarnateed to be safe without the source code 
directive, or should those __attribute__ directives be 
added as insurance?

            Kevin K.
