Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2004 12:25:55 +0100 (BST)
Received: from wip-ec-wd.wipro.com ([IPv6:::ffff:203.101.113.39]:13774 "EHLO
	wip-ec-wd.wipro.com") by linux-mips.org with ESMTP
	id <S8224942AbUJFLZv> convert rfc822-to-8bit; Wed, 6 Oct 2004 12:25:51 +0100
Received: from wip-ec-wd.wipro.com (localhost.wipro.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id 225B120560
	for <linux-mips@linux-mips.org>; Wed,  6 Oct 2004 16:52:26 +0530 (IST)
Received: from blr-ec-bh1.wipro.com (unknown [10.200.50.91])
	by wip-ec-wd.wipro.com (Postfix) with ESMTP id 0266220551
	for <linux-mips@linux-mips.org>; Wed,  6 Oct 2004 16:52:26 +0530 (IST)
Received: from chn-snr-bh1.wipro.com ([10.145.50.91]) by blr-ec-bh1.wipro.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 6 Oct 2004 16:55:17 +0530
Received: from chn-snr-msg.wipro.com ([10.145.50.99]) by chn-snr-bh1.wipro.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 6 Oct 2004 16:55:10 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: __up, __down_trylock & __down_interruptible for MIPS
Date: Wed, 6 Oct 2004 16:55:10 +0530
Message-ID: <6BF015B686198842A1C8F84F4B7E6D2601276A0F@chn-snr-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: __up, __down_trylock & __down_interruptible for MIPS
thread-index: AcSrk2KzmoZ0U8LBQwaW8X21yX2/eQ==
From: <priya.mani@wipro.com>
To: <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 06 Oct 2004 11:25:11.0119 (UTC) FILETIME=[24552DF0:01C4AB97]
Return-Path: <priya.mani@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: priya.mani@wipro.com
Precedence: bulk
X-list: linux-mips

Hi 

I need to build a driver on the kernel version 2.4.22 on Mips
architecture ( I am using an AMD board). When I try to insmod the driver
it gives unresolved symbols for "__up, __down_trylock &
__down_interruptible". 

I checked in the semaphore.c file under kernel/arch/mips. The above
symbols are neither defined nor exported while they are done for the
semaphore files under other arch like sparc, sh, alpha etc.

If I try to use the functions from the latest CVS files in the mips-org
site it gives other compilation errors.

Please can you tell me how do I go about this problem. Have the above
functions been obsoleted? Is there any patch available for them? Or is
there any doc explaining this? I am using Kernel version 2.4.22.

Can anybody help me out with this please.

Rgds
Priya
