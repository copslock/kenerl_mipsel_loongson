Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jul 2016 10:29:03 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34683 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992476AbcG2I24x9cGs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jul 2016 10:28:56 +0200
Received: by mail-pa0-f66.google.com with SMTP id hh10so4902579pac.1;
        Fri, 29 Jul 2016 01:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=raPaoDXP2IrIKn4H1gINa/1tzYbuvsv9eOv3OuR6twY=;
        b=gL0U5Oy/DihHqoOZugtL2rvSBGpRTZ7IxEDg5Hm9to2aQLIJHhuJvu+9aQxxd20SlV
         lRBbFUD8rKZqwjk0931lvBKEW4HklAKncUuUf4THIallppGWWiNgkedrWVe9hHS7tkGD
         WRoZsBIf8uYa4MHLGy0toAc5IEq19xABG5GtCyQYdnNqEXhlE65qNkfcCDomNTwReahx
         MPjh3prGo2RnoOxaRm0Z4ZJozVVr9mNWrKgLTB9BYJ6/zqNvE9A9pyYND2lpEaoj9atD
         RsQq59HLxKpFzPhO/FPAtHEolx7hJg2WmhSCSYMa63eqD0KeX8hnnWWFV0WgqJSjP7Tv
         WtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=raPaoDXP2IrIKn4H1gINa/1tzYbuvsv9eOv3OuR6twY=;
        b=FaWjXQOH10y06tYuYOX5tQvD8Jug7WmQKJ5zkCgQRc3XdpJQEUxBD5S5zANq/47Pgn
         xzxhDaHk7SVEb8dL7PoKzesdHru0849/G1i5QRtKAxqhK1bKo1QHcqidj0Pr6Dm0rRm6
         zsE29fP7PkPg/ew2H6ENIQ26pPVKpqm75SCqK6CAU9iZ+dgDZRFXDDYdGe4Hj1fFycxS
         0H4PdyeB9Va1RnE1GUvGB7ZlPf2ybVHnyS7f9AXfIo+9adUirY6fcumIPLdD6WtyK9Bx
         70YUD87jTW+EoivQOUdh2bp6nH24XZmoYcF1ajlkV8SU78IgMAZ6RfhbXyzzTCbaX2Dy
         YsLQ==
X-Gm-Message-State: AEkoousGm7yPxHf/9J4VLnpy6mkS30gnnTihXbBug0XaDvd0KkJ3qeVtc4xhQn5EVgDn+g==
X-Received: by 10.66.177.7 with SMTP id cm7mr67001081pac.132.1469780929844;
        Fri, 29 Jul 2016 01:28:49 -0700 (PDT)
Received: from localhost ([182.69.8.130])
        by smtp.gmail.com with ESMTPSA id m24sm22696051pfi.34.2016.07.29.01.28.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 01:28:49 -0700 (PDT)
Date:   Fri, 29 Jul 2016 13:58:46 +0530
From:   Amitoj Kaur Chawla <amitoj1606@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     julia.lawall@lip6.fr
Subject: [PATCH] MIPS: Modify error handling
Message-ID: <20160729082846.GA8786@amitoj-Inspiron-3542>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <amitoj1606@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amitoj1606@gmail.com
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

debugfs_create_file returns NULL on error so an IS_ERR test is
incorrect here and a NULL check is required.

The Coccinelle semantic patch used to make this change is as follows:
@@
expression e;
@@

  e = debugfs_create_file(...);
if(
-    IS_ERR(e)
+    !e
    )
    {
  <+...
  return
- PTR_ERR(e)
+ -ENOMEM
  ;
  ...+>
  }

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 arch/mips/mm/sc-debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/sc-debugfs.c b/arch/mips/mm/sc-debugfs.c
index 5eefe32..01f1154 100644
--- a/arch/mips/mm/sc-debugfs.c
+++ b/arch/mips/mm/sc-debugfs.c
@@ -73,8 +73,8 @@ static int __init sc_debugfs_init(void)
 
 	file = debugfs_create_file("prefetch", S_IRUGO | S_IWUSR, dir,
 				   NULL, &sc_prefetch_fops);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
+	if (!file)
+		return -ENOMEM;
 
 	return 0;
 }
-- 
1.9.1
