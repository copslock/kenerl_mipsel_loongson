Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Sep 2002 09:49:24 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:49797 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123899AbSIXHtX>;
	Tue, 24 Sep 2002 09:49:23 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g8O7n7rZ001883
	for <linux-mips@linux-mips.org>; Tue, 24 Sep 2002 00:49:07 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA07450
	for <linux-mips@linux-mips.org>; Tue, 24 Sep 2002 00:49:27 -0700 (PDT)
Message-ID: <008801c2639f$385b1b80$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <linux-mips@linux-mips.org>
Subject: FCSR Management
Date: Tue, 24 Sep 2002 09:51:18 +0200
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
X-archive-position: 261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

In looking at some anomalous behavior on another software
platform, I checked the current MIPS/Linux kernel sources
and I wonder if we don't have yet another FP context problem
lurking under the surface.

On most, if not all, MIPS CPUs with integrated FPUs,
the act of writing a value to the FP CSR (Control and
Status Register, fcr31) which has the "E" bit, or any matching
pair of Enable/Cause bits for the V/Z/O/U/I IEEE exceptions
set will trigger a floating point exception.  In the case of
the Unimplemented Operation exception (the "E" bit),
the emulator is invoked and all of the Cause bits are cleared
in the context before user execution is resumed.  In the
case of other FP exceptions, the default behavior is to
dump core, so the user never executes again.  But *if*
the user has registered a handler for SIGFPE, and one
of the IEEE exceptions occurs, I don't see where the
associated Cause bit is being cleared, and I would think
that the consequence would be that the process would
get into an endless loop of trapping, posting the signal,
restoring the FCSR from the context with the bits set,
and trapping again, whether or not the PC is modified
to avoid re-executing the faulting instruction.

Am I missing something, or is this a problem?

            Regards,

            Kevin K.
