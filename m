Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 00:36:54 +0100 (CET)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:56335 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012832AbaKXXggSEZdA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 00:36:36 +0100
Received: by mail-pa0-f53.google.com with SMTP id kq14so10519356pab.40
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 15:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uxHc1qVhYTCdecqLpUxyUgtCYeXdTTo7p8xyvrdtL3s=;
        b=tjxXYeEQ3NOCQERp3d/Hv51NfnEZUtjLqIm5bC+7FCxbN9biSG/2MlFZNlPpSIugcA
         D99bwgUMALL+VecLB7FOHRBKyJV057SMVMz1fUnV4osVI6W2sXWjoGv9U+3O47Hrqm7M
         Ybt8RN/ryxmhQJUr79PVV7w+xsJe1y+AhlFTc7UuGI2TLKfY5GbOFrRjq+tWsukcUY1B
         Z7HAWkKoMwjRZ/YarbWCtwsd0GmHCWUStBC6y/EYAaH19mseqlI1nJtNiiEuhLIySPp7
         fqo3GvfZQy954gHqxi3PX06Z8eX75fJbeZ9YGyGnQDNZYXtpyfBrr+7/GiDsltfbhwzy
         EvYg==
X-Received: by 10.70.129.104 with SMTP id nv8mr37270146pdb.81.1416872189686;
        Mon, 24 Nov 2014 15:36:29 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id aq1sm13382876pbd.29.2014.11.24.15.36.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 15:36:28 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH V3 1/7] of: Add helper function to check MMIO register endianness
Date:   Mon, 24 Nov 2014 15:36:16 -0800
Message-Id: <1416872182-6440-2-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44413
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

SoC peripherals can come in several different flavors:

 - little-endian: registers always need to be accessed in LE mode (so the
   kernel should perform a swap if the CPU is running BE)

 - big-endian: registers always need to be accessed in BE mode (so the
   kernel should perform a swap if the CPU is running LE)

 - native-endian: the bus will automatically swap accesses, so the kernel
   should never swap

Introduce a function that checks an OF device node to see whether it
contains a "big-endian" or "native-endian" property.  For the former case,
always return true.  For the latter case, return true iff the kernel was
built for BE (implying that the BE MMIO accessors do not perform a swap).
Otherwise return false, assuming LE registers.

LE registers are assumed by default because most existing drivers (libahci,
serial8250, usb) always use readl/writel in the absence of instructions
to the contrary, so that will be our fallback.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/base.c  | 23 +++++++++++++++++++++++
 include/linux/of.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 81c095f..35d95a1 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -552,6 +552,29 @@ bool of_device_is_available(const struct device_node *device)
 EXPORT_SYMBOL(of_device_is_available);
 
 /**
+ *  of_device_is_big_endian - check if a device has BE registers
+ *
+ *  @device: Node to check for endianness
+ *
+ *  Returns true if the device has a "big-endian" property, or if the kernel
+ *  was compiled for BE *and* the device has a "native-endian" property.
+ *  Returns false otherwise.
+ *
+ *  Callers would nominally use ioread32be/iowrite32be if
+ *  of_device_is_big_endian() == true, or readl/writel otherwise.
+ */
+bool of_device_is_big_endian(const struct device_node *device)
+{
+	if (of_property_read_bool(device, "big-endian"))
+		return true;
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
+	    of_property_read_bool(device, "native-endian"))
+		return true;
+	return false;
+}
+EXPORT_SYMBOL(of_device_is_big_endian);
+
+/**
  *	of_get_parent - Get a node's parent if any
  *	@node:	Node to get parent
  *
diff --git a/include/linux/of.h b/include/linux/of.h
index 7aaaa59..fc70b01 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -276,6 +276,7 @@ extern int of_property_read_string_helper(struct device_node *np,
 extern int of_device_is_compatible(const struct device_node *device,
 				   const char *);
 extern bool of_device_is_available(const struct device_node *device);
+extern bool of_device_is_big_endian(const struct device_node *device);
 extern const void *of_get_property(const struct device_node *node,
 				const char *name,
 				int *lenp);
@@ -431,6 +432,11 @@ static inline bool of_device_is_available(const struct device_node *device)
 	return false;
 }
 
+static inline bool of_device_is_big_endian(const struct device_node *device)
+{
+	return false;
+}
+
 static inline struct property *of_find_property(const struct device_node *np,
 						const char *name,
 						int *lenp)
-- 
2.1.0
