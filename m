Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 17:28:22 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:55387 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492206AbZGBP2P (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2009 17:28:15 +0200
Received: by ewy10 with SMTP id 10so2096866ewy.0
        for <multiple recipients>; Thu, 02 Jul 2009 08:22:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=b4qZqmPxvk2zrEB0HEVlpZDNOinMHu6xUtjw1YFLokI=;
        b=JQJVAaPaHZuDPmG75PZ5cer0sVO7DuBvLzWPaYibuYBVzG2Etncp9yQXGx04XZ4nYF
         wRbdAlQ4qa4b1F7jQ65D7UVtYSglncHyl7v0ZE0nQS5npoDiurPY/iGdCorFGRe3+Yew
         qpPGunv3F+0FgR2LzJilPwUnURp+CItsCJY5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DfYCH7v6lZZXcB8kUkxS1IhE/QUC9Zsfxqde8+6eyCVwYfU9WtLQcKA5Jv5YeIHwIY
         lLzcfkL3zGuV20obi3uAmNfP2CdN9mshs3CfXU6g1+He+slIXEdwpL6sg4oQkJOyj3wl
         G2eJGenicxXp4C+rzLPnMQ5uOlzwGigq1j4io=
Received: by 10.211.195.15 with SMTP id x15mr1093494ebp.59.1246548144881;
        Thu, 02 Jul 2009 08:22:24 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 28sm5801515eyg.44.2009.07.02.08.22.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 08:22:24 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
Subject: [PATCH v4 06/16] [loongson] pci: use existing mips_io_port_base
Date:	Thu,  2 Jul 2009 23:22:11 +0800
Message-Id: <faff7a39cb2be9167f25deb1d505e39a42825c6c.1246546684.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1246546684.git.wuzhangjin@gmail.com>
References: <cover.1246546684.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

mips_io_port_base is initialized via set_io_port_base() in
arch/mips/lemote/lm2e/setup.c, we can use it directly here.

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/lemote/lm2e/pci.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lemote/lm2e/pci.c b/arch/mips/lemote/lm2e/pci.c
index 8be03a8..152efb6 100644
--- a/arch/mips/lemote/lm2e/pci.c
+++ b/arch/mips/lemote/lm2e/pci.c
@@ -84,10 +84,7 @@ static int __init pcibios_init(void)
 {
 	ict_pcimap();
 
-	loongson2e_pci_controller.io_map_base =
-	    (unsigned long) ioremap(LOONGSON2E_IO_PORT_BASE,
-				    loongson2e_pci_io_resource.end -
-				    loongson2e_pci_io_resource.start + 1);
+	loongson2e_pci_controller.io_map_base = mips_io_port_base;
 
 	register_pci_controller(&loongson2e_pci_controller);
 
-- 
1.6.2.1
