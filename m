Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2003 20:32:45 +0000 (GMT)
Received: from mxout1.netvision.net.il ([IPv6:::ffff:194.90.9.20]:17292 "EHLO
	mxout1.netvision.net.il") by linux-mips.org with ESMTP
	id <S8226071AbTAHUco>; Wed, 8 Jan 2003 20:32:44 +0000
Received: from Crusty ([62.0.78.173]) by mxout1.netvision.net.il
 (iPlanet Messaging Server 5.2 HotFix 1.08 (built Dec  6 2002))
 with ESMTPA id <0H8E002TCX24WX@mxout1.netvision.net.il> for
 linux-mips@linux-mips.org; Wed, 08 Jan 2003 22:32:30 +0200 (IST)
Date: Wed, 08 Jan 2003 22:15:19 +0200
From: Gilad Benjamini <gilad@riverhead.com>
Subject: ksymoops and 64 bit mips
To: linux-mips@linux-mips.org
Message-id: <ECEPLLMMNGHMFBLHCLMAGEDGDHAA.gilad@riverhead.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Content-type: text/plain; charset=windows-1255
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Return-Path: <gilad@riverhead.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilad@riverhead.com
Precedence: bulk
X-list: linux-mips

I tried using ksymoops to analyze an oops on my 64 bit SMP mips kernel.
I am running ksymoops on x86 platform.

Initially I got a lot of garbage.
Upgrdaing to ksymoops 2.4.5 , and using the --truncate=1 and 
-t elf32-little reduced 
the amount of garbage, but still all the output shown
was "No symbol available".

Any additional things I should do ?

TIA
