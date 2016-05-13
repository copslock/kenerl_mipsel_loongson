Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2016 02:04:09 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35393 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027050AbcEMAEGT3Kmn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2016 02:04:06 +0200
Received: by mail-pf0-f195.google.com with SMTP id r187so9139782pfr.2;
        Thu, 12 May 2016 17:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vN5JyfJonD7jgVdero5nfMr4qbuDZbUEswLxoZ2AaLk=;
        b=V0y6pwwr3ekoNE/ok5P4Th/j7ODPa5iFRbvXxBVJMUpa3VSGNQ1D2Iuxg3AbCs/F7/
         1s3v06rnZ9BVzjjCqJL7X9v74RfW/uV1Ur1zQfUj32FyeoXl8D0JwKR5haT8wfLg7JeY
         2UTNdV1LUykNFBUo+SFyk6e8mAbxbKamMK5WS+NkbKkncnOqzdXxur7wvYLmX8x33l2F
         M8+/CMhEXApeIrX2UQOPYlGrahA/P+FN0E3jDkQiQwDlEQ6e/tgC4Dsxwd9UlKXhdq2A
         gGOvUIG/fN6nTgEEhZheTHabo9Vbw2AYHLjSSwtBvc8uloJD1szwCM0jf5WXC4x5vkTG
         6G8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vN5JyfJonD7jgVdero5nfMr4qbuDZbUEswLxoZ2AaLk=;
        b=SKXIF94fIW7j3bPY/reCZq1RDaI/F13wGXMjbHe0xfy/31Tyg43x/5AcE/bLvNNwAN
         UqUSrIWLmS416AFJGfeABnwhcsFlAHewfxcucneJlyw6xjzCu4zEICHSCQ51qMyFiiPu
         iIckt3sktlFhSRwAYNWIpYRSTFluaZh76sm7gOx04vQXfSulQpH6UUlR7Ku8BcXR4bln
         Ucgy0mdZ1GVxU+GEUhHcbQiV/4coCNsHCAG4+7mqt4KpImaOiULQAWFnY1Vya4F0iqTu
         35agDLdEMPB/bH1M+AmuCejgRz/zn/s2YXTtddySGqiSRXPiY4+JA7bA3V+q8h0CdCiz
         8pmQ==
X-Gm-Message-State: AOPr4FW2HYMYjQdLAAY/1kDtPyaSViLJSXwnnMHGh1chKCh3kRQhzmjeq3lbR8nye5NeUg==
X-Received: by 10.98.23.150 with SMTP id 144mr18182131pfx.96.1463097840132;
        Thu, 12 May 2016 17:04:00 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id g27sm22468585pfd.25.2016.05.12.17.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 17:03:59 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, macro@imgtec.com, matt.redfearn@imgtec.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: Descend into arch/mips/boot/tools while cleaning
Date:   Thu, 12 May 2016 17:01:44 -0700
Message-Id: <1463097704-23755-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20160512072127.GQ16402@linux-mips.org>
References: <20160512072127.GQ16402@linux-mips.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53420
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

arch/mips/boot/tools/relocs was not being cleaned since we did not wire
this directory into the archclean target, fix that.

Fixes: 5f552da15721 ("MIPS: tools: Add relocs tool")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 8388ef6a0044..c0b002a09bef 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -404,6 +404,7 @@ endif
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/mips/boot
 	$(Q)$(MAKE) $(clean)=arch/mips/boot/compressed
+	$(Q)$(MAKE) $(clean)=arch/mips/boot/tools
 	$(Q)$(MAKE) $(clean)=arch/mips/lasat
 
 define archhelp
-- 
2.7.4
