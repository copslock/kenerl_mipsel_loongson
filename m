Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 07:56:11 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:44905 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492150AbZLAG4E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 07:56:04 +0100
Received: by pwi15 with SMTP id 15so2461277pwi.24
        for <multiple recipients>; Mon, 30 Nov 2009 22:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=B//V9feMDCkW5htre6axPFXbRjuVbVmhm1RjhNp7kVg=;
        b=QdYx1HNlpOORWHaaolTFjJubLOBTdRtO4C6Pzppvlu9Ik2nWcFETBvTU9AW+3QJ1nk
         3ztlYtJrZw21/k4rw2EM9N/BSeJ9RUEsMki6KV5b6GU+1gdxWQ+sEMARJ7fezGoqA1d0
         1tovsnYoWBMSon9AjBPEy0C98AxuLNRw5p9RI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=g13fg5bicZjvpNuH6em0Cgxo6DLM0dhPjx3hG+FLbgzAOA9FnntxC2y02B0jtJUIgD
         Q0l3bPJTSda38iKXa4mtLC6FAb1+6Gh6fi7xc1heOh7m4Q3IfGZwTuoD6DnHIPBeKik8
         szXYvj9qnRNEF5Gey5QFgl1TPG87sKbz51GLk=
Received: by 10.114.214.36 with SMTP id m36mr9990175wag.172.1259650553684;
        Mon, 30 Nov 2009 22:55:53 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm67503pxi.6.2009.11.30.22.55.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Nov 2009 22:55:53 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 2/2] Loongson: disable FLATMEM
Date:   Tue,  1 Dec 2009 14:55:42 +0800
Message-Id: <1259650542-31922-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

With FLATMEM, The STD(Hibernation) for Loongson will fail, and there are
also some other problems(break the files) when using NFS or CIFS(samba).

And as the config help of SPARSEMEM says:

"This option provides some potential performance benefits, along with
decreased code complexity."

So, to avoid the potential problems of FLATMEM, we disable FLATMEM
directly and use SPARSEMEM instead.

Relative Email thread:

http://groups.google.com/group/loongson-dev/browse_thread/thread/b6b65890ec2b0f24/feb43e5aa7f55d9b?show_docid=feb43e5aa7f55d9b

Reported-by: Tatu Kilappa <tatu.kilappa@gmail.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8bf36d2..0be245d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1835,7 +1835,7 @@ config SYS_SUPPORTS_SMARTMIPS
 
 config ARCH_FLATMEM_ENABLE
 	def_bool y
-	depends on !NUMA
+	depends on !NUMA && !CPU_LOONGSON2
 
 config ARCH_DISCONTIGMEM_ENABLE
 	bool
-- 
1.6.2.1
