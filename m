Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 14:32:44 +0000 (GMT)
Received: from mail.romat.com ([IPv6:::ffff:212.143.245.3]:15887 "EHLO
	mail.romat.com") by linux-mips.org with ESMTP id <S8225007AbUKXOck>;
	Wed, 24 Nov 2004 14:32:40 +0000
Received: from localhost (localhost.lan [127.0.0.1])
	by mail.romat.com (Postfix) with ESMTP id 0AD8CEB2E8
	for <linux-mips@linux-mips.org>; Wed, 24 Nov 2004 16:32:33 +0200 (IST)
Received: from mail.romat.com ([127.0.0.1])
 by localhost (mail.romat.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22539-02 for <linux-mips@linux-mips.org>;
 Wed, 24 Nov 2004 16:32:30 +0200 (IST)
Received: from gilad (unknown [192.168.1.167])
	by mail.romat.com (Postfix) with ESMTP id ADF81EB2E4
	for <linux-mips@linux-mips.org>; Wed, 24 Nov 2004 16:32:29 +0200 (IST)
From: "Gilad Rom" <gilad@romat.com>
To: <linux-mips@linux-mips.org>
Subject: Au1500 Chip Select
Date: Wed, 24 Nov 2004 16:32:42 +0200
Organization: Romat Telecom
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcTSMnQQ8qjcZyX6QQ6R8aGtMP9b5Q==
Message-Id: <20041124143229.ADF81EB2E4@mail.romat.com>
X-Virus-Scanned: by amavisd-new at romat.com
Return-Path: <gilad@romat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilad@romat.com
Precedence: bulk
X-list: linux-mips

Hello,

I am trying to implement a simple program which
Will be used to communicate with an I/O peripheral 
Over CS1 (Chip select 1) of the au1500.

Has anyone ever attempted this? Could someone 
Point me to some sample code, perhaps? I am grepping
Through the kernel, yet having trouble locating
Chip-select specific code for reference.

Thanks,
Gilad.
