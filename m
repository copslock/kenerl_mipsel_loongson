Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2018 03:46:39 +0200 (CEST)
Received: from mail-pl0-x243.google.com ([IPv6:2607:f8b0:400e:c01::243]:44878
        "EHLO mail-pl0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994646AbeHQBqeXhGaa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2018 03:46:34 +0200
Received: by mail-pl0-x243.google.com with SMTP id ba4-v6so2940867plb.11
        for <linux-mips@linux-mips.org>; Thu, 16 Aug 2018 18:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=/nkMDk9Ekxgg14E9V5bn38j4KZ/ucP8iU6DmwVz+yU8=;
        b=fACeGxxeJdMhS7stAYNsBkp3EO8npsQ4mKE7oCtKxbrbkWgA3KqDIILRHvc7yibc8K
         BRCh0qcI4ofTZ1Dj0DKZLARK8c0lwVh8/d0YKeC0huD40mMHf54tXND0xwg0GL/OKEYX
         3jHsa6F3MmHaOc32I9vjoSnFdCrSCgwBUsBCxnMyaH3RfSZ+Tm6vtSgcwdr+f151Ch21
         66nPydTr+XOT8KsESRCkTVw3Emo89rlatiMN4jc0wgrOude0tK2+pS4dNXi7b8x6X6gQ
         j+e7o55MjG71kiZedHtoZEoZUHUbX7J7sI7BOdoCgz7TDag4Ho6tXweb9obbJllcWp4u
         KkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=/nkMDk9Ekxgg14E9V5bn38j4KZ/ucP8iU6DmwVz+yU8=;
        b=WKtZ0qORcKQbdvkoVkGWl2vDpTDkmHNMwtR/aSG28JWdl1GbSj5gDehdsQYLihx11v
         DFZPNoumxlVjgL5lzSn+KzU0VhtpbuOs6Bi690GtoWv62pALwgpVs+y4dT0/quMsdSaF
         Gs44MWV6Qlz69w69uqOzeVXg5dsLODVKv8exkqj4HOzKXxhiCN/VrgkPTU/yc9C36SvU
         GD6VXEBwiCKmGud2DjSPeaKYb8e01f1Ta7bciHc/Xhtuy3L/sBCE48RDJNZKCy0arwaS
         u+Ka6f9UhS0WGTl+g+aJuJbzB+vK2xJbbCb8E0ObdhNiVTPXEriZneQL+VUa6Iub6pSp
         Fywg==
X-Gm-Message-State: AOUpUlE1ZT7v74IWQ+64ohwgyJd4xeqIZ3fLF9uvTLlTcqR3TiOcdpRf
        X2KqdXvD0LimkSdRrtRG99qxfJXqpjk=
X-Google-Smtp-Source: AA+uWPyqUpokcA8Z8lgPio4zDSNVas+nePuZiiSwWor1Df0fA9Q6fDU2TN0L2u5GgGllJxVKIEe8/A==
X-Received: by 2002:a17:902:7584:: with SMTP id j4-v6mr31608380pll.184.1534470387548;
        Thu, 16 Aug 2018 18:46:27 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:1501:200:5efe:a66f:53fa])
        by smtp.gmail.com with ESMTPSA id g15-v6sm659363pfg.98.2018.08.16.18.46.26
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 18:46:27 -0700 (PDT)
From:   Jiecheng Wu <jasonwood2031@gmail.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH] ip22-gio.c: fix missing return value check of kzalloc()
Date:   Fri, 17 Aug 2018 09:46:16 +0800
Message-Id: <20180817014616.6488-1-jasonwood2031@gmail.com>
X-Mailer: git-send-email 2.14.3.windows.1
Return-Path: <jasonwood2031@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65606
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

Function ip22_check_gio() defined in arch/mips/sgi-ip22/ip22-gio.c calls kzalloc() to allocate memory for struct gio_device which is dereferenced immediately. As kzalloc() may return NULL when OOM happens, this code piece may cause NULL pointer dereference bug.
---
 arch/mips/sgi-ip22/ip22-gio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index b225033..ec32d75 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -363,6 +363,8 @@ static void ip22_check_gio(int slotno, unsigned long addr, int irq)
 		printk(KERN_INFO "GIO: slot %d : %s (id %x)\n",
 		       slotno, name, id);
 		gio_dev = kzalloc(sizeof *gio_dev, GFP_KERNEL);
+		if (!gio_dev)
+			return;
 		gio_dev->name = name;
 		gio_dev->slotno = slotno;
 		gio_dev->id.id = id;
-- 
2.6.4
