Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2008 07:05:35 +0100 (BST)
Received: from smtp3.infineon.com ([203.126.106.229]:10290 "EHLO
	smtp3.infineon.com") by ftp.linux-mips.org with ESMTP
	id S29047646AbYGAGF2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Jul 2008 07:05:28 +0100
X-SBRS:	None
Received: from unknown (HELO sinse301.ap.infineon.com) ([172.20.70.22])
  by smtp3.infineon.com with ESMTP; 01 Jul 2008 14:05:19 +0800
Received: from sinse303.ap.infineon.com ([172.20.70.24]) by sinse301.ap.infineon.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 1 Jul 2008 14:05:18 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Kmem_cache handling in linux-2.6.2x kernel.
Date:	Tue, 1 Jul 2008 14:05:17 +0800
Message-ID: <31E09F73562D7A4D82119D7F6C172986045B6E80@sinse303.ap.infineon.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kmem_cache handling in linux-2.6.2x kernel.
Thread-Index: AcjbQCezWLXpXWxBSj2JrUNDAJRvkw==
From:	<KokHow.Teh@infineon.com>
To:	<linux-mips@linux-mips.org>, <bookquestions@oreilly.com>
Cc:	<Bing-Tao.Xu@infineon.com>
X-OriginalArrivalTime: 01 Jul 2008 06:05:18.0988 (UTC) FILETIME=[706164C0:01C8DB40]
Return-Path: <KokHow.Teh@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KokHow.Teh@infineon.com
Precedence: bulk
X-list: linux-mips

Hi list;
	I have a question about kmem_cache implemented in Linux-2.6.2x
kernel. I have an application that allocates and free 64KByte chunks of
memory (32-byte aligned) quite often. Therefore, I create a lookaside
cache for that purpose and use kmem_cache_alloc(), kmem_cache_free() to
allocate and free the caches. The application works very well in this
model. However, my concern here is if kmem_cache_free() does return the
cache to the system-wide pool so that it could be used by other
applications when need arises; when system is low in memory resources,
for instance. This is a question about the internal workings of the
memory management system of the Linux-2.6.2x kernel as to how efficient
it manages this lookasie caches. The concern is valid because if this
lookaside cache is not managed well, i.e, it is not returned to the
system-wide pool of free memory pools to be used by other applications,
this will penalize the performace and throughput of the whole system due
to the dynamic behaviour of the utilization of system memory resources.
For example, other applications might be swapping in and out of the
harddisk and if the kmem_cache_free()'ed memory objects could be used by
these applications, it will help in this case to reduce the number of
swaps that happen, thereby freeing the CPU and/or DMA from doing the
swapping to do other critical tasks.

	Any insight and advice is appreciated.

Regards,
KH
