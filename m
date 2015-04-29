Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 03:13:11 +0200 (CEST)
Received: from mail-vn0-f74.google.com ([209.85.216.74]:33136 "EHLO
        mail-vn0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011923AbbD2BNJTA821 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2015 03:13:09 +0200
Received: by vnbg62 with SMTP id g62so455475vnb.0
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 18:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n3pL0p7Q6jyg/Xjo57bfXzlfeDwf1OfwjkbKohYVMek=;
        b=UZxhqJ8L5B88Xl1VbekZtChiUChU8+7y0FqX7kqT4ZMg2MGY2QmHNvd8fa3nAFWV5j
         2aq6RHrWba+SxL8qcDBav+pPEnC87E6+1rdmSjdl2H0Bj+DEhUlPy3nKggSDBqBFxvnJ
         3AgjRE5ZJW/2lEOj5rZZSo26FIdr57H+S1w1q2eOkpEgIfqDXPrKSrHF0rQw6DkMsARP
         n0Jf4X0nji46mQPPVAEGKAKIzIjBrPpu+GGhhQSVVR+cTcSR2wTN3QMJLkr1Z66wbFtE
         BVHHY3XXQWaO87ljL1KnNO7MfvJUimWH5/AF0JUl+zCIeGjcDIDV0I6XQTUqbYJaL6jX
         NWzA==
X-Gm-Message-State: ALoCoQm6DXAgHiwezCIvhg8QstNwsNgsmh+ELFhXlE+ledV0ak3XJJPHG4JQyEK6Xsnbakb7s7Ht
X-Received: by 10.236.3.36 with SMTP id 24mr33788706yhg.44.1430269985075;
        Tue, 28 Apr 2015 18:13:05 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id i27si1309106yha.6.2015.04.28.18.13.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2015 18:13:05 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id 6EczmM9m.1; Tue, 28 Apr 2015 18:13:05 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id C5ADAA438B; Tue, 28 Apr 2015 18:13:03 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH V4 0/2] pinctrl: Support for IMG Pistachio
Date:   Tue, 28 Apr 2015 18:13:00 -0700
Message-Id: <1430269982-24129-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47146
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

Tested on an IMG Pistachio BuB.  Based on v4.1-rc1.

Changes from v3:
 - Addressed review comments from Ezequiel.
Changes from v2:
 - Removed module stuff that ends up being compiled out.
Changes from v1:
 - Documented pin + function generic binding.
 - Changed compatible string to "img,pistachio-system-pinctrl".
 - Addressed some review comments.
 - A couple of bug fixes.

Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: James Hartley <james.hartley@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>

Andrew Bresticker (2):
  pinctrl: Add Pistachio SoC pin control binding document
  pinctrl: Add Pistachio SoC pin control driver

 .../bindings/pinctrl/img,pistachio-pinctrl.txt     |  217 +++
 drivers/pinctrl/Kconfig                            |    6 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-pistachio.c                | 1502 ++++++++++++++++++++
 4 files changed, 1726 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/img,pistachio-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-pistachio.c

-- 
2.2.0.rc0.207.ga3a616c
