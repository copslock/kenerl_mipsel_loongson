Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Feb 2013 22:42:35 +0100 (CET)
Received: from mail-ea0-f174.google.com ([209.85.215.174]:52613 "EHLO
        mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827634Ab3BMVlylES-H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Feb 2013 22:41:54 +0100
Received: by mail-ea0-f174.google.com with SMTP id 1so704186eaa.5
        for <linux-mips@linux-mips.org>; Wed, 13 Feb 2013 13:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=I9sm0k6KtQm/xVCR0WJ3PqH9MM0hhMCmIRfdS/BESuA=;
        b=mM10tgWfEZxaiek2FdfkDfD7y152VQETUa49AKZFJfzfsWk93BP79HJWcNNns6nB3s
         HhPoVF5HFJeFpuN2z5+5XX0OSg6RaTbR7cjK2EpO9hl9kYuZZI9aVMBdayu8e4G1AUs/
         oP9aSfmOUT26BlsT3Vlpf9cvJbfFUQboqff3hPnUqEVvgAl2GTEH0acfF/Wd+N9CZhfH
         BdE0taJeUjQvicjrUtxur6mAM7+uFzpBdSYfOBo3heyFk8tX3iuqZj0NWYDL7k/3Ht9G
         md8MYy+LaXx5UxK5bs4nB7xHY0hRL4a5nmAZKTbw8nUnOlzo17JbJNfs/5Ke2X0/Z7DZ
         Bpwg==
X-Received: by 10.14.216.198 with SMTP id g46mr8950871eep.30.1360791709289;
        Wed, 13 Feb 2013 13:41:49 -0800 (PST)
Received: from localhost.localdomain ([77.70.100.51])
        by mx.google.com with ESMTPS id r4sm30921681eeo.12.2013.02.13.13.41.47
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 13:41:48 -0800 (PST)
From:   Svetoslav Neykov <svetoslav@neykov.name>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        Svetoslav Neykov <svetoslav@neykov.name>
Subject: [PATCH 5/5] usb: chipidea: Fix incorrect check of function return value
Date:   Wed, 13 Feb 2013 23:38:58 +0200
Message-Id: <1360791538-6332-6-git-send-email-svetoslav@neykov.name>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1360791538-6332-1-git-send-email-svetoslav@neykov.name>
References: <1360791538-6332-1-git-send-email-svetoslav@neykov.name>
X-Gm-Message-State: ALoCoQl2HkEobsfuZ+fwi4bfzzBNKTSJaO/6wdd9FOQ7dFiML5HUmzd+Aq/B/q6mRQOGv3n1ssCS
X-archive-position: 35745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: svetoslav@neykov.name
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Use the correct variable to check for the return value of the last function.

Signed-off-by: Svetoslav Neykov <svetoslav@neykov.name>
---
 drivers/usb/chipidea/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 85c72e5..8442305 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -413,7 +413,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	}
 
 	base = devm_request_and_ioremap(dev, res);
-	if (!res) {
+	if (!base) {
 		dev_err(dev, "can't request and ioremap resource\n");
 		return -ENOMEM;
 	}
-- 
1.7.9.5
