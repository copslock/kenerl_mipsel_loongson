Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 03:15:16 +0100 (CET)
Received: from mail-qg0-f74.google.com ([209.85.192.74]:47217 "EHLO
        mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006984AbbBXCPNrJU7L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 03:15:13 +0100
Received: by mail-qg0-f74.google.com with SMTP id h3so4832453qgf.1
        for <linux-mips@linux-mips.org>; Mon, 23 Feb 2015 18:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yd/cqVGKdnQusOA9HEeutC50wBF6UrOebyAd5Uw3gdk=;
        b=jFu8D6Be0y7zORs6ibX7NpIemrZ5eancFIHAyEA/v4FO4D6puO2c660cL/Gu89sGmq
         PsGd6DMuCOVJwFCJl0a3lq28JPrtbKl4cc5//xw+8TQeYja0v3UQFQi+2ro2zboQaqXU
         X1pVE6EnhFgmTLRViFfD2794pWqBiUIJRuxeoHmwPqinp5vUapIbLZo+/ynTzgb+99/3
         ScpKR7htjGogK5TyEV8h8QCPn5hB/zyuddXufD8LttlssGt1X7bFIm4hd3o+v3cp/JMO
         bQwkJI625DHOndPyu3LHX+pVWqKwYCPEr/Re2arVMKMBC01loFcbs5jLKPAidSztzW2H
         6CZA==
X-Gm-Message-State: ALoCoQk2Se5yWIkXna6WLVTNvazn1muCbcyCAJFLwWXeO2lUXjF/PPG5fRhSPtLTZUcY4DbB5N3L
X-Received: by 10.52.244.198 with SMTP id xi6mr15050068vdc.0.1424744108274;
        Mon, 23 Feb 2015 18:15:08 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id q2si6563905qcn.2.2015.02.23.18.15.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2015 18:15:08 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 26nBzPrk.1; Mon, 23 Feb 2015 18:15:08 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id C5AD2220728; Mon, 23 Feb 2015 18:15:06 -0800 (PST)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 0/2] pinctrl: Support for IMG Pistachio
Date:   Mon, 23 Feb 2015 18:15:02 -0800
Message-Id: <1424744104-14151-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

This series adds support for the pin and GPIO controllers on the IMG
Pistachio SoC.  Pistachio's pin controller manages 99 pins, 90 of
which are MFIOs which can be muxed between multiple functions or used
as GPIOs.  The GPIO control for the 90 MFIOs is broken up into banks
of 16.  While this driver supports only Pistachio, it should hopefully
be easy to extend it to support future IMG SoCs.

Test on an IMG Pistachio BuB.  Based on 4.0-rc1 + my series adding
Pistachio platform support [1], which introduces the MACH_PISTACHIO
Kconfig symbol.  A branch with this series and the dependent patches
is available at [2].  I'd like this to go through the MIPS tree with
Linus'/Alex's ACKs if possible.

Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: James Hartley <james.hartley@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>

[1] https://lkml.org/lkml/2015/2/23/694
[2] https://github.com/abrestic/linux/tree/pistachio-pinctrl-v1

Andrew Bresticker (2):
  pinctrl: Add Pistachio SoC pin control binding document
  pinctrl: Add Pistachio SoC pin control driver

 .../bindings/pinctrl/img,pistachio-pinctrl.txt     |  217 +++
 drivers/pinctrl/Kconfig                            |    6 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-pistachio.c                | 1513 ++++++++++++++++++++
 4 files changed, 1737 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-pistachio.c

-- 
2.2.0.rc0.207.ga3a616c
