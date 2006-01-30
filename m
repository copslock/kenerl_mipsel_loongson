Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2006 14:09:45 +0000 (GMT)
Received: from smtp18.wanadoo.fr ([193.252.22.126]:23278 "EHLO
	smtp18.wanadoo.fr") by ftp.linux-mips.org with ESMTP
	id S8133558AbWA3OJ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Jan 2006 14:09:28 +0000
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1807.wanadoo.fr (SMTP Server) with ESMTP id AD7107000091
	for <linux-mips@linux-mips.org>; Mon, 30 Jan 2006 15:14:16 +0100 (CET)
Received: from lexbox.fr (AToulouse-254-1-72-91.w81-49.abo.wanadoo.fr [81.49.99.91])
	by mwinf1807.wanadoo.fr (SMTP Server) with ESMTP id 7D6B9700008E
	for <linux-mips@linux-mips.org>; Mon, 30 Jan 2006 15:14:16 +0100 (CET)
X-ME-UUID: 20060130141416513.7D6B9700008E@mwinf1807.wanadoo.fr
Subject: [PATCH] Au1xx0: really set KSEG0 to uncached on reboot
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date:	Mon, 30 Jan 2006 15:10:59 +0100
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <17AB476A04B7C842887E0EB1F268111E02740C@xpserver.intra.lexbox.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Au1xx0: really set KSEG0 to uncached on reboot
Thread-Index: AcYlpv7wQZ9RDVqOTYKd+xVg6GWQnw==
From:	"David Sanchez" <david.sanchez@lexbox.fr>
To:	<linux-mips@linux-mips.org>
Return-Path: <david.sanchez@lexbox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.sanchez@lexbox.fr
Precedence: bulk
X-list: linux-mips


Hi,

The patch doesn't work for Au1550. Since I apply it my DbAu1550 frees on
restart.

David
