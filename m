Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 09:48:02 +0100 (CET)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:48884 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013472AbaKLIrQC8bxf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 09:47:16 +0100
Received: by mail-pd0-f169.google.com with SMTP id y10so11809998pdj.28
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 00:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z9ywekGBNsO2qB+SdZz9Dzbt3UhG15wGQaf3pQ6XGug=;
        b=TbqTnq4w4Fniek42ZOiGFChCO0H8iP+yJWH2k8+odePagKx1rbrnbW0Vcn2DvU1Rsf
         rdxN20L1hW3GYS1DTeVHhEZcVD7iqK6thcUQhGbeY4gAAEsw9DGHWDXU9f+bPOPnrAy2
         XxLXOeRKH2YmC5IvgHEAabTwVUFQr0XIQf/NEd3SeYTpGw9swmAAsWmguvWH3H6ojgo+
         XmpuwNXX9/CeamKpU/mZDO2hML//slnw/zgqK5h6PkMYAah/cYoOvnZqfZflAHJZ3vTY
         3yYmu+4llFMFJNdqpDPbbo/Eab9wnDtw8k25rCGocRwT8VUC23VT8Hu2LcCmsgVDwlO8
         fx0g==
X-Received: by 10.70.2.65 with SMTP id 1mr46430553pds.13.1415782030001;
        Wed, 12 Nov 2014 00:47:10 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id p10sm18804833pds.63.2014.11.12.00.47.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 00:47:09 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     tushar.behera@linaro.org, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH/RFC 3/8] of: Add helper function to check MMIO register endianness
Date:   Wed, 12 Nov 2014 00:46:28 -0800
Message-Id: <1415781993-7755-4-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44031
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
always return 1.  For the latter case, return 1 iff the kernel was built
for BE (implying that the BE MMIO accessors do not perform a swap).
Otherwise return 0, assuming LE registers.

LE registers are assumed by default because most existing drivers (libahci,
serial8250, usb) always use readl/writel in the absence of instructions
to the contrary, so that will be our fallback.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/base.c  | 23 +++++++++++++++++++++++
 include/linux/of.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 3823edf..9dd494a 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -552,6 +552,29 @@ int of_device_is_available(const struct device_node *device)
 EXPORT_SYMBOL(of_device_is_available);
 
 /**
+ *  of_device_is_big_endian - check if a device has BE registers
+ *
+ *  @device: Node to check for availability
+ *
+ *  Returns 1 if the device has a "big-endian" property, or if the kernel
+ *  was compiled for BE *and* the device has a "native-endian" property.
+ *  Returns 0 otherwise.
+ *
+ *  Callers would nominally use ioread32be/iowrite32be if
+ *  of_device_is_big_endian() == 1, or readl/writel otherwise.
+ */
+int of_device_is_big_endian(const struct device_node *device)
+{
+	if (of_property_read_bool(device, "big-endian"))
+		return 1;
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
+	    of_property_read_bool(device, "native-endian"))
+		return 1;
+	return 0;
+}
+EXPORT_SYMBOL(of_device_is_big_endian);
+
+/**
  *	of_get_parent - Get a node's parent if any
  *	@node:	Node to get parent
  *
diff --git a/include/linux/of.h b/include/linux/of.h
index 29f0adc..d24ccf3 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -276,6 +276,7 @@ extern int of_property_read_string_helper(struct device_node *np,
 extern int of_device_is_compatible(const struct device_node *device,
 				   const char *);
 extern int of_device_is_available(const struct device_node *device);
+extern int of_device_is_big_endian(const struct device_node *device);
 extern const void *of_get_property(const struct device_node *node,
 				const char *name,
 				int *lenp);
@@ -431,6 +432,11 @@ static inline int of_device_is_available(const struct device_node *device)
 	return 0;
 }
 
+static inline int of_device_is_big_endian(const struct device_node *device)
+{
+	return 0;
+}
+
 static inline struct property *of_find_property(const struct device_node *np,
 						const char *name,
 						int *lenp)
-- 
2.1.1
