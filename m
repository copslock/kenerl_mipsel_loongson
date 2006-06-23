Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 11:05:58 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:39393 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133643AbWFWKBz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 11:01:55 +0100
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id B84F1C05F;
	Fri, 23 Jun 2006 12:01:44 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id 92D5D1BC084;
	Fri, 23 Jun 2006 12:01:46 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 936E31A18AE;
	Fri, 23 Jun 2006 12:01:46 +0200 (CEST)
Date:	Fri, 23 Jun 2006 12:01:49 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [patch 8/8] au1xxx: pcmcia: fix __init called from non-init
Message-ID: <20060623100148.GH31017@domen.ultra.si>
References: <20060623095703.GA30980@domen.ultra.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623095703.GA30980@domen.ultra.si>
User-Agent: Mutt/1.5.11+cvs20060126
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

This must not be marked __init, as it is called from 
au1x00_drv_pcmcia_probe.


Signed-off-by: Domen Puncer <domen.puncer@ultra.si>

Index: linux-mailed/drivers/pcmcia/au1000_db1x00.c
===================================================================
--- linux-mailed.orig/drivers/pcmcia/au1000_db1x00.c
+++ linux-mailed/drivers/pcmcia/au1000_db1x00.c
@@ -296,7 +296,7 @@ struct pcmcia_low_level db1x00_pcmcia_op
 	.socket_suspend		= db1x00_socket_suspend
 };
 
-int __init au1x_board_init(struct device *dev)
+int au1x_board_init(struct device *dev)
 {
 	int ret = -ENODEV;
 	bcsr->pcmcia = 0; /* turn off power, if it's not already off */
