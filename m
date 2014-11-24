Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 00:37:11 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:51216 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013649AbaKXXgg5WPBO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 00:36:36 +0100
Received: by mail-pa0-f50.google.com with SMTP id bj1so10500829pad.37
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 15:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AhceQE1xTzX5p4sNYYlkC0VMr2BKu2ct5+HZv2x8aus=;
        b=qCDVgQN29ZT6gqrWqpO2k+BJV+ADNZARDe2h2KrJH4xJa3jEf/1njue2eTpuTavyWY
         a0AoCIARZnLF11rRs8ANt0OycBXRvBBUm1ZJTYztR75agxmahR5DSPGcWfT6IYjOcm4f
         nENN7my4kubT5GO2QBnXVAAhNg+lc6hLApaMVpAIfgcJrOTlUIE7AmB0EeoFeSBRW3AF
         xxSwptD4iBn2uIMEotAAl4qtXfdq/BhPc01AmnLX+Zuu8OiUwG119t6iEVMgjg7e21Di
         LMaN4SUzM7HcUkMh2IVNbn1zxT/oU1dM2xV4/eYuLdkz82b3pq8LS9ELTTTibLx3FtPj
         i7Lw==
X-Received: by 10.70.43.68 with SMTP id u4mr38657942pdl.6.1416872191152;
        Mon, 24 Nov 2014 15:36:31 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id aq1sm13382876pbd.29.2014.11.24.15.36.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 15:36:30 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH V3 2/7] of/fdt: Add endianness helper function for early init code
Date:   Mon, 24 Nov 2014 15:36:17 -0800
Message-Id: <1416872182-6440-3-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Provide a libfdt-based equivalent for of_device_is_big_endian(), suitable
for use in the early_init_* functions.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/fdt.c       | 19 +++++++++++++++++++
 include/linux/of_fdt.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 30e97bc..658656f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -107,6 +107,25 @@ int of_fdt_is_compatible(const void *blob,
 }
 
 /**
+ * of_fdt_is_big_endian - Return true if given node needs BE MMIO accesses
+ * @blob: A device tree blob
+ * @node: node to test
+ *
+ * Returns true if the node has a "big-endian" property, or if the kernel
+ * was compiled for BE *and* the node has a "native-endian" property.
+ * Returns false otherwise.
+ */
+bool of_fdt_is_big_endian(const void *blob, unsigned long node)
+{
+	if (fdt_getprop(blob, node, "big-endian", NULL))
+		return true;
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
+	    fdt_getprop(blob, node, "native-endian", NULL))
+		return true;
+	return false;
+}
+
+/**
  * of_fdt_match - Return true if node matches a list of compatible values
  */
 int of_fdt_match(const void *blob, unsigned long node,
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 0ff360d5b..587ee50 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -33,6 +33,8 @@ extern void *of_fdt_get_property(const void *blob,
 extern int of_fdt_is_compatible(const void *blob,
 				unsigned long node,
 				const char *compat);
+extern bool of_fdt_is_big_endian(const void *blob,
+				 unsigned long node);
 extern int of_fdt_match(const void *blob, unsigned long node,
 			const char *const *compat);
 extern void of_fdt_unflatten_tree(unsigned long *blob,
-- 
2.1.0
