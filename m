Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2017 07:31:19 +0100 (CET)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:46552
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990426AbdLGGatqQnR2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2017 07:30:49 +0100
Received: by mail-pf0-x241.google.com with SMTP id c204so3958142pfc.13;
        Wed, 06 Dec 2017 22:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QOb2/k3U5A8n5EHP9foVGxbcQHn+6GysiFHBIe5HD3I=;
        b=XPaOATqodQdICSgSy88tSiatnC0lVwK1xvAsRIsSaPixoWNkMJr3Z4gGptu3HiBtxL
         cc9SpaCXeSddYNFVduEuFXlizKlWGttxJvOrklvKoHvHGRIizLq2D1VEvYfzlXcn9zAO
         INzY34Kaq5t6cif3CgPck/r2i/9plLMq1z4mNinBlOaDQt0/N+3+l4lEaXvtgtfkF9gM
         tCkgSlbuqN5VosG7IvZSFe+ONh7bPV2/vO7LuFdhiM6KeeKHTKAwxIi26vVscokH44yo
         S7UmkLazixgpaoM3RVqSBDDC5gYclpPf4N5hfcfzJwJFLZgOsmXm7HrOThVbPF72Mbq3
         5ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=QOb2/k3U5A8n5EHP9foVGxbcQHn+6GysiFHBIe5HD3I=;
        b=JudrHNHpS4uU0ubBG+Wv5vDWJcqxPfoLNvsVAsoQSk3vvKlu+eoUEFjOmRSQbWouHt
         vE3pUhKPBtfWJViubzWKwfEJ0quBn4Lp4WjOFJEMLle9Gef0pyO6ZswkcQmepZnAsOAM
         8xMrwdbtbpBYiSqNUaf/XdwbTl6Te1USNqO7LNo+r8XIOzUFTdmwLquyvsKzQvbPHOjJ
         blP7xHjfplWrYAp3Gj8uoyYU5pBp/6kPxug0zh069UPDlXDJQPRiHOWsyy4LiB0tfGEu
         CvmomH+ulYtwE7fzc9znKj25ZDvvdJZtuUpEjsDExyvRvE9qIy406S90za6uIX3gHYnV
         Tawg==
X-Gm-Message-State: AJaThX62ARcpGMjNuEt7V3yCXb8LI1w2JaitZc5F7F83qPPIFghdH28Z
        Ma0d1FoWIhjwaa701l2m2EE=
X-Google-Smtp-Source: AGs4zMZCKjDC9INC5iug5E39jkbt1sE4pLWbTjOsRWQ3PLt3oufiWwsgat9jeOuQ6MyXNoexmV0EYQ==
X-Received: by 10.159.242.196 with SMTP id x4mr24818687plw.342.1512628243704;
        Wed, 06 Dec 2017 22:30:43 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id b67sm7586351pfm.19.2017.12.06.22.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Dec 2017 22:30:43 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>
Cc:     Rui Wang <wangr@lemote.com>, Binbin Zhou <zhoubb@lemote.com>,
        Ce Sun <sunc@lemote.com>, Yao Wang <wangyao@lemote.com>,
        Liangliang Huang <huangll@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, r@hev.cc,
        zhoubb.aaron@gmail.com, huanglllzu@163.com, 513434146@qq.com,
        1393699660@qq.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 1/1] MAINTAINERS: Add Loongson-2/Loongson-3 maintainers
Date:   Thu,  7 Dec 2017 14:31:08 +0800
Message-Id: <1512628268-18357-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1512628268-18357-1-git-send-email-chenhc@lemote.com>
References: <1512628268-18357-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Add Jiaxun Yang as the MIPS/Loongson-2 maintainer and add Huacai Chen
as the MIPS/Loongson-3 maintainer.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 MAINTAINERS | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cdd6365..bf449da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9141,6 +9141,26 @@ F:	arch/mips/include/asm/mach-loongson32/
 F:	drivers/*/*loongson1*
 F:	drivers/*/*/*loongson1*
 
+MIPS/LOONGSON2 ARCHITECTURE
+M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	arch/mips/loongson64/*{2e/2f}*
+F:	arch/mips/include/asm/mach-loongson64/
+F:	drivers/platform/mips/
+F:	drivers/*/*loongson2*
+F:	drivers/*/*/*loongson2*
+
+MIPS/LOONGSON3 ARCHITECTURE
+M:	Huacai Chen <chenhc@lemote.com>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	arch/mips/loongson64/
+F:	arch/mips/include/asm/mach-loongson64/
+F:	drivers/platform/mips/
+F:	drivers/*/*loongson3*
+F:	drivers/*/*/*loongson3*
+
 MIPS RINT INSTRUCTION EMULATION
 M:	Aleksandar Markovic <aleksandar.markovic@mips.com>
 L:	linux-mips@linux-mips.org
-- 
2.7.0
