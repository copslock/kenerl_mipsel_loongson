Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Feb 2005 09:36:51 +0000 (GMT)
Received: from go4.ext.ti.com ([IPv6:::ffff:192.91.75.132]:9140 "EHLO
	go4.ext.ti.com") by linux-mips.org with ESMTP id <S8224936AbVBAJgf> convert rfc822-to-8bit;
	Tue, 1 Feb 2005 09:36:35 +0000
Received: from dlep91.itg.ti.com ([157.170.152.55])
	by go4.ext.ti.com (8.13.1/8.13.1) with ESMTP id j119aXNs028229
	for <linux-mips@linux-mips.org>; Tue, 1 Feb 2005 03:36:34 -0600 (CST)
Received: from dbde2k01.ent.ti.com (localhost [127.0.0.1])
	by dlep91.itg.ti.com (8.12.11/8.12.11) with ESMTP id j119aTK6022461
	for <linux-mips@linux-mips.org>; Tue, 1 Feb 2005 03:36:32 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Dealing with RAM not starting at 0x00000000
Date:	Tue, 1 Feb 2005 15:06:29 +0530
Message-ID: <F6B01C6242515443BB6E5DDD63AE935F04682B@dbde2k01.itg.ti.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Dealing with RAM not starting at 0x00000000
Thread-Index: AcUIQYDxSU+CaFtEQZGvJDQANn3N3w==
From:	"Nori, Soma Sekhar" <nsekhar@ti.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <nsekhar@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nsekhar@ti.com
Precedence: bulk
X-list: linux-mips

Hi All,

I am working towards porting 2.6.10 kernel on a mips 4kec based board
which has physical memory starting at 0x14000000.
What is the best way to overcome the "hole" from 0x00000000 to
0x14000000 without incuring a huge memory overhead.
(For exception handling there is 4k of RAM kept at 0x00000000 also - but
I guess linux paging need need not be aware of this small RAM)

Any suggestions/pointers are greatly appreciated. 

Thanks,
Sekhar
