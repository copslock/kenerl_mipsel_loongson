Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2015 04:37:58 +0200 (CEST)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34337 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007397AbbJUCh5N7CTy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2015 04:37:57 +0200
Received: by padhk11 with SMTP id hk11so39489015pad.1;
        Tue, 20 Oct 2015 19:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1t//3uMSAjk+KMkK6Kn50vZhvyoTifoZMgro//4Bnyw=;
        b=0nwQpHzwTl27ZicbXWWJ32g11d+bYt7wUhMhsvxous8EbKERRJ194sp/nyrGHWR8XT
         Kyd2aiph83mIOSUZBq4NKw2wPd8l85BD8Xqij1diJ9uqFk4wc6XdxrvxLPjR6yvgzQBl
         xanLeQQ/CB27rtKYCh3CbYiF7h2sf0m5KB12nzgOoaulOeketZgWpGksR6FwOWE+Z/3w
         qciBPmBot3XQmiNk1hH5JUR6GDSWnWDsh0IxGxMV8TXtK5kbzuiHcyON0dK36Rx8bWD7
         mI1hWAfRBVAefQWZnlupciSlDyQUnt7sljvHavWJPGgDWgAA8Ey0DZV7//zEoXG94YOr
         uHtQ==
X-Received: by 10.68.194.133 with SMTP id hw5mr7742355pbc.25.1445395070950;
        Tue, 20 Oct 2015 19:37:50 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id bs3sm6137263pbd.89.2015.10.20.19.37.48
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 19:37:50 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 0/9] i2c: brcmstb: add support for BMIPS_GENERIC
Date:   Wed, 21 Oct 2015 11:36:52 +0900
Message-Id: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.1
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Hi all,

This patch series adds support for BMIPS_GENERIC, and fixes running conditions.

Thanks.

Jaedon Shin (9):
  i2c: brcmstb: make the driver buildable on BMIPS_GENERIC
  i2c: brcmstb: fix typo in i2c-brcmstb
  i2c: brcmstb: add missing parenthesis
  i2c: brcmstb: enable ACK condition
  i2c: brcmstb: fix start and stop conditions
  MIPS: BMIPS: brcmstb: add I2C node for bcm7346
  MIPS: BMIPS: brcmstb: add I2C node for bcm7358
  MIPS: BMIPS: brcmstb: add I2C node for bcm7360
  MIPS: BMIPS: brcmstb: add I2C node for bcm7362

 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 72 ++++++++++++++++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7358.dtsi      | 62 +++++++++++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 62 +++++++++++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 52 +++++++++++++++++++++-
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts | 20 +++++++++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts  | 16 +++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  | 16 +++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  | 12 ++++++
 drivers/i2c/busses/Kconfig                |  2 +-
 drivers/i2c/busses/i2c-brcmstb.c          | 11 +++--
 10 files changed, 310 insertions(+), 15 deletions(-)

-- 
2.6.1
