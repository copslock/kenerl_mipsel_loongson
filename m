Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 11:01:48 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:21985 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133512AbWFWJ74 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 10:59:56 +0100
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 61697C051;
	Fri, 23 Jun 2006 11:59:45 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 039221BC093;
	Fri, 23 Jun 2006 11:59:47 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id E5F0B1A18B9;
	Fri, 23 Jun 2006 11:59:47 +0200 (CEST)
Date:	Fri, 23 Jun 2006 11:59:50 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [patch 4/8] au1xxx: dbdma, no sleeping under spin_lock
Message-ID: <20060623095950.GD31017@domen.ultra.si>
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
X-archive-position: 11816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

kmalloc under spin_lock can't sleep.


Signed-off-by: Domen Puncer <domen.puncer@ultra.si>

Index: linux-mailed/arch/mips/au1000/common/dbdma.c
===================================================================
--- linux-mailed.orig/arch/mips/au1000/common/dbdma.c
+++ linux-mailed/arch/mips/au1000/common/dbdma.c
@@ -290,7 +290,7 @@ au1xxx_dbdma_chan_alloc(u32 srcid, u32 d
 				/* If kmalloc fails, it is caught below same
 				 * as a channel not available.
 				 */
-				ctp = kmalloc(sizeof(chan_tab_t), GFP_KERNEL);
+				ctp = kmalloc(sizeof(chan_tab_t), GFP_ATOMIC);
 				chan_tab_ptr[i] = ctp;
 				break;
 			}
