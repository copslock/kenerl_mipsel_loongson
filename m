Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2017 13:03:47 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:35850
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991087AbdBNMDiuus7R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2017 13:03:38 +0100
Received: by mail-wm0-x242.google.com with SMTP id r18so3206478wmd.3;
        Tue, 14 Feb 2017 04:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pM7Ru6GsTzvarj8QaLNQG29vmHEQMYCm4qwAEGVZYJQ=;
        b=PsST1DGTRi3BdKpLToF3s7MGd0krTk4UZUYmgEQ9WwZ33zI4YPRuUEmwwp4zt8pmpT
         +gsPfeNvOUNhdu7DeoKE/0AdNwSRWwdLjUqyLHjjQ0O4bzFPpQdtSOTdvcBF2Vu07Ftr
         URhREUywye/CYESA6QSEw/xUZpspiPF7OwBZ0r7LjZ+qFD7vWZN/Sd8Jhg8vQ2WiOnLs
         NFWMDbxe1OoY6kJVje959yniH+YqO6s+hK3tQMbxby4LnOE7BcixKFrUWTeXHM61/i13
         YScj1J5nLZCkUxq6Frcd9kksiKaQNogkDI6Ulpw2C+Yc0xWMt9iFEK0LWQ891kgMQzbH
         JeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pM7Ru6GsTzvarj8QaLNQG29vmHEQMYCm4qwAEGVZYJQ=;
        b=GqbrCVjzxI7pRmmLn7TnkS46bUx4tfCxW40KVP0wxaEkoyWxCMZY5nYRtzP8W2elwz
         tsJZbnlLWrOOUXqY0XjFYULMkxGmEUumkEFEz3y+PrH9/lz6TPou7ymAbYTbF6lkMW/4
         +ZhjgDXmpHo2mm0JDo7pXFxGXmFA9zijt/jSl2FSk1A0p+1MHzCrnU6DeEPNdcI5qCKQ
         pQPwHBmCm5Iy+tpnfu/lzhnWkvhkHu8BPHigb32VfNLYGR2VaXUFJNhFmOa1r/dVQ3zR
         LtzwWDRQDwTG28A+HWGdYMOKRkUO+yyScdvX2kvXLoZkZzDevEfGjlVZBgyBPYC+HeEJ
         Tlkw==
X-Gm-Message-State: AMke39kfPC1FZ/hH984exhe9OL7IG53XulgLURqIfV3iB9BB+oz8e3IvElVfFE+tmFh1Mw==
X-Received: by 10.28.142.16 with SMTP id q16mr2866576wmd.78.1487073813234;
        Tue, 14 Feb 2017 04:03:33 -0800 (PST)
Received: from dargo.Speedport_W_724V_Typ_A_05011603_05_020 (p200300C023CC14391746B39401FFCB78.dip0.t-ipconnect.de. [2003:c0:23cc:1439:1746:b394:1ff:cb78])
        by smtp.gmail.com with ESMTPSA id e71sm1030339wma.8.2017.02.14.04.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 04:03:32 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 0/3] MIPS: random Alchemy stuff
Date:   Tue, 14 Feb 2017 13:03:25 +0100
Message-Id: <20170214120328.240326-1-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.11.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Random inoffensive stuff I accumulated during the last year:
- threaded carddetect interrupts for devboard pcmcia and mmc sockets
- updated cpu feature overrides (the patch shaves about 40kB off
  db1xxx defconfig)
- add machine info to /proc/cpuinfo output

All tested with 4.10-rc7 on db1100/db1200/db1300 and db1500.

Thanks!
     Manuel

Manuel Lauss (3):
  MIPS: Alchemy: add machine type to cpuinfo
  MIPS: Alchemy: update cpu feature overrides
  MIPS: Alchemy: Threaded carddetect irqs for devboards

 arch/mips/alchemy/devboards/db1200.c               | 64 ++++++++++++----------
 arch/mips/alchemy/devboards/db1300.c               | 31 ++++++-----
 arch/mips/alchemy/devboards/db1xxx.c               |  2 +
 .../asm/mach-au1x00/cpu-feature-overrides.h        | 26 +++++++++
 drivers/pcmcia/db1xxx_ss.c                         | 33 ++++++-----
 5 files changed, 100 insertions(+), 56 deletions(-)

-- 
2.11.1
