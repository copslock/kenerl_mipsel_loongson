Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 09:00:59 +0100 (BST)
Received: from [IPv6:::ffff:222.98.69.125] ([IPv6:::ffff:222.98.69.125]:31459
	"EHLO torinet.co.kr") by linux-mips.org with ESMTP
	id <S8225305AbUDWIA5> convert rfc822-to-8bit; Fri, 23 Apr 2004 09:00:57 +0100
Received: from jhdew ([222.98.69.113])
	by torinet.co.kr (8.12.8/8.12.8) with ESMTP id i3N8px5i009307
	for <linux-mips@linux-mips.org>; Fri, 23 Apr 2004 17:51:59 +0900
From: =?ks_c_5601-1987?B?wOXB+Mit?= <jhdew@torinet.co.kr>
To: <linux-mips@linux-mips.org>
Subject: Problem with 64-bit kernel in SB1250 processor board.
Date: Fri, 23 Apr 2004 17:01:09 +0900
Message-ID: <000601c42909$236b5e20$714562de@jhdew>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Return-Path: <jhdew@torinet.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhdew@torinet.co.kr
Precedence: bulk
X-list: linux-mips

Hello,

I¡¯m testing SB1250 processor board with 64bits linux kernel.
I used last source(linux-2.4.21) from Broadcom sibyte site.

But, when I did ping flooding 2-3 times (back ground running) to any
host system from my board, it panics. (mainly page fault error)
With 32bit linux kernel, no panic. Any idea?
How stable SB1250 processor in 64-bit linux kernel?

I doubt paging management of SB1250 in 64-bit kernel.
Any idea?

From Jang
+++++++++++++++++++++++++++++++++++
www.torinet.co.kr
jhdew@torinet.co.kr
+82-31-708-7072
+++++++++++++++++++++++++++++++++++
