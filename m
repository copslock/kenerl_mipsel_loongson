Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 11:14:54 +0100 (BST)
Received: from krt.tmd.ns.ac.yu ([IPv6:::ffff:147.91.177.65]:2025 "EHLO
	krt.neobee.net") by linux-mips.org with ESMTP id <S8226092AbVDKKOi>;
	Mon, 11 Apr 2005 11:14:38 +0100
Received: from localhost (localhost [127.0.0.1])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id j3BAEBZF023537
	for <linux-mips@linux-mips.org>; Mon, 11 Apr 2005 12:14:16 +0200
Received: from krt.neobee.net ([127.0.0.1])
 by localhost (krt.neobee.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 22496-08 for <linux-mips@linux-mips.org>;
 Mon, 11 Apr 2005 12:14:11 +0200 (CEST)
Received: from davidovic ([192.168.0.89])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id j3BADt1p023510
	for <linux-mips@linux-mips.org>; Mon, 11 Apr 2005 12:14:03 +0200
Message-Id: <200504111014.j3BADt1p023510@krt.neobee.net>
Reply-To: <mile.davidovic@micronasnit.com>
From:	"Mile Davidovic" <mile.davidovic@micronasnit.com>
To:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Toolchain question
Date:	Mon, 11 Apr 2005 12:13:50 +0200
Organization: MicronasNIT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcU+fyfcpgEcgq/8RNW7uTSJdHqoTg==
X-Virus-Scanned: by amavisd-new at krt.neobee.net
Return-Path: <mile.davidovic@micronasnit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mile.davidovic@micronasnit.com
Precedence: bulk
X-list: linux-mips

Hello all
I would like to port board (with MIPS 4kec) to latest linux 2.6 kernel.
Using porting guide 
from (http://www.linux-mips.org/wiki/index.php/Porting) I successfully made
console and
serial driver. But problem appears with first printk (in start_kernel) I got
exception.  

I used toolchain which uclibc buildroot script produced (gcc-3.4.2,
binutils-2.15.91.0.2),
and I am not sure is this correct combination.

From 
http://www.linux-mips.org/wiki/index.php/Toolchains I saw that next
recommendations:
1. SDE MIPS - unfortunately this is 2.9x compiler.
2. Mr. Rozycki offer only mipsel toolchain
3. Mr. Kegel's crosstool but from
http://kegel.com/crosstool/crosstool-0.31/buildlogs/ it seems that 
this toolchain is not good for MIPS.
4. Toolchain from ucLibc, I tried but I have trouble with.

So my question: which toolchains I have to use? 

Best regards Mile
