Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2004 01:07:38 +0000 (GMT)
Received: from nssinet2.co-nss.co.jp ([IPv6:::ffff:150.96.0.5]:31904 "EHLO
	nssinet2.co-nss.co.jp") by linux-mips.org with ESMTP
	id <S8224990AbULGBHd>; Tue, 7 Dec 2004 01:07:33 +0000
Received: from nssinet2.co-nss.co.jp (localhost [127.0.0.1])
	by nssinet2.co-nss.co.jp (8.9.3/3.7W) with ESMTP id KAA06155
	for <linux-mips@linux-mips.org>; Tue, 7 Dec 2004 10:03:19 +0900 (JST)
Received: from nssnet.co-nss.co.jp (nssnet.co-nss.co.jp [150.96.64.250])
	by nssinet2.co-nss.co.jp (8.9.3/3.7W) with ESMTP id KAA06151
	for <linux-mips@linux-mips.org>; Tue, 7 Dec 2004 10:03:19 +0900 (JST)
Received: from NUNOE ([150.96.160.60])
	by nssnet.co-nss.co.jp (8.9.3+Sun/3.7W) with SMTP id JAA03088
	for <linux-mips@linux-mips.org>; Tue, 7 Dec 2004 09:54:17 +0900 (JST)
Message-ID: <001101c4dbf9$1da02270$3ca06096@NUNOE>
From: "Hdei Nunoe" <nunoe@co-nss.co.jp>
To: <linux-mips@linux-mips.org>
Subject: HIGHMEM
Date: Tue, 7 Dec 2004 10:07:26 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Return-Path: <nunoe@co-nss.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nunoe@co-nss.co.jp
Precedence: bulk
X-list: linux-mips

Hi there,

Has anyone succeeded the HIGHMEM with discontiguous physical memory?
I am using kernel 2.4.18 on TX4937 with two chunks of 256Mbyte memory.
There is 256Mbyte gap in between the physical memory blocks - lower 
memory is 0x00000000 to 0x10000000, upper memory is 0x20000000 to
0x30000000.  System hungs when it create INIT process.

Cheers,
-hdei
