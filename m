Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jan 2003 07:27:21 +0000 (GMT)
Received: from mxout3.netvision.net.il ([IPv6:::ffff:194.90.9.24]:51913 "EHLO
	mxout3.netvision.net.il") by linux-mips.org with ESMTP
	id <S8225943AbTAIH1U>; Thu, 9 Jan 2003 07:27:20 +0000
Received: from mail.riverhead.com ([194.90.64.163]) by mxout3.netvision.net.il
 (iPlanet Messaging Server 5.2 HotFix 1.08 (built Dec  6 2002))
 with ESMTP id <0H8F00HKNRDCAT@mxout3.netvision.net.il> for
 linux-mips@linux-mips.org; Thu, 09 Jan 2003 09:27:13 +0200 (IST)
Received: from Crusty (comp76.wanwall.com [10.0.0.76])
	by mail.riverhead.com (8.11.0/8.11.0) with SMTP id h097RhY08576	for
 <linux-mips@linux-mips.org>; Thu, 09 Jan 2003 09:27:43 +0200
Date: Thu, 09 Jan 2003 09:09:19 +0200
From: Gilad Benjamini <giladb@riverhead.com>
Subject: kgdb & mips-linux
To: linux-mips@linux-mips.org
Message-id: <ECEPLLMMNGHMFBLHCLMAMEDGDHAA.giladb@riverhead.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Content-type: text/plain; charset=windows-1255
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host:
 mail.riverhead.com
Return-Path: <giladb@riverhead.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giladb@riverhead.com
Precedence: bulk
X-list: linux-mips

After many efforts I was able to start a succesfull kgdb session.
However, each time I tell gdb to "continue", it receives a SIGTRAP
in process.c.
I was told that this is probably a yet un-resolved mips SMP issue.

Is this a known issue ?
Any workarounds or solutions ?

TIA
