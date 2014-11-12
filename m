Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 21:55:45 +0100 (CET)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:46637 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013564AbaKLUypFux7A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 21:54:45 +0100
Received: by mail-pa0-f45.google.com with SMTP id lf10so13690036pab.18
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 12:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dFrpL4yoNUv9jpM/ApukSzfp54H1KFaozfaBRAb6+fA=;
        b=bWC6SMv4Pg4HiTAYQIO8p50YpCuKTjArWwJQXsOlOa0Amc82bRfEyWlrZJKSv/cDTy
         bg8RUGJSt0sAM/IQXTlpRaDTR1KWttIyxEHA4mconXbq+bQDaVYzkq34tLhrDtBHffKb
         ZOAALh0yGeYcm6CzmtccvujjQQDGyDKxzEjJSar8M+fODz5A5MWJKfzeayaJ5CWQVf/n
         N6rdKa9DT+dGxCuqURPIGGV06kuntCpDIggvffRyaO3Dx9SGUBklbh9quSXCmKboU7Z7
         IE3yrP9/1jJ9CD/CJq4yqlfBO/7FMKp1AXoCbXVvt7cuY2s5269yW8nD/KFtjblqymb5
         kg7Q==
X-Received: by 10.66.234.72 with SMTP id uc8mr50224442pac.51.1415825679297;
        Wed, 12 Nov 2014 12:54:39 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id z15sm23050495pdi.6.2014.11.12.12.54.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 12:54:38 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, grant.likely@linaro.org,
        f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH V2 04/10] of: Change of_device_is_available() to return bool
Date:   Wed, 12 Nov 2014 12:54:01 -0800
Message-Id: <1415825647-6024-5-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44079
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

This function can only return true or false; using a bool makes it more
obvious to the reader.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/base.c  | 22 +++++++++++-----------
 include/linux/of.h |  6 +++---
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 707395c..81c095f 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -507,27 +507,27 @@ EXPORT_SYMBOL(of_machine_is_compatible);
  *
  *  @device: Node to check for availability, with locks already held
  *
- *  Returns 1 if the status property is absent or set to "okay" or "ok",
- *  0 otherwise
+ *  Returns true if the status property is absent or set to "okay" or "ok",
+ *  false otherwise
  */
-static int __of_device_is_available(const struct device_node *device)
+static bool __of_device_is_available(const struct device_node *device)
 {
 	const char *status;
 	int statlen;
 
 	if (!device)
-		return 0;
+		return false;
 
 	status = __of_get_property(device, "status", &statlen);
 	if (status == NULL)
-		return 1;
+		return true;
 
 	if (statlen > 0) {
 		if (!strcmp(status, "okay") || !strcmp(status, "ok"))
-			return 1;
+			return true;
 	}
 
-	return 0;
+	return false;
 }
 
 /**
@@ -535,13 +535,13 @@ static int __of_device_is_available(const struct device_node *device)
  *
  *  @device: Node to check for availability
  *
- *  Returns 1 if the status property is absent or set to "okay" or "ok",
- *  0 otherwise
+ *  Returns true if the status property is absent or set to "okay" or "ok",
+ *  false otherwise
  */
-int of_device_is_available(const struct device_node *device)
+bool of_device_is_available(const struct device_node *device)
 {
 	unsigned long flags;
-	int res;
+	bool res;
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
 	res = __of_device_is_available(device);
diff --git a/include/linux/of.h b/include/linux/of.h
index 29f0adc..7aaaa59 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -275,7 +275,7 @@ extern int of_property_read_string_helper(struct device_node *np,
 					      const char **out_strs, size_t sz, int index);
 extern int of_device_is_compatible(const struct device_node *device,
 				   const char *);
-extern int of_device_is_available(const struct device_node *device);
+extern bool of_device_is_available(const struct device_node *device);
 extern const void *of_get_property(const struct device_node *node,
 				const char *name,
 				int *lenp);
@@ -426,9 +426,9 @@ static inline int of_device_is_compatible(const struct device_node *device,
 	return 0;
 }
 
-static inline int of_device_is_available(const struct device_node *device)
+static inline bool of_device_is_available(const struct device_node *device)
 {
-	return 0;
+	return false;
 }
 
 static inline struct property *of_find_property(const struct device_node *np,
-- 
2.1.1
