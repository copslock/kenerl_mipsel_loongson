Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2006 10:29:34 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:12739 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133816AbWFVJ3U (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Jun 2006 10:29:20 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 6F4F9BFE9
	for <linux-mips@linux-mips.org>; Thu, 22 Jun 2006 11:29:09 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id C354D1BC07E
	for <linux-mips@linux-mips.org>; Thu, 22 Jun 2006 11:29:11 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id CB70F1A18BA
	for <linux-mips@linux-mips.org>; Thu, 22 Jun 2006 11:29:11 +0200 (CEST)
Date:	Thu, 22 Jun 2006 11:29:13 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	linux-mips@linux-mips.org
Subject: [patch] au1550_ac97: spin_unlock in error path
Message-ID: <20060622092913.GA18607@domen.ultra.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

Error paths didn't spin_unlock.

Signed-off-by: Domen Puncer <domen.puncer@ultra.si>


Index: linux/sound/oss/au1550_ac97.c
===================================================================
--- linux.orig/sound/oss/au1550_ac97.c
+++ linux/sound/oss/au1550_ac97.c
@@ -214,7 +214,8 @@ rdcodec(struct ac97_codec *codec, u8 add
 	}
 	if (i == POLL_COUNT) {
 		err("rdcodec: read poll expired!");
-		return 0;
+		data = 0;
+		goto out;
 	}
 
 	/* wait for command done?
@@ -227,7 +228,8 @@ rdcodec(struct ac97_codec *codec, u8 add
 	}
 	if (i == POLL_COUNT) {
 		err("rdcodec: read cmdwait expired!");
-		return 0;
+		data = 0;
+		goto out;
 	}
 
 	data = au_readl(PSC_AC97CDC) & 0xffff;
@@ -238,6 +240,7 @@ rdcodec(struct ac97_codec *codec, u8 add
 	au_writel(PSC_AC97EVNT_CD, PSC_AC97EVNT);
 	au_sync();
 
+ out:
 	spin_unlock_irqrestore(&s->lock, flags);
 
 	return data;
