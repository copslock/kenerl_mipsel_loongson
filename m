Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 01:17:06 +0200 (CEST)
Received: from mail-ob0-f201.google.com ([209.85.214.201]:34174 "EHLO
        mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014813AbbC3XREvqgkA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 01:17:04 +0200
Received: by obcuy5 with SMTP id uy5so213367obc.1
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2015 16:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q5LJizvAxb6+U7hRiKu12r3iVpL0/ZKuBarxx0RtK3M=;
        b=OYqDJ4eUNFn/J5aBTAIBTaOwPamTTJKy+n5wbeLvoqTZuzbiXcTv3dFrmEH787kBNn
         Q4PU/w+4kifoUOLz2Uyy5SA4gkxINCr5Pf1IiaasMKpz3NgZA9lZBss+0P+b0iU9+rvs
         B3pVfx1UFRJs/tDD0N2PYdnqenQ/TE92gS0zGSw7+rC1xp18IAJCkeNy9Y8V9jR+jHac
         AsXy2tRGQi7GPWHERIAIRCUQ8H191Cx7JugS3ZnF5wpQ0KjkoazwWUxs8TAY7F9tXSP9
         0QjTIx+96/8HYqolwx1lA7i0TWo+AuHxaIk5l25Tuhn6pu1jBSdAZdV0HMS67KunCWGE
         K+2A==
X-Gm-Message-State: ALoCoQkla3gG0v/SjVQ0N9e54J1UtkjGaRfMl8wGcV5SddHrcHPIZxAGstCDsIkT3tQQgGR7j7ZU
X-Received: by 10.50.43.229 with SMTP id z5mr174298igl.3.1427757419401;
        Mon, 30 Mar 2015 16:16:59 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id d31si500465yhb.1.2015.03.30.16.16.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2015 16:16:59 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 021yZxWs.1; Mon, 30 Mar 2015 16:16:59 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 0EFFD2208EF; Mon, 30 Mar 2015 16:16:57 -0700 (PDT)
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
Subject: [PATCH V2 0/3] pinctrl: Support for IMG Pistachio
Date:   Mon, 30 Mar 2015 16:16:53 -0700
Message-Id: <1427757416-14491-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46624
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

This series adds support for the system pin and GPIO controller on the IMG
Pistachio SoC.  Pistachio's system pin controller manages 99 pins, 90 of
which are MFIOs which can be muxed between multiple functions or used
as GPIOs.  The GPIO control for the 90 MFIOs is broken up into banks
of 16.  Pistachio also has a second pin controller, the RPU pin controller,
which will be supported by a future patchset through an extension to this
driver.

Test on an IMG Pistachio BuB.  Based on mips-for-linux-next which inluces my
series adding Pistachio platform support [1].  A branch with this series is
available at [2].

Changes from v1:
 - Documented pin + function generic binding.
 - Changed compatible string to "img,pistachio-system-pinctrl".
 - Addressed some review comments.
 - A couple of bug fixes.

Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: James Hartley <james.hartley@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>

[1] https://lkml.org/lkml/2015/3/16/1130
[2] https://github.com/abrestic/linux/tree/pistachio-pinctrl-v2

Andrew Bresticker (3):
  pinctrl: Document "function" + "pins" pinmux binding
  pinctrl: Add Pistachio SoC pin control binding document
  pinctrl: Add Pistachio SoC pin control driver

 .../bindings/pinctrl/img,pistachio-pinctrl.txt     |  217 +++
 .../bindings/pinctrl/pinctrl-bindings.txt          |    7 +
 drivers/pinctrl/Kconfig                            |    6 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-pistachio.c                | 1528 ++++++++++++++++++++
 5 files changed, 1759 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-pistachio.c

-- 
2.2.0.rc0.207.ga3a616c
