Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jul 2014 17:14:39 +0200 (CEST)
Received: from mail-wg0-f52.google.com ([74.125.82.52]:54382 "EHLO
        mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861359AbaGZN6gB88J7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Jul 2014 15:58:36 +0200
Received: by mail-wg0-f52.google.com with SMTP id a1so5329540wgh.11
        for <linux-mips@linux-mips.org>; Sat, 26 Jul 2014 06:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=myOm8YslrksUr9TT74B7EzJpcmwsi/t66SB1my+D4Mc=;
        b=KgZsaWb+D0dKKQkWhV5qbFULMP0Wt+VgIkqzixiI+W/KtzK/2dNXVX+dEabQpe9mO3
         rtlDEyzBivJb7f3xPmclDWPiFxRDf7czC800Fryph2BcJcQogBnbJ+M0gCM3ELioAjz1
         M9UpPW8Ug2QriC+IS+/9BYVc7T+5BcKAq1GivolCn9+RHsY0vmSPLoFfC938QmQz8ELk
         NfAp4R+BXGKOFref15/jpvt1YMGBI0eDuYaHob7pP2nfr3RIWpI7YcwosAtZkz4zwGE+
         JyHYZvnFU0rmDiCa7lC5my4sm5VzytXxlcKIDL9XOlUGeLPn94qyxc2gjmCzsdIq9ztn
         CCiA==
X-Gm-Message-State: ALoCoQkHU5jeGBkuqBRndWwINg585uzgJXUEFwH+/UUKsxLK+8nEG3eX4VbAQnDnwl1gyikmi8q+
X-Received: by 10.194.5.103 with SMTP id r7mr31366725wjr.41.1406383110611;
        Sat, 26 Jul 2014 06:58:30 -0700 (PDT)
Received: from localhost.localdomain (h-245-62.a218.priv.bahnhof.se. [85.24.245.62])
        by mx.google.com with ESMTPSA id x11sm928681wjr.15.2014.07.26.06.58.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jul 2014 06:58:29 -0700 (PDT)
From:   Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To:     Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh@kernel.org>
Cc:     Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
        Grant Likely <grant.likely@linaro.org>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch: mips: ralink: of.c:  Cleaning up missing null-terminate in conjunction with strncpy
Date:   Sat, 26 Jul 2014 15:59:57 +0200
Message-Id: <1406383197-1219-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <rickard_strandqvist@spectrumdigital.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41627
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

Replacing strncpy with strlcpy to avoid strings that lacks null terminate.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/mips/ralink/of.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 2513952..7c4598c 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -81,7 +81,7 @@ static int __init plat_of_setup(void)
 		panic("device tree not present");
 
 	strlcpy(of_ids[0].compatible, soc_info.compatible, len);
-	strncpy(of_ids[1].compatible, "palmbus", len);
+	strlcpy(of_ids[1].compatible, "palmbus", len);
 
 	if (of_platform_populate(NULL, of_ids, NULL, NULL))
 		panic("failed to populate DT");
-- 
1.7.10.4
