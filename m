Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2017 17:16:00 +0200 (CEST)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:38599
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992135AbdI0PPy2o69l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2017 17:15:54 +0200
Received: by mail-pg0-x243.google.com with SMTP id m30so9494696pgn.5;
        Wed, 27 Sep 2017 08:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2q6Si0UwBGPxtAT45Miuyjn08xJbz2vW3M+s6kVA6UA=;
        b=u+NV7MpyGSPEKdONb8GHo6rAMC5HERsDukvLsa3J0vS4G3QrgA5gzg1zgtRPSBv82C
         v3xelqL+nlDxj8yzqbi+gN9wQxHmPXLUhvKIM7jtfNS9cfIWZ90FE455cv+ouAM1lu1Q
         J5+8DYT9bCHmRKuq/reKuLDF3dXuWNltO5FF5NfFr3ti4wUpZQUQPzppZiAKvWjDH5I0
         4gvqpmsxJJaocgAjPFxy8DBkFsInxyujn7nQuSdrLmODM8A5dOQzqZ5An8+W3yDnRSTi
         Y8UZmEe4OB+yMDZIXXq2AzqFplaC83MMCVKzgEysDzVzDzRd988gG9hIw6bamDPEnOsi
         FCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2q6Si0UwBGPxtAT45Miuyjn08xJbz2vW3M+s6kVA6UA=;
        b=jftQALGkQjkR5lNSUZdjXLDlkodCxc9fs9eoTN+XLgWF5dZCwmk1yutu2rweWooaa+
         4CIHeRYryC12+H7v/ugr4CAvTNGMa6QWmTr0DF+5VNBUmilqGYy2oP6bhKKFDdk0uepu
         /IoCFXIJG9V75eZpva+cKX4Kil+wfrZ7lkwQiOdMM6iT5MNH+8xc8s0T/j7oZACMz1gP
         W3RnL2RWfY8icnez30EC6crQU9uMUlIaPEbL/lmmzeb8IFyV39jt+H8EvA2umh1eBoKM
         k/KiMstnjYfxNOj0V/jGurfLma/K1tZGxt0raAEiiEBBBuzyb5XCbbil5oofi+QXCxF+
         +cog==
X-Gm-Message-State: AHPjjUjJSFdff8S+TaVJXAlY7Ukti4XD7OoGKcghEQ6PRrJPoNlj2Qgl
        akFZYMF6DL4DFyCqyOPHkAQ=
X-Google-Smtp-Source: AOwi7QDId8sFfivBK3bgCNKzWBmbvbOJk19nTwTZZnL3OSZ/XQdduc4Xq25nDNy5nzHTKyYtZpxuLA==
X-Received: by 10.84.234.194 with SMTP id i2mr1524987plt.420.1506525347750;
        Wed, 27 Sep 2017 08:15:47 -0700 (PDT)
Received: from linux.local ([42.109.141.25])
        by smtp.gmail.com with ESMTPSA id b65sm21289624pfj.97.2017.09.27.08.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 08:15:47 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, malat@debian.org, dom.peklo@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [RFC 0/4] Add Ingenic X1000 SoC Support
Date:   Wed, 27 Sep 2017 20:45:23 +0530
Message-Id: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Add support for Ingenic X1000 SoC. This patch set provides enough bits
to boot a kernel to an initramfs user space.

I implemented this code during 2016. Boot stuck at "calibrating delay
loop ...". Now I have fixed the issue by setting the correct irq. I do
not have access to this device anymore so could not test the fix.
Marking this patch series as RFC as this needs to be tested.

Test and feedback appreciated.

This series enables uart, timer and interrupt controller. As this is
very minimal a static elf binary should be used as init and should be
available in initramfs.

PrasannaKumar Muralidharan (4):
  dt-bindings: Add Ingenic X1000 SoC clock define
  clk: Add Ingenic X1000 CGU driver
  MIPS: Ingenic: Initial X1000 SoC support
  MIPS: Ingenic: Add Halley2 development board support

 arch/mips/boot/dts/ingenic/Makefile    |   1 +
 arch/mips/boot/dts/ingenic/halley2.dts |  46 ++++++++
 arch/mips/boot/dts/ingenic/x1000.dtsi  |  93 +++++++++++++++
 arch/mips/configs/halley2_defconfig    |  61 ++++++++++
 arch/mips/jz4740/Kconfig               |  10 ++
 arch/mips/jz4740/time.c                |   2 +-
 drivers/clk/ingenic/Makefile           |   1 +
 drivers/clk/ingenic/x1000-cgu.c        | 203 +++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/x1000-cgu.h  |  46 ++++++++
 9 files changed, 462 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/boot/dts/ingenic/halley2.dts
 create mode 100644 arch/mips/boot/dts/ingenic/x1000.dtsi
 create mode 100644 arch/mips/configs/halley2_defconfig
 create mode 100644 drivers/clk/ingenic/x1000-cgu.c
 create mode 100644 include/dt-bindings/clock/x1000-cgu.h

-- 
2.10.0
