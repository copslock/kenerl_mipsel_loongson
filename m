Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Jul 2009 15:53:57 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.221.177]:54095 "EHLO
	mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492931AbZGZNxo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 26 Jul 2009 15:53:44 +0200
Received: by qyk7 with SMTP id 7so1129880qyk.22
        for <linux-mips@linux-mips.org>; Sun, 26 Jul 2009 06:53:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=tt/+qbeytB3dsO/FxvvqT1ft/fHLi0KWhadSXXwyAcs=;
        b=cG/u6U1043Eb2FQIxPIkQuWum711OduFPORsaK6G9xS4LV9KHgM7gnEE2S8bVFd2nD
         ZZssrV0jaA9B4T5jHzbIKC9j9hyv5m2eUXFW6zZmPbCwQhG1PUqXUjWYp0P0Gt8m9YQs
         AsG+eu/EaMVZ9nUqUwwXq7MnU0CCyqoUCzsow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=QznguFHZ34upXOAiAa0iF18umLrdE2dB+msoU19wDuHCVQ3EmB8U8K9MoySS5puhwb
         8wYNiTMwV2D4xxuixr8B0b3jC2qhGOM4U1VOQoeuNHvT8W+e0OWMy3yLm2Stm5eSYuz/
         3HBFHlYZUzxmMJjuWpI+XhRS2EbCwLGjQRwSk=
Received: by 10.224.45.144 with SMTP id e16mr5146426qaf.89.1248616416455;
        Sun, 26 Jul 2009 06:53:36 -0700 (PDT)
Received: from ?192.168.2.201? (bas7-quebec14-1096764162.dsl.bell.ca [65.95.75.2])
        by mx.google.com with ESMTPS id 2sm8639620qwi.43.2009.07.26.06.53.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Jul 2009 06:53:35 -0700 (PDT)
Subject: Re: [PATCH 1/1] acer-wmi: switch driver to dev_pm_ops
From:	Arnaud Faucher <arnaud.faucher@gmail.com>
To:	linux-kernel@vger.kernel.org
Cc:	Carlos Corbacho <carlos@strangeworlds.co.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Frans Pop <elendil@planet.nl>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Erik Ekman <erik@kryo.se>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
In-Reply-To: <200907252204.44875.rjw@sisk.pl>
References: <1248527091-18246-1-git-send-email-arnaud.faucher@gmail.com>
	 <20090725174311.GB14062@dtor-d630.eng.vmware.com>
	 <200907252204.44875.rjw@sisk.pl>
Content-Type: text/plain
Date:	Sun, 26 Jul 2009 09:53:33 -0400
Message-Id: <1248616413.3922.7.camel@green>
Mime-Version: 1.0
X-Mailer: Evolution 2.27.4.1 
Content-Transfer-Encoding: 7bit
Return-Path: <arnaud.faucher@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnaud.faucher@gmail.com
Precedence: bulk
X-list: linux-mips

Gets rid of the following warning:
Platform driver 'acer-wmi' needs updating - please use dev_pm_ops

Take 2, thanks to Dmitry, Rafael and Frans for pointing out PM issue on
hibernation when using dev_pm_ops blindly.

This patch was tested against suspendand hibernation (Acer mail led
status).

Signed-off-by: Arnaud Faucher <arnaud.faucher@gmail.com>
---
 drivers/platform/x86/acer-wmi.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c
b/drivers/platform/x86/acer-wmi.c
index be2fd6f..29374bc 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1152,8 +1152,7 @@ static int acer_platform_remove(struct
platform_device *device)
 	return 0;
 }
 
-static int acer_platform_suspend(struct platform_device *dev,
-pm_message_t state)
+static int acer_platform_suspend(struct device *dev)
 {
 	u32 value;
 	struct acer_data *data = &interface->data;
@@ -1174,7 +1173,7 @@ pm_message_t state)
 	return 0;
 }
 
-static int acer_platform_resume(struct platform_device *device)
+static int acer_platform_resume(struct device *dev)
 {
 	struct acer_data *data = &interface->data;
 
@@ -1190,15 +1189,23 @@ static int acer_platform_resume(struct
platform_device *device)
 	return 0;
 }
 
+static struct dev_pm_ops acer_platform_pm_ops = {
+	.suspend = acer_platform_suspend,
+	.resume = acer_platform_resume,
+	.freeze = acer_platform_suspend,
+	.thaw = acer_platform_resume,
+	.poweroff = acer_platform_suspend,
+	.restore = acer_platform_resume,
+};
+
 static struct platform_driver acer_platform_driver = {
 	.driver = {
 		.name = "acer-wmi",
 		.owner = THIS_MODULE,
+		.pm = &acer_platform_pm_ops,
 	},
 	.probe = acer_platform_probe,
 	.remove = acer_platform_remove,
-	.suspend = acer_platform_suspend,
-	.resume = acer_platform_resume,
 };
 
 static struct platform_device *acer_platform_device;
-- 
1.6.3.3
