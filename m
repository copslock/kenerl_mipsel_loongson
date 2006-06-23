Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 11:02:45 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:27873 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133504AbWFWKAa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 11:00:30 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id F20EEC05F;
	Fri, 23 Jun 2006 12:00:17 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id 1045D1BC087;
	Fri, 23 Jun 2006 12:00:19 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 59DDC1A18B2;
	Fri, 23 Jun 2006 12:00:19 +0200 (CEST)
Date:	Fri, 23 Jun 2006 12:00:21 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [patch 5/8] au1xxx: export dbdma functions
Message-ID: <20060623100021.GE31017@domen.ultra.si>
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
X-archive-position: 11817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

These are needed for au1550_ac97 module.

Signed-off-by: Domen Puncer <domen.puncer@ultra.si>

 arch/mips/au1000/common/dbdma.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-mailed/arch/mips/au1000/common/dbdma.c
===================================================================
--- linux-mailed.orig/arch/mips/au1000/common/dbdma.c
+++ linux-mailed/arch/mips/au1000/common/dbdma.c
@@ -730,6 +730,8 @@ au1xxx_dbdma_get_dest(u32 chanid, void *
 	return rv;
 }
 
+EXPORT_SYMBOL(au1xxx_dbdma_get_dest);
+
 void
 au1xxx_dbdma_stop(u32 chanid)
 {
@@ -821,6 +823,8 @@ au1xxx_get_dma_residue(u32 chanid)
 	return rv;
 }
 
+EXPORT_SYMBOL(au1xxx_get_dma_residue);
+
 void
 au1xxx_dbdma_chan_free(u32 chanid)
 {
