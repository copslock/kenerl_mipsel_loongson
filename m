Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2003 17:50:13 +0100 (BST)
Received: from smtp120.tiscali.dk ([IPv6:::ffff:62.79.79.111]:31229 "EHLO
	smtp120.tiscali.dk") by linux-mips.org with ESMTP
	id <S8225548AbTJHQtl>; Wed, 8 Oct 2003 17:49:41 +0100
Received: from cpmail.dk.tiscali.com (mail.tiscali.dk [212.54.64.159])
	by smtp120.tiscali.dk (8.12.6p3/8.12.6) with ESMTP id h98Gnexs021345
	for <linux-mips@linux-mips.org>; Wed, 8 Oct 2003 18:49:40 +0200 (CEST)
	(envelope-from jh@hansen-telecom.dk)
Received: from jorg (62.79.30.226) by cpmail.dk.tiscali.com (6.7.018)
        id 3F79565D000DFECE for linux-mips@linux-mips.org; Wed, 8 Oct 2003 18:49:40 +0200
From: =?iso-8859-1?Q?J=F8rg_Ulrich_Hansen?= <jh@hansen-telecom.dk>
To: "Linux-Mips" <linux-mips@linux-mips.org>
Subject: What toolchain for vr4181
Date: Wed, 8 Oct 2003 18:49:32 +0200
Message-ID: <EIEHIDHKGJLNEPLOGOPOAEIGCFAA.jh@hansen-telecom.dk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Return-Path: <jh@hansen-telecom.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jh@hansen-telecom.dk
Precedence: bulk
X-list: linux-mips

Hi

I am about to start porting Linux to my hardware with an vr4181 processor.
The hardware is very close to the osprey architecture. Now my problem is
what toolchain to use.
I could do with an up to date opinion.

? gcc-2.95.3
? gcc-2.95.4
? egcs-1.1.2
? gcc-3.2
? binutils 2.13
? glibc 2.2.5
? Any patches
? http://www.ltc.com/~brad/mips/mips-cross-toolchain/index.html
? http://kegel.com/crosstool/

Where is a good starting point for a toolchain that will build and work?
I would prefere to build it my self because at a later state I might build
it under cygwin. But a prebuild does also have interest.

Kind regards Jorg
