Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Oct 2002 21:50:48 +0200 (CEST)
Received: from [209.116.120.7] ([209.116.120.7]:65291 "EHLO
	tnint11.telogy.design.ti.com") by linux-mips.org with ESMTP
	id <S1123891AbSJZTur>; Sat, 26 Oct 2002 21:50:47 +0200
Received: by tnint11.telogy.design.ti.com with Internet Mail Service (5.5.2653.19)
	id <R6SW5NFS>; Sat, 26 Oct 2002 15:48:28 -0400
Message-ID: <37A3C2F21006D611995100B0D0F9B73CBFE312@tnint11.telogy.design.ti.com>
From: "Zajerko-McKee, Nick" <nmckee@telogy.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: 
Date: Sat, 26 Oct 2002 15:48:27 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <nmckee@telogy.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nmckee@telogy.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm porting some code from x86 to mips(32) and noticed that in
include/asm-mips/siginfo.h differs from include/asm-i386/siginfo.h in the
order of elements of the sigchld structure.  Was this an oversight or a
design decision?  I would think that it would be desirable to be almost the
same as the x86 for userland ease of portability...
