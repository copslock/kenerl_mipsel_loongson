Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 May 2015 03:11:19 +0200 (CEST)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35981 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026383AbbEEBLRT27NP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 May 2015 03:11:17 +0200
Received: by pabsx10 with SMTP id sx10so175999317pab.3;
        Mon, 04 May 2015 18:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=C/IkVCRcbdlQlryfQ7Sx8qLQqTTctTTFH7/MTY5Uh/I=;
        b=uKTODTokj/qevqBaVphSuVqYtUS9M3Jx/6vAjjGzWE19P3IfKgOjS259xC9SCd4cTw
         MpEAch1fofnHqPPmizoBeHz1W0E9Fhff9JjKeEkHLaFLnM8KHFrTS4AOO1v1pO5Qol35
         jZl2EBbjqVrIW4Errh3Y7v9yuZZaz/LyrxWRNxqMp9UrFEfDnR5rcGZvF+cqBELztGk5
         opuCz+lMBNtfOi8rL/s5STZMdl5FCBgyk5Hd+VOpCiZDLOLE6PhIhh4MZ4430UonQ3yX
         +Ahme3jTtF8e7eB9bALJov8QrtpsgMIz8paePB0l1PW6+jgY1UNsaSt+q9L4G6A40WpZ
         XJMA==
X-Received: by 10.66.156.225 with SMTP id wh1mr48051014pab.100.1430788273237;
        Mon, 04 May 2015 18:11:13 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id nt15sm14030698pdb.14.2015.05.04.18.11.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 May 2015 18:11:12 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@chromium.org,
        Steven.Hill@imgtec.com, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/2] MIPS: BMIPS: 7435 support
Date:   Mon,  4 May 2015 18:10:55 -0700
Message-Id: <1430788257-10244-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

This patch series adds support for Broadcom's 7435 SoC which features
a dual-threaded dual-core BMIPS5200.

We will need some modifications to some of our interrupt controllers drivers
to properly support a SMP configuration that exposes 4 CPUs, which is why
we ourselves to a single CPU for now.

Florian Fainelli (2):
  MIPS: BMIPS: add BCM7435 dtsi
  MIPS: BMIPS: add support for Broadcom BCM97435SVMB

 arch/mips/bmips/Kconfig                  |   4 +
 arch/mips/boot/dts/brcm/Makefile         |   1 +
 arch/mips/boot/dts/brcm/bcm7435.dtsi     | 239 +++++++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts |  60 ++++++++
 4 files changed, 304 insertions(+)
 create mode 100644 arch/mips/boot/dts/brcm/bcm7435.dtsi
 create mode 100644 arch/mips/boot/dts/brcm/bcm97435svmb.dts

-- 
2.1.0
