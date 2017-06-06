Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 21:24:33 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993156AbdFFTYOqsXtg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 21:24:14 +0200
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 89CBA978;
        Tue,  6 Jun 2017 19:24:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 02/16] mips: sgi-ip22: ecard: use dev_groups and not dev_attrs for bus_type
Date:   Tue,  6 Jun 2017 21:22:07 +0200
Message-Id: <20170606192221.1617-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170606192221.1617-1-gregkh@linuxfoundation.org>
References: <20170606192221.1617-1-gregkh@linuxfoundation.org>
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

The dev_attrs field has long been "depreciated" and is finally being
removed, so move the driver to use the "correct" dev_groups field
instead for struct bus_type.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/sgi-ip22/ip22-gio.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index cdf187600010..b225033aade6 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -169,6 +169,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
 
 	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
 }
+static DEVICE_ATTR_RO(modalias);
 
 static ssize_t name_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
@@ -178,6 +179,7 @@ static ssize_t name_show(struct device *dev,
 	giodev = to_gio_device(dev);
 	return sprintf(buf, "%s", giodev->name);
 }
+static DEVICE_ATTR_RO(name);
 
 static ssize_t id_show(struct device *dev,
 		       struct device_attribute *attr, char *buf)
@@ -187,13 +189,15 @@ static ssize_t id_show(struct device *dev,
 	giodev = to_gio_device(dev);
 	return sprintf(buf, "%x", giodev->id.id);
 }
+static DEVICE_ATTR_RO(id);
 
-static struct device_attribute gio_dev_attrs[] = {
-	__ATTR_RO(modalias),
-	__ATTR_RO(name),
-	__ATTR_RO(id),
-	__ATTR_NULL,
+static struct attribute *gio_dev_attrs[] = {
+	&dev_attr_modalias.attr,
+	&dev_attr_name.attr,
+	&dev_attr_id.attr,
+	NULL,
 };
+ATTRIBUTE_GROUPS(gio_dev);
 
 static int gio_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
@@ -374,7 +378,7 @@ static void ip22_check_gio(int slotno, unsigned long addr, int irq)
 
 static struct bus_type gio_bus_type = {
 	.name	   = "gio",
-	.dev_attrs = gio_dev_attrs,
+	.dev_groups = gio_dev_groups,
 	.match	   = gio_bus_match,
 	.probe	   = gio_device_probe,
 	.remove	   = gio_device_remove,
-- 
2.13.0
