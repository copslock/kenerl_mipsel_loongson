Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jan 2016 00:57:10 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36661 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006525AbcAQX5JUF-9D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jan 2016 00:57:09 +0100
Received: by mail-lb0-f177.google.com with SMTP id oh2so339170541lbb.3
        for <linux-mips@linux-mips.org>; Sun, 17 Jan 2016 15:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OR8TLeUGJRbRm7GZwdTi2CTxY586BE3bZ/BypDXnglk=;
        b=L9N9XzDOVQ0DozpIqoWuuEYvfemcvDpsdcpz1Ue8S8H1i23StxoYHJB13XglG8iyPR
         TrGS6SyJ5IkR1oNjRQe0VVajxs2gd5WS5TxDZa2tqsS+6sBEfcn9KJP02dpSu4VyhedY
         q9Ci5DA/iGWt6wMGs8WD0U0O2FPBRLcVmc/4IadJ5d6FDs53Z1aU/EpYWV5GpmT2IVXc
         +hfUzZoWJP2ODsiuwykBU/8mku5e4PLXTzWGNb5fdtqpCVOV7CAW6rnqPgB3SZ3vPV36
         uRD99OuxNjNqV+a53xi1Gwv14MkbegMCWzitlneqtWUkMIK+nlM+yIKQnoxNmgaPkAKS
         QtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OR8TLeUGJRbRm7GZwdTi2CTxY586BE3bZ/BypDXnglk=;
        b=UTd6UkfZ18dwHEYZdmpfFXLtYOU+wDnGzzJxx7QMjgU05RkP3DHny7HV8RPvW03wQf
         wnPzDIrOg69Z+2cPeONrPCgf9LJOeCXjWGcaGfdmxpbY8nALmbfqxZemrranIsaMNQl9
         V99H9AnCet2ozaMb/sdrpdO4Z52ivowp9lJ+rN0dGx8egxOvXefF2f1YWW2tVoYmludS
         yYkvGEUEBU9DTeaT+qWroAPqVmAxQeWT3ZjMueRSTbVZ4qXVxsNj8BbRfl3H+d2hmF6P
         Bzg/8EvL7qyM4Nwm9XeuynXcY2K1wMCe6676//a8uT4KTXlmnt3l/K0I+/CCwIBCuQ6J
         vreg==
X-Gm-Message-State: ALoCoQmZkIpuyxK3opzE9SMdWZsw6QJc7uVOYS3p4/tb2RDePfpeUOePuS1URTGsHavHOpxyqxi6Ij/f3VBfodPJmjW4vTVrkQ==
X-Received: by 10.112.134.165 with SMTP id pl5mr7374103lbb.126.1453075023831;
        Sun, 17 Jan 2016 15:57:03 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id xe8sm2783445lbb.41.2016.01.17.15.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jan 2016 15:57:03 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Yegor Yefremov <yegorslists@googlemail.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>
Subject: [RFC 0/4] MIPS: ath79: introduce AR9331 devicetree support
Date:   Mon, 18 Jan 2016 02:56:23 +0300
Message-Id: <1453074987-3356-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51180
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

This patchseries also can be found on github:

     https://github.com/frantony/linux/tree/20160118.v4.4-mr3020-dt

Antony Pavlov (4):
  WIP: MIPS: ath79: make ar933x clks more devicetree-friendly
  MIPS: dts: qca: introduces AR9331 devicetree
  MIPS: ath79: add initial support for TP-LINK MR3020
  WIP: MIPS: add tl-mr3020-dt-raw_defconfig

 arch/mips/ath79/Kconfig                      |   5 ++
 arch/mips/ath79/clock.c                      |  20 +++--
 arch/mips/boot/dts/qca/Makefile              |   1 +
 arch/mips/boot/dts/qca/ar9331.dtsi           | 113 +++++++++++++++++++++++++++
 arch/mips/boot/dts/qca/tl_mr3020.dts         |  68 ++++++++++++++++
 arch/mips/configs/tl-mr3020-dt-raw_defconfig |  85 ++++++++++++++++++++
 include/dt-bindings/clock/ar933x-clk.h       |  22 ++++++
 7 files changed, 307 insertions(+), 7 deletions(-)
 create mode 100644 arch/mips/boot/dts/qca/ar9331.dtsi
 create mode 100644 arch/mips/boot/dts/qca/tl_mr3020.dts
 create mode 100644 arch/mips/configs/tl-mr3020-dt-raw_defconfig
 create mode 100644 include/dt-bindings/clock/ar933x-clk.h

Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org

-- 
2.6.2
