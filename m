Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2018 09:22:04 +0200 (CEST)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:41676
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992009AbeDSHV5m8wl8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2018 09:21:57 +0200
Received: by mail-pg0-x243.google.com with SMTP id e13so2074047pgq.8
        for <linux-mips@linux-mips.org>; Thu, 19 Apr 2018 00:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7r+KtxN1R28gezIYKxrrUmkWNugOgbH+sxaaoijsp4Q=;
        b=W9NdpcJf1DxW2lvXbmL4/AHdFXaPv4kl3SZtm/Ktf5bUJPacljs2ET/bt0VGyXZC8s
         /p1iDgpWVwKwVrqaqPNzlYLKzNgp2B6XgzV/HXSDKR73hjIE+JgkCw3di/VKN4c+7P+6
         F1KW0ERKRV9jdRk13e5SdMHSJL7PqMWiTFdEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7r+KtxN1R28gezIYKxrrUmkWNugOgbH+sxaaoijsp4Q=;
        b=j7w/c0kEaKDBYy6o1t79Af5DWneOpEW1UEXPvFfZsB28c+AxCbvjtIW4Iqj716s0w0
         R1nmmrG9EXIU/nnJu8PfB61hsFru8CaN/QRXdjXMa2C6D1/cSIS+UBaS1KnHWuj3jZ9k
         PoaySppcjqcqJcqt9wP6jKK+OOpPQAgqgK8SS3sESffJ29OX7yMqIA+JFSLNmtmfpw4M
         nu5RcgkJPW/upCC7lTBcdBDQ/IqLUxUUBv9Q9QFzCLnfwT5v4WsDTRGJBI3bMDzRbTAp
         iDqzX3ppq1SHq5fSOpIkj93D6RLJHpgSlocJ/+S7cVPxP3NmiW11NHV/VZ1zRVY6itxH
         4WwA==
X-Gm-Message-State: ALQs6tDCr6rEGBb+iRFFHcAZ8O/l+LjScE/QtgplES2+aXvmU/5yGUd1
        qInr6ZCugSWlWnxQXaaretuIIQ==
X-Google-Smtp-Source: AIpwx49OMwymCF76D8asjRdAokaBddwR/v/tJME9fuLcEe6q6CbOJde/yvGzPT7klWn6mO8Uljsivw==
X-Received: by 10.99.107.8 with SMTP id g8mr4218381pgc.271.1524122510725;
        Thu, 19 Apr 2018 00:21:50 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c28sm6947598pfe.27.2018.04.19.00.21.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Apr 2018 00:21:50 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ralf@linux-mips.org, jhogan@kernel.org
Cc:     kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, arnd@arndb.de,
        broonie@kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH] MIPS: sni: Remove the read_persistent_clock()
Date:   Thu, 19 Apr 2018 15:21:06 +0800
Message-Id: <0b52cfd4def5dd0287a1fd48c632a32e7cc3117b.1524122311.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <baolin.wang@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baolin.wang@linaro.org
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

The dummy read_persistent_clock() uses a timespec, which is not year 2038
safe on 32bit systems. Thus remove this obsolete interface.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/mips/sni/time.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/sni/time.c b/arch/mips/sni/time.c
index 0eb7d1e..dbace1f 100644
--- a/arch/mips/sni/time.c
+++ b/arch/mips/sni/time.c
@@ -171,9 +171,3 @@ void __init plat_time_init(void)
 	}
 	setup_pit_timer();
 }
-
-void read_persistent_clock(struct timespec *ts)
-{
-	ts->tv_sec = -1;
-	ts->tv_nsec = 0;
-}
-- 
1.7.9.5
