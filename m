Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 06:51:10 +0100 (BST)
Received: from mx1.tusur.ru ([IPv6:::ffff:212.192.163.19]:15885 "EHLO tusur.ru")
	by linux-mips.org with ESMTP id <S8224912AbUHRFvG>;
	Wed, 18 Aug 2004 06:51:06 +0100
Received: from localhost (localhost.tusur.ru [127.0.0.1])
	by tusur.ru (Postfix) with SMTP id E02B4B87B6;
	Wed, 18 Aug 2004 12:46:28 +0700 (TSD)
X-AV-Checked: Wed Aug 18 12:46:28 2004 Ok
Received: from roman (unknown [211.189.34.20])
	by tusur.ru (Postfix) with ESMTP id CCDF0B87A9;
	Wed, 18 Aug 2004 12:46:26 +0700 (TSD)
Message-ID: <002601c484e7$4ea38e70$1422bdd3@roman>
From: "Roman Mashak" <mrv@tusur.ru>
To: "Chris Dearman" <chris@mips.com>, <linux-mips@linux-mips.org>
References: <001601c483fd$9e3ae180$1422bdd3@roman> <4121E1DF.9020801@mips.com>
Subject: Re: Yamon compiling and linking
Date: Wed, 18 Aug 2004 14:50:41 +0900
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
X-archive-position: 5665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrv@tusur.ru
Precedence: bulk
X-list: linux-mips

Hello, Chris!
You wrote to "Roman Mashak" <mrv@tusur.ru> on Tue, 17 Aug 2004 11:45:51
+0100:

 CD>    I think you are using modified YAMON sources... I can tell you how
 CD> the build process works for the distributed version of YAMON:

   Sorry, i didn't mention that  I'm using YAMON source code supplied with
AMD Alchemy  AU1550 dev. board. But I've already sent my questions to AMD
support, and didn't get reply for 3 days, that's why I asked here.
 CD>    Invoking make in the  yamon/bin directory build two YAMON images
 CD> (one big-endian & one little-endian) in the EB & EL subdirectories.  In
    Yes, absolutely correct
 CD> addition some endianess independent reset code (reset.o) is built in
 CD> yamon/bin. These three images are combined together to make a single
 CD> yamon-02.xx.rec image that can run in either endianess.
    In my case - NOT. So, if I invoke 'make srec_el' to build little-endian
only image I get only LE image located in the bin/EL directory and nothing
in the upper directory.
 CD>    If you're only interested in running little-endian you should be
 CD> able to simply combine the reset-02.xx.rec and EL/yamon-02.xx_el.rec
 CD> images.
    So, I have to compile reset code seperately and combine it with LE
according to your device.

With best regards, Roman Mashak.  E-mail: mrv@tusur.ru
