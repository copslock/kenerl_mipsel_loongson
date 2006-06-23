Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 14:52:21 +0100 (BST)
Received: from coderock.org ([193.77.147.115]:33987 "EHLO trashy.coderock.org")
	by ftp.linux-mips.org with ESMTP id S8133500AbWFWNwJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2006 14:52:09 +0100
Received: by trashy.coderock.org (Postfix, from userid 780)
	id 7F1F31470; Fri, 23 Jun 2006 15:52:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id DEDE8146F;
	Fri, 23 Jun 2006 15:52:05 +0200 (CEST)
Received: from localhost (coderock.org [193.77.147.115])
	by trashy.coderock.org (Postfix) with ESMTP id 5B36513E;
	Fri, 23 Jun 2006 15:52:03 +0200 (CEST)
Date:	Fri, 23 Jun 2006 15:52:02 +0200
From:	Domen Puncer <domen@coderock.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Domen Puncer <domen.puncer@ultra.si>, linux-mips@linux-mips.org
Subject: Re: [patch 5/8] au1xxx: export dbdma functions
Message-ID: <20060623135202.GA9098@nd47.coderock.org>
References: <20060623095703.GA30980@domen.ultra.si> <20060623100021.GE31017@domen.ultra.si> <20060623103343.GE5896@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623103343.GE5896@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <domen@coderock.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen@coderock.org
Precedence: bulk
X-list: linux-mips

These are needed for au1550_ac97 module.

Signed-off-by: Domen Puncer <domen.puncer@ultra.si>

Index: linux-mailed/arch/mips/au1000/common/dbdma.c
===================================================================
--- linux-mailed.orig/arch/mips/au1000/common/dbdma.c
+++ linux-mailed/arch/mips/au1000/common/dbdma.c
@@ -730,6 +730,8 @@ au1xxx_dbdma_get_dest(u32 chanid, void *
 	return rv;
 }
 
+EXPORT_SYMBOL_GPL(au1xxx_dbdma_get_dest);
+
 void
 au1xxx_dbdma_stop(u32 chanid)
 {
@@ -821,6 +823,8 @@ au1xxx_get_dma_residue(u32 chanid)
 	return rv;
 }
 
+EXPORT_SYMBOL_GPL(au1xxx_get_dma_residue);
+
 void
 au1xxx_dbdma_chan_free(u32 chanid)
 {
