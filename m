Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jan 2017 10:48:55 +0100 (CET)
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32951 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993064AbdABJssYhdsc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Jan 2017 10:48:48 +0100
Received: by mail-pg0-f67.google.com with SMTP id g1so30031643pgn.0;
        Mon, 02 Jan 2017 01:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B2qQ28YWEk7NhSw48mmoWn0tvENdjKC1j9mkvoLSOwk=;
        b=ZbXZJXiy223b/U4eX4qQglcj7Gmbgotatc3OXA7gPWJzY9Ky9yi2djXeyl7sO9wx5h
         impJZevJhPv3AE5TQ+mdKW0KGbt6dMxRGAL8qcaMyVhwzWol0i9Ay9tplSofm7oU/CEx
         Enx6RoLzAIL5fDcfkxn/71Fnm0JG2ZExHEyGt030F0rvq+yMBXVIJtDVvzVxry9Wl0PD
         0VqZ12ctxOfUh+mSXvWVxVZKWtigJxYgqkoiuXRa5YNHbQtEYzswWpKLZxRbtH8SO8Ty
         ki0V5XVunLnhZsZwIkZ4P9hVNIP+twkl/zlWoupNbG5XyahGPRIObMnne2YZwHdyc1RR
         y/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B2qQ28YWEk7NhSw48mmoWn0tvENdjKC1j9mkvoLSOwk=;
        b=jkbf5K1Ezhu/bTKxOiT/nNsGDSnnlZiQUNvjr0aHmGCw6siOupx+/H2vjKB8NgjWHZ
         /7ZTjcdmUo9XLQdTed/dN/DqmW/JZkVUUtVxUIXUciguA3YCrADKFF+B2XAi6ZENNSzO
         QkwR4s70i9u6NWXp3NO4y5tMd6Xm7BoKf5jFmVxnEMXaomLVmKcpMxQh8tjlmBGHo28d
         EJzr1srTHjnR+2nDJWRxCzvcPuCrLvPLsGIfiMxltX1RMXD4+/10LFyD39R8G3zTgqKw
         3PfkhkYpCnKAkJes1qyFtT55G6meadyViexn1yXRjiFKMfbqgydBNRDDLuzF/X0Uk7am
         /tKg==
X-Gm-Message-State: AIkVDXKIqxT5avqLyifwnSzQFdLRtR8nCEGDE2AqBb8trakytfymYaghnbQaCoSTwrWE7A==
X-Received: by 10.99.156.2 with SMTP id f2mr107771907pge.20.1483350522521;
        Mon, 02 Jan 2017 01:48:42 -0800 (PST)
Received: from symbol-HP-Z420-Workstation.zebra.lan ([223.31.70.102])
        by smtp.googlemail.com with ESMTPSA id h185sm130768861pfg.90.2017.01.02.01.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jan 2017 01:48:41 -0800 (PST)
From:   Arvind Yadav <arvind.yadav.cs@gmail.com>
To:     ralf@linux-mips.org
Cc:     antonynpavlov@gmail.com, albeu@free.fr, hackpascal@gmail.com,
        sboyd@codeaurora.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [v1] mips: ath79: clock:- Unmap region obtained by of_iomap
Date:   Mon,  2 Jan 2017 15:18:21 +0530
Message-Id: <1483350501-7678-1-git-send-email-arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <arvind.yadav.cs@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arvind.yadav.cs@gmail.com
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

Free memory mapping, if ath79_clocks_init_dt_ng is not successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/mips/ath79/clock.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index cc3a1e3..7e2bb12 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -508,16 +508,19 @@ static void __init ath79_clocks_init_dt_ng(struct device_node *np)
 		ar9330_clk_init(ref_clk, pll_base);
 	else {
 		pr_err("%s: could not find any appropriate clk_init()\n", dnfn);
-		goto err_clk;
+		goto err_iounmap;
 	}
 
 	if (of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data)) {
 		pr_err("%s: could not register clk provider\n", dnfn);
-		goto err_clk;
+		goto err_iounmap;
 	}
 
 	return;
 
+err_iounmap:
+	iounmap(pll_base);
+
 err_clk:
 	clk_put(ref_clk);
 
-- 
1.9.1
