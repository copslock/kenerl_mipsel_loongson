Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:16:48 +0100 (CET)
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36703 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012020AbcBIIOiHTsq5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:38 +0100
Received: by mail-lf0-f66.google.com with SMTP id h198so5993283lfh.3
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 00:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EdL7wmcM3jd0Jt6iazfYdaNR7gjcEyU5Um7+mAp8J4A=;
        b=fJCd7RjuNVAE7+wWF4+ZF1pm0h8dQ7gKVqih/xG8vhtLhya7qcuRqKOvv6PMtGqEU4
         Nku8f5EbF7+ogzue/1qDx+7m3XLTDI9h9IG5mKuLhdsipJ9mx6LX1Flx2QQ2jjRHzdGD
         jOouqhB1Na0jpZvEbBhlWsfY32iOVYOGzywlWAaSEkMUZ97owRXVRlamnfo8Ldk+ZAGN
         I9Pr6/Vk1fmZHtdyjtYoUcmUfAC+oaEUu+2b5SJk+kdUrEp/8mf84kv8A+6n/AG5aJAe
         LYo8nKBBzyzGCJxtWW2pE+P5l8ikYMal9iyFqDiLVH6JotK+FW8dGjfJmFyHDgMrHFkr
         WEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EdL7wmcM3jd0Jt6iazfYdaNR7gjcEyU5Um7+mAp8J4A=;
        b=ZJsSEFnQEmLoKqt8tUKZpeIS5j8LLA/2nFlcOUX/PKhnU7sXQMd9FXGbcBNKZm7DoX
         wcdoc2tFM55MxiKR6yJ79YtNBtwCgAaBwlnnhfjhKrdl2nfY+PuLaH1QFpSof3JH8oB0
         YF3nkbaXV0XbZI7q/G94mPvp4qoNw+OtM3OS0Z7j1Rje6J1+8btdYrFLJPgWJz6AYCH9
         5SyBDDkOUPeqOTD0h915j7lFKLC0u1E9d3L0iWOwbknBudofpiODF63Jwyx3SXQMkeEM
         +68ij4Q2hOJL7K5EMV3kuFwabvSwH2axJCaFvJp18msdCyTt0hbAyJlg36sdAgOx1TNV
         VPwQ==
X-Gm-Message-State: AG10YORbaLAfUKGHYjj4qpNo9U1kgdMRtxHeRVWWCE4T5PENWu5wOIZgCZjST5Rxqygxmw==
X-Received: by 10.25.78.66 with SMTP id c63mr11600327lfb.18.1455005672851;
        Tue, 09 Feb 2016 00:14:32 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:32 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>
Subject: [RFC v5 08/15] MIPS: tl_mr3020: enable usb support
Date:   Tue,  9 Feb 2016 11:13:54 +0300
Message-Id: <1455005641-7079-9-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51884
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

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/boot/dts/qca/tl_mr3020.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/boot/dts/qca/tl_mr3020.dts b/arch/mips/boot/dts/qca/tl_mr3020.dts
index 2a1b296..45c27ed 100644
--- a/arch/mips/boot/dts/qca/tl_mr3020.dts
+++ b/arch/mips/boot/dts/qca/tl_mr3020.dts
@@ -84,6 +84,15 @@
 	status = "okay";
 };
 
+&usb {
+	status = "okay";
+	vbus-gpio = <&gpio 8 GPIO_ACTIVE_HIGH>;
+};
+
+&usb_phy {
+	status = "okay";
+};
+
 &spi {
 	num-chipselects = <1>;
 	status = "okay";
-- 
2.7.0
