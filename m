Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Feb 2004 21:50:56 +0000 (GMT)
Received: from mx.mips.com ([IPv6:::ffff:206.31.31.226]:225 "EHLO mx.mips.com")
	by linux-mips.org with ESMTP id <S8225475AbUBVVux>;
	Sun, 22 Feb 2004 21:50:53 +0000
Received: from mercury.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.12.11/8.12.11) with ESMTP id i1MLgcmi024380;
	Sun, 22 Feb 2004 13:42:38 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.11/8.12.11) with SMTP id i1MLoigI008025;
	Sun, 22 Feb 2004 13:50:45 -0800 (PST)
Message-ID: <001001c3f98e$2270dcc0$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Eric Christopher" <echristo@redhat.com>,
	"Mark and Janice Juszczec" <juszczec@hotmail.com>
Cc:	<linux-mips@linux-mips.org>
References: <Law10-F39hgbi1Kigvf000046ac@hotmail.com> <1077477186.3636.34.camel@dzur.sfbay.redhat.com>
Subject: Re: r3000 instruction set
Date:	Sun, 22 Feb 2004 22:52:13 +0100
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> Other than the responses you've already gotten, likely you'll need to
> compile with -march=r3900(or -mcpu=r3900 if it's an old toolchain) since
> the 3900 is missing a couple of r3000 instructions iirc.

The 3900 family should run MIPS I code compiled for the R3000.

> If it's the 3912 I remember it also doesn't have an fpu, but I could be
> wrong there. If it is, then you need -msoft-float as well.

The 3912 has no FPU, but if you're running on any contemporary
MIPS/Linux kernel and library system, you neither need nor want
soft-float.  The kernel does FP instruction emulation.  Running soft-float
would make for faster, if larger, code, but requires that the whole
system, particularly glibc, be built for soft-float, which is rarely done
(and the last time I tried it, didin't quite work with the standard
glibc sources out-of-the-box). 
