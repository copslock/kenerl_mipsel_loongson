Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2015 22:27:16 +0100 (CET)
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36944 "EHLO
        mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007284AbbJ2V1Oi05Dn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2015 22:27:14 +0100
Received: by igbhv6 with SMTP id hv6so40400639igb.0;
        Thu, 29 Oct 2015 14:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Teul9x+450iyTSog0AMgH3/bHxPQzk7pO5b+VeCV9OI=;
        b=LteBjRO1trDDGLcYijue5ZvAt9EzqwrdbkYTctXV1LZohBY/cxJKSlv88rkoeQuqm+
         lLPMwfHUJynW63QTVY5YqcH+lYnTrPj37aUlm8PkxePkioTl/D3DUdg8MgeGphMD+YSB
         LWb1ky03J/mX9UR8kEId0vtoEDHi3aCCecfOiReqH18aOb4YqSmwRG1aEkv5eSKxkYsK
         GABP9wKJ0Vj+2i8mgOk/Y6ZqF8HsPPDhyz8u3g2zTK5DTNqNUYs/SRXnx2os68pS1tea
         5QLngNQjGIH9oDydGUethgOQ0bWTXWLkXCB1GnxoSmTEJl5gTuni/nbt/q23xG2fKP9a
         2ejQ==
X-Received: by 10.50.67.79 with SMTP id l15mr13395486igt.9.1446153699005;
        Thu, 29 Oct 2015 14:21:39 -0700 (PDT)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id e8sm1657297igl.9.2015.10.29.14.21.36
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 29 Oct 2015 14:21:37 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id t9TLLZ8k013836;
        Thu, 29 Oct 2015 14:21:35 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id t9TLLX6Q013835;
        Thu, 29 Oct 2015 14:21:33 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     ralf@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Add config option to disable ELF NOTE segments
Date:   Thu, 29 Oct 2015 14:21:32 -0700
Message-Id: <1446153692-13803-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

Pre-SDK-1.8.1 bootloaders can not handel PT_NOTE program headers, so
we by default will not emit them.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

This patch is not against the current HEAD, so if someone like it it
would have to be forward ported, and tested.  Probably removing the
Kconfig option is a good idea too.

 arch/mips/kernel/vmlinux.lds.S | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 05826d2..457a785 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -17,7 +17,9 @@ OUTPUT_ARCH(mips)
 ENTRY(kernel_entry)
 PHDRS {
 	text PT_LOAD FLAGS(7);	/* RWX */
+#ifndef CONFIG_DISABLE_ELF_NOTE_HEADER
 	note PT_NOTE FLAGS(4);	/* R__ */
+#endif
 }
 
 #ifdef CONFIG_32BIT
@@ -70,8 +72,12 @@ SECTIONS
 		*(__dbe_table)
 		__stop___dbe_table = .;
 	}
-
-	NOTES :text :note
+#ifdef CONFIG_DISABLE_ELF_NOTE_HEADER
+#define NOTES_HEADER
+#else
+#define NOTES_HEADER :note
+#endif
+	NOTES :text NOTES_HEADER
 	.dummy : { *(.dummy) } :text
 
 	_sdata = .;			/* Start of data section */
-- 
1.7.11.7
