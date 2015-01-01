Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jan 2015 17:45:30 +0100 (CET)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:56884 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006810AbbAAQp2JmrL3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jan 2015 17:45:28 +0100
Received: by mail-wi0-f182.google.com with SMTP id h11so26794369wiw.3
        for <linux-mips@linux-mips.org>; Thu, 01 Jan 2015 08:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V2K5Mzt8NdX2klUNDmVd8ZbY7NugZkawmsMkrcniVO8=;
        b=SDOPiRttOzkP3xVdP5fdv0guvHK8muqBRh6C4JsR9ToifyQcys28AO9gmZTDE9xqt3
         05sd6Q2sZA96Fkt6a7WGs8y0bIepXazA6GgXkit/T75SGkc3/57UsT6h5R5Em+M98TBE
         CsiVkekjxp4Yuk523T0bR2dlhps/LHrISFlfGGyocIHJGobnVZo7vN37fECXPJGpMqiZ
         4dJruMTFF/r2+C7L7Pzj8AQDWtGqXcXSzzcOm/ws2UqJpmjhI7X+EgjklTeUapzIWXaq
         CLkAUTDnSI64pIjC7T1nqlejVxTIk6+2ttlLxJextzB+RNEIuvumocXjZ7+mVKmvfvny
         Aeng==
X-Gm-Message-State: ALoCoQnrEkTab7Ib+JIwRAnO5wcFH+m6hbvCOa/EnsViI/TjkOrm6Cs1MH+Na2N9tGgr4cfLE1FV
X-Received: by 10.194.90.81 with SMTP id bu17mr50092905wjb.3.1420130722787;
        Thu, 01 Jan 2015 08:45:22 -0800 (PST)
Received: from localhost.localdomain (h-246-111.a218.priv.bahnhof.se. [85.24.246.111])
        by mx.google.com with ESMTPSA id cp4sm61707613wjb.16.2015.01.01.08.45.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jan 2015 08:45:22 -0800 (PST)
From:   Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch: mips: lasat: sysctl.c:  Remove unused function
Date:   Thu,  1 Jan 2015 17:48:23 +0100
Message-Id: <1420130903-29616-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <rickard.strandqvist@spctrm.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rickard_strandqvist@spectrumdigital.se
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

Remove the function proc_dolasatint() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/mips/lasat/sysctl.c |   15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/mips/lasat/sysctl.c b/arch/mips/lasat/sysctl.c
index 3b7f65c..9d65f1e 100644
--- a/arch/mips/lasat/sysctl.c
+++ b/arch/mips/lasat/sysctl.c
@@ -53,21 +53,6 @@ int proc_dolasatstring(struct ctl_table *table, int write,
 	return 0;
 }
 
-/* proc function to write EEPROM after changing int entry */
-int proc_dolasatint(struct ctl_table *table, int write,
-		       void *buffer, size_t *lenp, loff_t *ppos)
-{
-	int r;
-
-	r = proc_dointvec(table, write, buffer, lenp, ppos);
-	if ((!write) || r)
-		return r;
-
-	lasat_write_eeprom_info();
-
-	return 0;
-}
-
 #ifdef CONFIG_DS1603
 static int rtctmp;
 
-- 
1.7.10.4
