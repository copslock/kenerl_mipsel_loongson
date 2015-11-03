Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2015 17:39:55 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36825 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010433AbbKCQjy03DaA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2015 17:39:54 +0100
Received: by padhk6 with SMTP id hk6so439072pad.3;
        Tue, 03 Nov 2015 08:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=il/Y1/vSp59Xn4Up7XjbZD0e+OpRTxw6ZpePZj8r8kk=;
        b=b88VOMumkZWyqHlXmMNU+DyysZtSggh+ua/H4UCYixf5+N9bGyYYEAjJnyOizOu3UF
         uki3b7pXWJMMhGqAmtX2CIeNFyv0H2T9SCFXkw2Vc7xlXauBkTpit5kHUqSpdn8K7Fk+
         b42zK/VpsF046/Z2C8XE8h5tAfz9WP9QOX6t4B5/7t2Zy2FL6N1Xja2OeqIoEhKjiogc
         3atUnv0UKMI5ZTVcNHKKsJo1a+Gke6lQKGqYp0Oi/C7MJo7DF6f34w58kUC9UPNGVKrH
         WpgrUvcxDymZOwUQX924fX68cSg+uq57q3KpI5S7onDHIq1NOM1iN+sY1e/LtVm89TS+
         nzVQ==
X-Received: by 10.66.218.129 with SMTP id pg1mr34964932pac.156.1446568788129;
        Tue, 03 Nov 2015 08:39:48 -0800 (PST)
Received: from yggdrasil (114-25-185-251.dynamic.hinet.net. [114.25.185.251])
        by smtp.gmail.com with ESMTPSA id ku1sm30388315pbc.47.2015.11.03.08.39.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2015 08:39:47 -0800 (PST)
Date:   Wed, 4 Nov 2015 00:39:43 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: kernel: proc: Fix typo in proc.c
Message-ID: <20151103163943.GA49024@yggdrasil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

Fix typo introduced in commit 515a6393 (MIPS: kernel: proc: Add
MIPS R6 support to /proc/cpuinfo), mips1 should be tested against
cpu_has_mips_1, not cpu_has_mips_r1.

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 211fcd4..3417ce0 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -83,7 +83,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	}
 
 	seq_printf(m, "isa\t\t\t:"); 
-	if (cpu_has_mips_r1)
+	if (cpu_has_mips_1)
 		seq_printf(m, " mips1");
 	if (cpu_has_mips_2)
 		seq_printf(m, "%s", " mips2");
