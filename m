Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jan 2003 16:49:32 +0000 (GMT)
Received: from smtp-send.myrealbox.com ([IPv6:::ffff:192.108.102.143]:7725
	"EHLO smtp-send.myrealbox.com") by linux-mips.org with ESMTP
	id <S8225233AbTAPQtb>; Thu, 16 Jan 2003 16:49:31 +0000
Received: from Crusty yaelgilad@smtp-send.myrealbox.com [194.90.64.161]
	by smtp-send.myrealbox.com with NetMail SMTP Agent $Revision:   3.22  $ on Novell NetWare;
	Thu, 16 Jan 2003 09:49:24 -0700
From: "Gilad Benjamini" <yaelgilad@myrealbox.com>
To: <linux-mips@linux-mips.org>
Subject: Getting Time Difference
Date: Thu, 16 Jan 2003 18:48:09 +0200
Message-ID: <ECEPLLMMNGHMFBLHCLMAGEGDDIAA.yaelgilad@myrealbox.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <yaelgilad@myrealbox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yaelgilad@myrealbox.com
Precedence: bulk
X-list: linux-mips

Hi,
I am porting code from a x86 platform.
That code uses rdtsc and cpu_khz to compute
the time difference between two events. Jiffies aren't good enough in this 
case.

Looking through header files I can find a few MIPS replacements.
What is the "right" one to use ?

What is the best way to change the code so it can compile
and run on both platforms ?
