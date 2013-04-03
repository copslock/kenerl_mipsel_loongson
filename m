Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Apr 2013 00:05:52 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:47093 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6828015Ab3DCWFvI3-xz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Apr 2013 00:05:51 +0200
Received: by mail-bk0-f49.google.com with SMTP id w12so1131133bku.22
        for <linux-mips@linux-mips.org>; Wed, 03 Apr 2013 15:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=4XsliBu5LmcjFH0iMPEIW/QjQn8srxztg8vz8oibsMI=;
        b=kO7GBcl2yonxlpj1jNybTI6DFgJ+SC/+0j1A/l4+0eiiYJRq/88Bjie+ob7NwjIfIz
         tCvIvaqb7AWdj3DZBMvbaN1o+2ScKfCTLqwnvkJBXBoXlr/ayPwpX8w5PhAjIeqKqsbN
         VMdgPyIgGhQ4+59weva9hPaq7BPsaUenSR7PGYDsV2fySGM37BkdLGNuvwhoBYGwJNQ7
         pBnDvXGxH+9Q1owranvOOPz63auJoHZHM1uQ51MUw3T1spWCyfo49kkfg7KDWfAN3MbA
         8xl1/HJEjt8wQMHVmqYTrwjqgx8kQjSlK/2YjxRrEeh12JQeK0Y+gjTFoy6z5tmlMZKi
         FQmA==
X-Received: by 10.205.104.8 with SMTP id dk8mr2570493bkc.34.1365026745360;
        Wed, 03 Apr 2013 15:05:45 -0700 (PDT)
Received: from localhost.localdomain ([77.70.100.51])
        by mx.google.com with ESMTPS id fs20sm4176710bkc.8.2013.04.03.15.05.43
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Apr 2013 15:05:44 -0700 (PDT)
From:   Svetoslav Neykov <svetoslav@neykov.name>
To:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Svetoslav Neykov <svetoslav@neykov.name>
Subject: [PATCH v3 0/1] Chipidea driver support for the AR933x platform
Date:   Thu,  4 Apr 2013 01:04:45 +0300
Message-Id: <1365026686-4131-1-git-send-email-svetoslav@neykov.name>
X-Mailer: git-send-email 1.7.9.5
X-Gm-Message-State: ALoCoQkACn0mb/ldkwhkA1AFvzU+PBZK0CpQyZG90E2ZEokvQuA7OQCIP0Q45rCZ4v/QpFLbTteY
X-archive-position: 36009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: svetoslav@neykov.name
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add support for the usb controller in AR933x platform.
The controller supports both host or device mode (defined at startup) 
but not OTG. 
The patches are tested on WR703n router running OpenWRT in device mode.

Changes since v2:
Removed the glue driver, now dev-usb.c directly registers ci_hdrc.
Changes to follow the style of the existing code.

Svetoslav Neykov (1):
  usb: chipidea: AR933x platform support for the chipidea driver

 arch/mips/ath79/dev-usb.c                      |   42 ++++++++++++++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 ++
 2 files changed, 45 insertions(+)

-- 
1.7.9.5
