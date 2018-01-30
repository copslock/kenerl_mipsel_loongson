Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jan 2018 23:42:44 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:38119
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994757AbeA3WmOElZE2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Jan 2018 23:42:14 +0100
Received: by mail-lf0-x242.google.com with SMTP id g72so17769662lfg.5;
        Tue, 30 Jan 2018 14:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RC1Vu7j1MNgr8OOdl2KXTyvSAjnV8JzuJEfXjAyP6TM=;
        b=TzDvLZMle8XhFmKGtSdYudYs02Co2IZCy1ebmggidHgrYQaVxQagUX5p2ov9KagztO
         D1aKXeKSs6vJG3M+Kfcbo8vxrYCqVhoL6JWWC7YlV73xgfWkwbANm69NDG8oMbXr8t54
         o33iXmOvFBYgU1efw3Ewp1gs3AuyNomTVSIOjWHhaLaB7+PeWXMoqhPINtslnJuEqY7x
         A9QmvRnUDB2WYte6V+JnyCZvptvlOwjJFnbzJEkEoUZfSiBTBaLoFXvNJo5fPD0PqFz4
         xpF57ThJKosAvpS4y4p3f2SuXeTDz8ctfAvb2QwIV2t73nqO6BmyWecB7JUimH/fujpt
         u8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RC1Vu7j1MNgr8OOdl2KXTyvSAjnV8JzuJEfXjAyP6TM=;
        b=NcAtyj99txODXnpQNMSRRZ839JHmLoQYrJcBqzVzTyS0VJGEATpsdYX5zbudwdTZtV
         clNrlOUG063SFHJELOlcXwMFHh+SDFhpW3/Mo8v0EJJwIfENoRmRnjWrFrRT5GDVztIp
         29H9r/WlMqAK3YpBgMKlSBRVmGHVD7W3BZTziIR1neqIvRNrplyq3g+XRrjseJNFZqO0
         bvWaym08qi17DoUWqNd/qoZP1zMicZRoi1ohZBLMYO5/tRZWazI9XwWD6W5LVrd6GZ/U
         t+VNE/CIzj/53IBOeEhEAKPO0xpSI7YfASI0ZHsFT4/gj7a8MNJgQQuIiCepmLjDV2VR
         DiiA==
X-Gm-Message-State: AKwxyte6fOFOl+wNX8Nhndwhrg7IzO9b74ABKLTCNGgbxd7A43vqL/O5
        J7p994opUH9AyJ9l+t6PMZp4gg==
X-Google-Smtp-Source: AH8x227C1RQj4OuEjhmiukpWoDdIxxnP5cX+yGIokg2zvfFWKi+FEueINqEE0VUIw28mhhvbqENNxw==
X-Received: by 10.46.80.88 with SMTP id v24mr1235728ljd.86.1517352128374;
        Tue, 30 Jan 2018 14:42:08 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-108-121.pppoe.spdop.ru. [109.252.108.121])
        by smtp.gmail.com with ESMTPSA id 4sm2938194lja.20.2018.01.30.14.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 14:42:07 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Matt Redfearn <matt.redfearn@mips.com>
Subject: [PATCH v2 1/2] Add notrace to lib/ucmpdi2.c
Date:   Wed, 31 Jan 2018 01:42:01 +0300
Message-Id: <20180130224202.7682-2-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180130224202.7682-1-antonynpavlov@gmail.com>
References: <20180130224202.7682-1-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

From: Palmer Dabbelt <palmer@sifive.com>

As part of the MIPS conversion to use the generic GCC library routines,
Matt Redfearn discovered that I'd missed a notrace on __ucmpdi2().  This
patch rectifies the problem.

CC: Matt Redfearn <matt.redfearn@mips.com>
CC: Antony Pavlov <antonynpavlov@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 lib/ucmpdi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ucmpdi2.c b/lib/ucmpdi2.c
index 25ca2d4c1e19..597998169a96 100644
--- a/lib/ucmpdi2.c
+++ b/lib/ucmpdi2.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/libgcc.h>
 
-word_type __ucmpdi2(unsigned long long a, unsigned long long b)
+word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
 {
 	const DWunion au = {.ll = a};
 	const DWunion bu = {.ll = b};
-- 
2.11.0
