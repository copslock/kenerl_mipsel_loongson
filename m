Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2004 16:03:28 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:31175
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225258AbUGNPDX>; Wed, 14 Jul 2004 16:03:23 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id i6EF3Eko010422;
	Wed, 14 Jul 2004 08:03:14 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.11/8.12.11) with SMTP id i6EF3CWR021983;
	Wed, 14 Jul 2004 08:03:13 -0700 (PDT)
Message-ID: <003001c469b4$3b5ae960$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <a.voropay@vmb-service.ru>, <linux-mips@linux-mips.org>
References: <07d301c469a9$e708f550$0200000a@ALEC>
Subject: Re: MS VC++ compiler / MIPS
Date: Wed, 14 Jul 2004 17:07:06 +0200
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

If I recall correctly, the MS compiler uses a subltly different
calling convention/ABI than the "o32" gcc conventions assumed
by MIPS Linux, and certainly the assembler directives will be
different from those assumed by the Linux sources.  It *might*
be possible to hack up a MIPS Linux kernel source tree to
build with the MS tool kit, but it would be a lot of work, 
some of it subtle.

            Regards,

            Kevin K.
