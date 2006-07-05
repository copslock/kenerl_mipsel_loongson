Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jul 2006 14:34:30 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:9950 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133380AbWGENeT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Jul 2006 14:34:19 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 3E6234455E; Wed,  5 Jul 2006 15:34:18 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1Fy7W3-0008Hb-Qo; Wed, 05 Jul 2006 14:34:07 +0100
Date:	Wed, 5 Jul 2006 14:34:07 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix build failure in sb1250_duart.c
Message-ID: <20060705133407.GE29112@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

this fixes a build failure caused by the devfs removal.


Thiemo


Signed-off-by: Thiemo Seufer <ths@networkno.de>


--- a/drivers/char/sb1250_duart.c
+++ b/drivers/char/sb1250_duart.c
@@ -763,7 +763,6 @@ static int __init sb1250_duart_init(void
 
 	sb1250_duart_driver->owner = THIS_MODULE;
 	sb1250_duart_driver->name = "duart";
-	sb1250_duart_driver->devfs_name = "duart/";
 	sb1250_duart_driver->major = TTY_MAJOR;
 	sb1250_duart_driver->minor_start = SB1250_DUART_MINOR_BASE;
 	sb1250_duart_driver->type            = TTY_DRIVER_TYPE_SERIAL;
