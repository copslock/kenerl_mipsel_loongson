Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2018 11:25:58 +0100 (CET)
Received: from mail-wr1-x443.google.com ([IPv6:2a00:1450:4864:20::443]:46823
        "EHLO mail-wr1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992811AbeKZKZsduptO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2018 11:25:48 +0100
Received: by mail-wr1-x443.google.com with SMTP id l9so18251014wrt.13
        for <linux-mips@linux-mips.org>; Mon, 26 Nov 2018 02:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7sW7IaUZ6EGXx0NcQjT3M8wEY0OafP/B4sKeDi8lVrs=;
        b=BxSpZ/2xXdDbmKuDM8Pk5NVO//G47rpSTmKnaIf80M/uYGzRMjnRSxkKp+qsl7uwnq
         g3zb9G/PPZi3H/nioOtnP6b4msE66RzP/js7uQSTYSIN5Mp1oWzw9+Z70XCf5AB3Bci8
         7buCzqT7JhVgf7gdQMxG15ZhRMdhD5mujOkn9AE8NYcKxOvrtITKnZ+azY7Vh9+YKAK8
         tjcmBe9b1OmsDO5jL5vrypE1U+51t+dL2d8Nsasj2n+KWOijArduvOgrs420rPiG/Tpl
         spLx0NYOzGLnOUdV8g4C/7FWjHbVmWlhv5X3oYR5uzcdZQK2W9uImQ9pFRtl3DS+mwrv
         hZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7sW7IaUZ6EGXx0NcQjT3M8wEY0OafP/B4sKeDi8lVrs=;
        b=Ny/ur621k+RzICmY+Hc4nlXLPyDYXK1/MSk9JnhgjQPqjGe+6+weZPqDE3l6wBGiNI
         OLvW8njLzuiTkX8sQvXoEWKhREIShJb5VYPEKzoBENOW6ENa7uIRzkIn+O7pGOYJn2Vc
         00ZMZONWt5x0xNc32EhgS7xJFcuitKOp8lJ5ksLfckK8zNzZsZB0MMsci6MCmtFZs3Vv
         f2/tB1OXRYX+ZjWt4KUDVcg+BjPm8KKJkoBm75Eb6bpYwgOLXfJUNPvK3ZuKUKz7EAaz
         c1a7lwUnEuRnohvRDbvl0xii+ubqGWpyop7ozzFRqww1EBKr0H+fgyeYMDGfpgWg7TZo
         piBQ==
X-Gm-Message-State: AA+aEWa3qij2O9uKByyOO5biimuPLwCsoBNy9GjcYDx6zY1v9VWmD19Q
        zg9b27tJgjlKDqIR8Y7vrMhydQ==
X-Google-Smtp-Source: AFSGD/WSSi45/g4+5LjWAfgBnzc1kDiXZ1/IPjzlnIJHR4YrrOH3lbTgl+wiQlo+uFnHSlzsxremSA==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr22234814wrm.328.1543227947846;
        Mon, 26 Nov 2018 02:25:47 -0800 (PST)
Received: from desktop.wvd.kresin.me (p4FED3A99.dip0.t-ipconnect.de. [79.237.58.153])
        by smtp.gmail.com with ESMTPSA id c3-v6sm366907wmb.46.2018.11.26.02.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 02:25:47 -0800 (PST)
From:   Mathias Kresin <dev@kresin.me>
To:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] MIPS: ralink: Fix mt7620 nd_sd pinmux
Date:   Mon, 26 Nov 2018 11:25:40 +0100
Message-Id: <20181126102540.5304-1-dev@kresin.me>
X-Mailer: git-send-email 2.17.1
Return-Path: <dev@kresin.me>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev@kresin.me
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

In case the nd_sd group is set to the sd-card function, Pins 45 + 46 are
configured as GPIOs. If they are blocked by the sd function, they can't
be used as GPIOs.

Signed-off-by: Mathias Kresin <dev@kresin.me>
Reported-by: Kristian Evensen <kristian.evensen@gmail.com>
Fixes: f576fb6a0700 ("MIPS: ralink: cleanup the soc specific pinmux
data")
Cc: stable@vger.kernel.org # v3.18+
---
 arch/mips/ralink/mt7620.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 41b71c4352c2..c1ce6f43642b 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -84,7 +84,7 @@ static struct rt2880_pmx_func pcie_rst_grp[] = {
 };
 static struct rt2880_pmx_func nd_sd_grp[] = {
 	FUNC("nand", MT7620_GPIO_MODE_NAND, 45, 15),
-	FUNC("sd", MT7620_GPIO_MODE_SD, 45, 15)
+	FUNC("sd", MT7620_GPIO_MODE_SD, 47, 13)
 };
 
 static struct rt2880_pmx_group mt7620a_pinmux_data[] = {
-- 
2.17.1
