Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2017 07:49:00 +0200 (CEST)
Received: from mail-pf0-x230.google.com ([IPv6:2607:f8b0:400e:c00::230]:33692
        "EHLO mail-pf0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992170AbdF3FrUZKmFm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jun 2017 07:47:20 +0200
Received: by mail-pf0-x230.google.com with SMTP id e7so61635602pfk.0
        for <linux-mips@linux-mips.org>; Thu, 29 Jun 2017 22:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DgX2CRzG7ZY76LmDt/+e7ntAxd1sHIY4PzE4l/INono=;
        b=DpIyWvQr11NqKgJIZQq/3+QcwQDNySPW6f0C02I9eWUTP/0yD8bbget+lMHTDaBhTk
         +3JEzD8kJ7m3ZCAhlXeFGwdswoR0Xvk9ZqZYA/Lh+eWzmoQmG+HJA5UqYz+Tv0pkhUJh
         Pjs4A5jgu2QWByKOa8ZEhcsQwM18gwFm9mInE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DgX2CRzG7ZY76LmDt/+e7ntAxd1sHIY4PzE4l/INono=;
        b=o6wfWhD5uRiHFhlj2PtvVKW5pXukI1fhoj95Jz9OJllf6Oug9+sxpKv9orXTVnggv5
         4hbVTWW2nqE6zMXzRE5cSP2iSwYnv/dGOAC9SLqYwoePor+1TDokVwIc07Hr/92VrMF0
         IkkJI48p41LLcG0NQBA+eXtig3YrLCKkU//dDV40mqfpJVi/pyJLOT14W7uIeBsWEYWk
         FS0NseE3gK1HAINY/+C10ql1xLkicULK1QnzzUo8a7+V+/Bx54HeOKm4e5+EQJ1NwwYZ
         Ka2REq8XsZTX4jJU9l/KjeqIZ97u1j0CQ9XDzoZvdTt0bzKzc3PhKnS1nSEkTZ/XOlyX
         CXLg==
X-Gm-Message-State: AKS2vOzL03tSdL5ZR4QH5y4C84fUfAgPSHXkOhSX+dIeFtuY6qlPUqqx
        hLpftGNdj4MCWXR1
X-Received: by 10.98.159.130 with SMTP id v2mr20283371pfk.20.1498801634652;
        Thu, 29 Jun 2017 22:47:14 -0700 (PDT)
Received: from localhost.localdomain ([106.51.129.233])
        by smtp.gmail.com with ESMTPSA id a187sm11405550pgc.37.2017.06.29.22.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 22:47:13 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Stable <stable@vger.kernel.org>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, john@phrozen.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH for-4.4 09/16] MIPS: ralink: fix MT7628 wled_an pinmux gpio
Date:   Fri, 30 Jun 2017 11:16:33 +0530
Message-Id: <1498801600-20896-10-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1498801600-20896-1-git-send-email-amit.pundir@linaro.org>
References: <1498801600-20896-1-git-send-email-amit.pundir@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

From: Álvaro Fernández Rojas <noltari@gmail.com>

commit 07b50db6e685172a41b9978aebffb2438166d9b6 upstream.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Cc: john@phrozen.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13307/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/mips/ralink/mt7620.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 37cfc7d3c185..48d6349fd9d7 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -196,10 +196,10 @@ static struct rt2880_pmx_func wled_kn_grp_mt7628[] = {
 };
 
 static struct rt2880_pmx_func wled_an_grp_mt7628[] = {
-	FUNC("rsvd", 3, 35, 1),
-	FUNC("rsvd", 2, 35, 1),
-	FUNC("gpio", 1, 35, 1),
-	FUNC("wled_an", 0, 35, 1),
+	FUNC("rsvd", 3, 44, 1),
+	FUNC("rsvd", 2, 44, 1),
+	FUNC("gpio", 1, 44, 1),
+	FUNC("wled_an", 0, 44, 1),
 };
 
 #define MT7628_GPIO_MODE_MASK		0x3
-- 
2.7.4
