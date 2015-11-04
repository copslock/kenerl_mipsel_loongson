Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2015 17:17:59 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33093 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011247AbbKDQR6COs6J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2015 17:17:58 +0100
Received: by pabfh17 with SMTP id fh17so57046243pab.0;
        Wed, 04 Nov 2015 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=US+obWUKwgjQPd41fUUf3Rz/zy5ky2yYDRdkGgbl1KI=;
        b=cbqRBF6O2opmdV0u0o4VvBuWcu9u5vFFbzipOB/esMzWnCuVl0/yQSh+AjOY1xEKKm
         CLAg8NtoHu6/LboetXVEN9JHyBl3gdlxEPkvlRtA2/pXMPddX7gecmSKVeWX2oZyWHga
         OGtjwjiNfG6CeRexUQ0K+HuP4bJeaKoav3uulBoWNE+0+Knf5Mr2IsB5tiMW6FmCOIgX
         NYBEHQNpq1sivfj7YsoKiOG1/k/MHeh7on5GyAEKST/48UeCJYFXJKOWW4otG6PosYhT
         8zsfZEkzdCjvHT/+u0GBRAz2YewVcoGkui2lq+QESfCGODhXfrwUrUfsqRrjgG1YVZkP
         dCrg==
X-Received: by 10.68.235.3 with SMTP id ui3mr2732822pbc.168.1446653870485;
        Wed, 04 Nov 2015 08:17:50 -0800 (PST)
Received: from yggdrasil (111-251-226-182.dynamic.hinet.net. [111.251.226.182])
        by smtp.gmail.com with ESMTPSA id ja4sm2923442pbb.19.2015.11.04.08.17.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2015 08:17:49 -0800 (PST)
Date:   Thu, 5 Nov 2015 00:17:44 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2] MIPS: kernel: proc: Fix typo in proc.c
Message-ID: <20151105001612-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49841
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

Fix typo introduced in commit 515a6393dbac ("MIPS: kernel: proc:
Add MIPS R6 support to /proc/cpuinfo"), mips1 should be tested
against cpu_has_mips_1, not cpu_has_mips_r1.

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: <stable@vger.kernel.org> # v4.0+

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
