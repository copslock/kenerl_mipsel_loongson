Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2005 10:09:34 +0100 (BST)
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([IPv6:::ffff:82.235.130.100]:38890
	"EHLO lexbox.fr") by linux-mips.org with ESMTP id <S8225970AbVHPJJM> convert rfc822-to-8bit;
	Tue, 16 Aug 2005 10:09:12 +0100
Subject: DB AU1550 and safeXcel DMA burst problem
Date:	Tue, 16 Aug 2005 11:11:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <17AB476A04B7C842887E0EB1F268111E026ED5@xpserver.intra.lexbox.org>
X-MS-Has-Attach: 
Content-class: urn:content-classes:message
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Thread-Topic: DB AU1550 and safeXcel DMA burst problem
thread-index: AcWiQoMIn9Tw9AzoTo2mhR3Tif7Ebg==
From:	"David Sanchez" <david.sanchez@lexbox.fr>
To:	<linux-mips@linux-mips.org>
Return-Path: <david.sanchez@lexbox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.sanchez@lexbox.fr
Precedence: bulk
X-list: linux-mips

Hi, 

I'm using the Security Engine of the DB AU1550 to compute SHA1 on files.

All is working fine but if I use a DMA burst greater than 8 words the
resulting SHA1 is incorrect !

Do you have the same behaviour ? Do you have an explanation of such a
behaviour ? Is it a HW bug ?

Thanks,

David
