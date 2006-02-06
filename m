Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2006 08:08:36 +0000 (GMT)
Received: from smtp4.wanadoo.fr ([193.252.22.27]:18501 "EHLO smtp4.wanadoo.fr")
	by ftp.linux-mips.org with ESMTP id S8133462AbWBFII1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Feb 2006 08:08:27 +0000
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0401.wanadoo.fr (SMTP Server) with ESMTP id DBF171C00313
	for <linux-mips@linux-mips.org>; Mon,  6 Feb 2006 09:13:53 +0100 (CET)
Received: from lexbox.fr (AToulouse-254-1-22-161.w81-250.abo.wanadoo.fr [81.250.29.161])
	by mwinf0401.wanadoo.fr (SMTP Server) with ESMTP id C01B71C002EE;
	Mon,  6 Feb 2006 09:13:53 +0100 (CET)
X-ME-UUID: 20060206081353786.C01B71C002EE@mwinf0401.wanadoo.fr
Subject: RE: [PATCH] Au1xx0: really set KSEG0 to uncached on reboot
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date:	Mon, 6 Feb 2006 09:10:37 +0100
Content-class: urn:content-classes:message
Message-ID: <17AB476A04B7C842887E0EB1F268111E027447@xpserver.intra.lexbox.org>
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Au1xx0: really set KSEG0 to uncached on reboot
Thread-Index: AcYpIisf4ajWFKCtRBS4mw0e3t+cvwB0Tsog
From:	"David Sanchez" <david.sanchez@lexbox.fr>
To:	"Sergei Shtylylov" <sshtylyov@ru.mvista.com>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <david.sanchez@lexbox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.sanchez@lexbox.fr
Precedence: bulk
X-list: linux-mips

Hi,

This is exactly what I did...
But I notice that sometimes it works and sometimes the kernel frees when 
"** Resetting Integrated Peripherals"

Regards,

David SANCHEZ
 LexBox, The Digital Evidence

Parc d'Activités de Basso Cambo
42, Avenue du Général de Croutte
31100 TOULOUSE / FRANCE

david.sanchez@lexbox.fr
Tél :     +33 (0)5 62 47 15 81
Fax :    +33 (0)5 62 47 15 84



-----Message d'origine-----
De : Sergei Shtylylov [mailto:sshtylyov@ru.mvista.com] 
Envoyé : samedi 4 février 2006 01:30
À : David Sanchez
Cc : linux-mips@linux-mips.org
Objet : Re: [PATCH] Au1xx0: really set KSEG0 to uncached on reboot

Hello.

David Sanchez wrote:

> The patch doesn't work for Au1550. Since I apply it my DbAu1550 frees on
> restart.

    Just tried 'reboot' command on a fresh kernel with this patch and NFP 
userland -- it worked well.

> David

WBR, Sergei
