Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 08:53:00 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:18714 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021908AbXC1Hwf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 08:52:35 +0100
Received: by nf-out-0910.google.com with SMTP id q29so2672130nfc
        for <linux-mips@linux-mips.org>; Wed, 28 Mar 2007 00:51:35 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=sakjqrabotrKktXTQ0ChNisXej4vAXK1uLhydHsRma9MUYKY+HuxyZoZafqznOdAv4/3XbRi+FfuHGhsB83IHL+3krfE+2Fo824svRSvwyj7GQx7q99784mHQwlCPWU8OQU9WGYPQQv6RwP82npZqqqYXbRQOox7zFYcF9kPW2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=ns80NuXa2g0fY9olQu6O+KmasVyHesZ8fVZf/75gOS3FNWcgqIqZxsceC4rqhPgb+mMlRXIMqmTJqwv8K2pnQKb/R3quit7THSnq2G9QWfMTflWZXpF4jf1/bVq4/Na1vDCKnSBM4+qvpfYcA4mdlc951eSA3WCH1xpDTEZ0Rgw=
Received: by 10.82.110.4 with SMTP id i4mr314391buc.1175068294661;
        Wed, 28 Mar 2007 00:51:34 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id c24sm22444170ika.2007.03.28.00.51.33;
        Wed, 28 Mar 2007 00:51:33 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 5803023F76E; Wed, 28 Mar 2007 08:51:30 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 2/2] early_printk: allow the early console to run earlier
Date:	Wed, 28 Mar 2007 08:51:30 +0200
Message-Id: <11750646903145-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.rc1.27.g1d848
In-Reply-To: <11750646902981-git-send-email-fbuihuu@gmail.com>
References: <20070327175733.GA26496@linux-mips.org> <11750646902981-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/early_printk.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/early_printk.c b/arch/mips/kernel/early_printk.c
index 57ba73a..f68f82f 100644
--- a/arch/mips/kernel/early_printk.c
+++ b/arch/mips/kernel/early_printk.c
@@ -30,8 +30,14 @@ static struct console early_console __initdata = {
 	.index	= -1
 };
 
+static int early_console_initialized __initdata;
+
 void __init setup_early_printk(void)
 {
+	if (early_console_initialized)
+		return;
+	early_console_initialized = 1;
+
 	register_console(&early_console);
 }
 
-- 
1.5.1.rc1.27.g1d848
