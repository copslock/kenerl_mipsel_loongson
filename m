Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 06:53:53 +0100 (BST)
Received: from mx1.tusur.ru ([IPv6:::ffff:212.192.163.19]:54543 "EHLO tusur.ru")
	by linux-mips.org with ESMTP id <S8224912AbUHRFxt>;
	Wed, 18 Aug 2004 06:53:49 +0100
Received: from localhost (localhost.tusur.ru [127.0.0.1])
	by tusur.ru (Postfix) with SMTP id 81F02B8818;
	Wed, 18 Aug 2004 12:49:14 +0700 (TSD)
X-AV-Checked: Wed Aug 18 12:49:14 2004 Ok
Received: from roman (unknown [211.189.34.20])
	by tusur.ru (Postfix) with ESMTP id 9DB68B853B;
	Wed, 18 Aug 2004 12:49:08 +0700 (TSD)
Message-ID: <002701c484e7$af440980$1422bdd3@roman>
From: "Roman Mashak" <mrv@tusur.ru>
To: <Saugata.Chatterjee@taec.toshiba.com>, <linux-mips@linux-mips.org>
References: <OFBBD37EA1.A7922B89-ON88256EF3.005D0F89-88256EF3.005D49DB@taec.com>
Subject: Re: Yamon compiling and linking
Date: Wed, 18 Aug 2004 14:53:18 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1081
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1081
FL-Build: Fidolook 2002 (SL) 6.0.2800.85 - 28/1/2003 19:07:30
X-Spam-DCC: : 
Return-Path: <mrv@tusur.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrv@tusur.ru
Precedence: bulk
X-list: linux-mips

Hello, Saugata.Chatterjee@taec.toshiba.com!
You wrote to "Roman Mashak" <mrv@tusur.ru> on Tue, 17 Aug 2004
09:58:57 -0700:

SC> Reset code (reset.S) IS compiled and linked (at bfc00000 like it should
SC> be), and pretty early on in there YAMON detects endianness and jumps to
the
SC> location of the appropriate endian image. Dump the output of make to a
log
SC> file and look for the compilation of reset.S.

I have already investigated the 'makefile' and 'make' dump - and I've found
that reset code is compiled only in one case - when I compile both LE and BE
images.

Yes, I'm using AMD modified code and perhaps this is the reason, but their
support didn't answer yet.

Anyway - thank you for spending time for me.

With best regards, Roman Mashak.  E-mail: mrv@tusur.ru
