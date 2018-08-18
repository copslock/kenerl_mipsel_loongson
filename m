Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Aug 2018 04:30:09 +0200 (CEST)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:35735
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990396AbeHRCaGCot42 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Aug 2018 04:30:06 +0200
Received: by mail-pl0-x242.google.com with SMTP id g1-v6so4501907plo.2
        for <linux-mips@linux-mips.org>; Fri, 17 Aug 2018 19:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=mZXKnJ2bU0L9qdMUEtR6lnZR0rN+4KlOXq9wrZxShjI=;
        b=og7pvSsvjWruBsMi4PvpkyXawEL+8O8l9TIyUsesq0eqQjnO+q/vAW0c0+2P7GXRyK
         BhAt+WyL5b0wayTcKPWsErg96wXnw5fI2eTgwvipXuhxU3RI7DyxlSv3L8lZPNx7MmWR
         /xn3DQLpw8n5DiDOAFRrfyyn9XQQuP5Caq8PvhNOmKqa2gI9S6zpADfTt2kFQn3DC2Sq
         XM9nmdqsBgZmrZyJJWb0P7/+tpwJXSkN8HUw+7S7VyVeCBlHIf6i1T8m548HceRz8dPc
         RSs2Y80k8sy+Q8mGcxaY/BDIYvoYgotCIf+c2S3Sr90sNn2oiSq7L9eSYE16fhTpSEx6
         GqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=mZXKnJ2bU0L9qdMUEtR6lnZR0rN+4KlOXq9wrZxShjI=;
        b=uDPU2SivGmfJbiieg5aZvI0UISL4AP2CeKogRDKsQTZ35Fn2zGSGEdc716pYnrkRuT
         TH2vTM3UtjkXAe3ErXorcizp1AkWi1PJniM/DetNDrjFyf8d0LwhWO0L5Rf1zHD7krJS
         ipVH4Up95KjxDRXgKOZ/Hh7sSX0lKcRpl8FzFe6YwAStSccq4ZuKI4Z+oWE/bVWo+le3
         AjlNE/A4Oj+Dpm7FJFM4/jfIxuOOIlE0rGglH8RGMnijH/muLWyxJugD5EHhTQmn4TXE
         jN5JgEo8NWxgLhXxqUTPv5ZtiFAb8KLSflkJNe6Aykuv3jsInqD/hyn4HfP9PE4lfzea
         JfMA==
X-Gm-Message-State: AOUpUlHHbbZzE8UueW4o7PNwXAppF/eMzwGYliSzOwXTAZ3LCXHfzqZL
        cxRn9VDmICMzjzrQAjHieZbVMgBqqdMBRg==
X-Google-Smtp-Source: AA+uWPw+pSxXuT+TVcjU2elp0CYXWxxlrzuRBmiQhDyFRvn/ngvIz5f0G7yJ80ko0kp05gvP1fpXcA==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61-v6mr35404279plb.176.1534559399460;
        Fri, 17 Aug 2018 19:29:59 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:1501:200:5efe:a66f:53fa])
        by smtp.gmail.com with ESMTPSA id r81-v6sm4412061pfa.18.2018.08.17.19.29.58
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 19:29:59 -0700 (PDT)
From:   Jiecheng Wu <jasonwood2031@gmail.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH] octeon-irq.c: fix missing return value check of kzalloc()
Date:   Sat, 18 Aug 2018 10:29:49 +0800
Message-Id: <20180818022949.15520-1-jasonwood2031@gmail.com>
X-Mailer: git-send-email 2.14.3.windows.1
Return-Path: <jasonwood2031@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jasonwood2031@gmail.com
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

Function octeon_irq_cib_map() defined in arch/mips/cavium-octeon/octeon-irq.c calls kzalloc() to allocate memory for struct octeon_irq_cib_chip_data which is dereferenced immediately. As kzalloc() may return NULL on failure, this code piece may cause NULL pointer dereference bug.
---
 arch/mips/cavium-octeon/octeon-irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 8272d8c..5a2fc7d 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -2199,6 +2199,8 @@ static int octeon_irq_cib_map(struct irq_domain *d,
 	}
 
 	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
 	cd->host_data = host_data;
 	cd->bit = hw;
 
-- 
2.6.4
