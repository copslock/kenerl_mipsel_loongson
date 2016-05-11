Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 21:16:28 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33206 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27029103AbcEKTQ1A07Wo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2016 21:16:27 +0200
Received: by mail-pf0-f195.google.com with SMTP id y7so4418649pfb.0;
        Wed, 11 May 2016 12:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=b6yu7OsZWAFhR8lQWnVEAYjmHwFxKckbZHCkY/XQ8g4=;
        b=L3yYKlh1OVyRoJ5UNXZtO9rXMhYPGjYUoqX4MIgpXSg/3V4ZLgrjqtUZZDH4cLSjsy
         ct4NWill9iFuMAhkz7MdET1AgX6qI1H/haxd3mZWzfImPaeuBXFRzS9UVSq7TKen1kAQ
         9S/huh7wHt+ZsvymHvDgi8s1fn40ZwBfdB+gqPu+2J/N9Shb8YoE6ixJ6UBZJzBqOPP+
         QbFX6uHl9zfcsJqCRobXvMfGbRrg89W3oZEO9iEUsL/pMcnmMRJJ9dOL4Fmnn7N3Ra1O
         2VM5FH6BWVheLlaJ6EroL+QfvmYRGlRtdyu/DHrP8KqU0PEjnr8vkROogQfWdpiSg5bt
         p5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b6yu7OsZWAFhR8lQWnVEAYjmHwFxKckbZHCkY/XQ8g4=;
        b=gdTZCa/CgcV5kxp+ARGg4/B9hEXf1TpiWnITp6tBuoL66uARvMGgrrYpHsWCeA/cnv
         akoTxrF0vRXxCWpqTJvE+A3BDImEmkGd20Hlh8TEHO2HZBDOH0iISxK6Nh6V9E7WR67f
         BO+7tp85/F39Z/6ljfhJ4lER6U9lhPwKlSqo3iJjxWuHDvLoKJf8zKpqpMPo/HiHMzUQ
         0yjGPoM6KTJ7f/b77O9HfqH4oTsqYzOS5TDr2tLu1ZPKIiSiIL8t0xJZ6XCrcw/A/+Ny
         SNYCB27aYcQm8BLUMwk/Tk9wlpq1buUwpIH5WEfQQJLsM0KHHCUcSgoKAHVMvodpYcn7
         mopg==
X-Gm-Message-State: AOPr4FWH6Js27vjPa5/lRUawKzkj1L25phwIVUU/D1f2EFU1QUFsiUwF/wfvp/FyhWX0Qg==
X-Received: by 10.98.92.66 with SMTP id q63mr7461473pfb.21.1462994180847;
        Wed, 11 May 2016 12:16:20 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id xd14sm14082872pac.6.2016.05.11.12.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 12:16:19 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, matt.redfearn@imgtec.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: tools: Ignore relocation tool
Date:   Wed, 11 May 2016 12:16:17 -0700
Message-Id: <1462994177-6460-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Add a .gitignore ignoring arch/mips/boot/tools/relocs.

Fixes: 5f552da15721 ("MIPS: tools: Add relocs tool")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/boot/tools/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 arch/mips/boot/tools/.gitignore

diff --git a/arch/mips/boot/tools/.gitignore b/arch/mips/boot/tools/.gitignore
new file mode 100644
index 000000000000..be0ed065249b
--- /dev/null
+++ b/arch/mips/boot/tools/.gitignore
@@ -0,0 +1 @@
+relocs
-- 
2.7.4
