Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2004 13:52:57 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.187]:54524
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225786AbUGHMww>; Thu, 8 Jul 2004 13:52:52 +0100
Received: from [212.227.126.162] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1BiYOQ-0003sj-00
	for linux-mips@linux-mips.org; Thu, 08 Jul 2004 14:52:50 +0200
Received: from [84.128.28.95] (helo=pegasus.thalreit)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1BiYOQ-0000xY-00
	for linux-mips@linux-mips.org; Thu, 08 Jul 2004 14:52:50 +0200
Received: from thalreit.dyndns.org (localhost.thalreit [127.0.0.1])
	by pegasus.thalreit (8.12.6/8.12.6) with SMTP id i68CqiDk079410
	for <linux-mips@linux-mips.org>; Thu, 8 Jul 2004 14:52:44 +0200 (CEST)
	(envelope-from Volker.Jahns@thalreit.de)
Received: from 194.59.120.11
        (SquirrelMail authenticated user volker)
        by thalreit.dyndns.org with HTTP;
        Thu, 8 Jul 2004 14:52:44 +0200 (CEST)
Message-ID: <33009.194.59.120.11.1089291164.squirrel@thalreit.dyndns.org>
Date: Thu, 8 Jul 2004 14:52:44 +0200 (CEST)
Subject: sharp mobilon hc-4100 
From: "Volker Jahns" <Volker.Jahns@thalreit.de>
To: linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3
Importance: Normal
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5b79f71352ef1364d4beaa70fe75636d
Return-Path: <Volker.Jahns@thalreit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Volker.Jahns@thalreit.de
Precedence: bulk
X-list: linux-mips

Linux on Sharp Mobilon HC-4100

I would like to have Linux boot on the Sharp HC-4100 and have tried a
couple of suitable kernels with the following outcome:

Booting
-------
netbsd tx3912               - netbsd 1.5.3 , keyboard functional
linux for philips velo      - vmlinux-2.4.0-test4-pre3 , keyboard not
functional


Booting, but framebuffer scrambled
----------------------------------
linux nino                  - vmlinux-2.4.17
linux sharp HC-4500/HC-4600 - vmlinux-2.3.21. vmlinux-2.3.47

I have tried to compile a kernel from versions - 2.4.20 and 2.4.0-test9 -
( sharp mobilon, philips velo, philips nino) which all boot but have the
framebuffer device scrambled.

Which kernel version is good to start from, and where would I find its code ?
Has somebody a working .config vor the Velo 500 available, so that I get
the correct options to have this damn framebuffer device working?


Please redirect, in case this should be the wrong place to post.
-- 
Volker Jahns, volker@thalreit.de, http://thalreit.de, DG7PM
