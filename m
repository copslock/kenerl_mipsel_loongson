Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2003 15:38:17 +0100 (BST)
Received: from host31.ipowerweb.com ([IPv6:::ffff:12.129.198.131]:65180 "EHLO
	host31.ipowerweb.com") by linux-mips.org with ESMTP
	id <S8225222AbTEOOiP>; Thu, 15 May 2003 15:38:15 +0100
Received: from rrcs-central-24-123-115-43.biz.rr.com ([24.123.115.43] helo=RADIUM)
	by host31.ipowerweb.com with esmtp (Exim 3.36 #1)
	id 19GJs1-0004WK-00
	for linux-mips@linux-mips.org; Thu, 15 May 2003 07:38:09 -0700
From: "Lyle Bainbridge" <lyle@zevion.com>
To: "'Linux MIPS mailing list'" <linux-mips@linux-mips.org>
Subject: RE: Power On Self Test and testing memory
Date: Thu, 15 May 2003 09:38:07 -0500
Message-ID: <000001c31aef$9b2624a0$0a01a8c0@RADIUM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <000001c31a8b$c3406720$0a01a8c0@RADIUM>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host31.ipowerweb.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - zevion.com
Return-Path: <lyle@zevion.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lyle@zevion.com
Precedence: bulk
X-list: linux-mips



> Where is does your stack start?  Seems to me that your
> stack pointer might start at around 0x80010000 and of

I meant 0xa0010000 (kseg1).  Of course that is still physically
at 0x80010000.
