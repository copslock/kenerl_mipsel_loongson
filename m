Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Feb 2003 22:09:09 +0000 (GMT)
Received: from mms1.broadcom.com ([IPv6:::ffff:63.70.210.58]:17679 "EHLO
	mms1.broadcom.com") by linux-mips.org with ESMTP
	id <S8225197AbTBRWJJ>; Tue, 18 Feb 2003 22:09:09 +0000
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.0)); Tue, 18 Feb 2003 14:08:37 -0700
Received: from dtatlaturcotte (dhcp-10-24-65-229.atlanta.broadcom.com
 [10.24.65.229]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with SMTP id
 OAA24607 for <linux-mips@linux-mips.org>; Tue, 18 Feb 2003 14:08:46
 -0800 (PST)
Reply-to: turcotte@broadcom.com
From: "Maurice Turcotte" <turcotte@broadcom.com>
To: linux-mips@linux-mips.org
Subject: Exec from Memory
Date: Tue, 18 Feb 2003 17:08:51 -0500
Message-ID: <NDBBKEAAOJECIDBJKLIHCEOGCHAA.turcotte@broadcom.com>
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
X-WSS-ID: 124C716F1100235-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <turcotte@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: turcotte@broadcom.com
Precedence: bulk
X-list: linux-mips

Greetings:

I have a hypothetical linux-mips question posed by a colleage.

Suppose there is no file system available, since there is no disk. And
suppose that I had the capability to place an elf file in a known location
in memory. How would I execute it? It seems like exec really wants a file
name. BTW, this needs to run in use space, not kernel.

Any helpful pointers? Is there a FAQ that might address this?

mrt
