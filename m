Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 13:10:40 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:14963 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037686AbWJKMIz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Oct 2006 13:08:55 +0100
Received: by nf-out-0910.google.com with SMTP id a25so165411nfc
        for <linux-mips@linux-mips.org>; Wed, 11 Oct 2006 05:08:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=i4N2Jxwa+VALlobdMGp4w98izBzIvueuBsLVoGQzsv+NL8I1hN+SrnPN+BeXyPcHVu18wTuUQq8dxdBIXhxb3225m4vkHxzn5U1ZXizP+5VPurf7uOTBFTsBVbNAisQMgBQnAow7Qqc6WkkAxd++Zxan+7OpcbDo0AAV6GXjMmw=
Received: by 10.49.19.18 with SMTP id w18mr3080317nfi;
        Wed, 11 Oct 2006 05:08:55 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id h1sm4270601nfe.2006.10.11.05.08.55;
        Wed, 11 Oct 2006 05:08:55 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 6287823F772; Wed, 11 Oct 2006 14:08:46 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 5/5] setup.c: use __pa_symbol() where needed
Date:	Wed, 11 Oct 2006 14:08:45 +0200
Message-Id: <1160568526559-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <1160568525897-git-send-email-fbuihuu@gmail.com>
References: <1160568525897-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

It should fix the broken code in resource_init() too.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/setup.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 0e92b9b..0316e04 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -263,7 +263,7 @@ static void __init bootmem_init(void)
 	 * not selected. Once that done we can determine the low bound
 	 * of usable memory.
 	 */
-	reserved_end = max(init_initrd(), PFN_UP(__pa(&_end)));
+	reserved_end = max(init_initrd(), PFN_UP(__pa_symbol(&_end)));
 
 	/*
 	 * Find the highest page frame number we have available.
@@ -435,10 +435,10 @@ static void __init resource_init(void)
 	if (UNCAC_BASE != IO_BASE)
 		return;
 
-	code_resource.start = virt_to_phys(&_text);
-	code_resource.end = virt_to_phys(&_etext) - 1;
-	data_resource.start = virt_to_phys(&_etext);
-	data_resource.end = virt_to_phys(&_edata) - 1;
+	code_resource.start = __pa_symbol(&_text);
+	code_resource.end = __pa_symbol(&_etext) - 1;
+	data_resource.start = __pa_symbol(&_etext);
+	data_resource.end = __pa_symbol(&_edata) - 1;
 
 	/*
 	 * Request address space for all standard RAM.
-- 
1.4.2.3
