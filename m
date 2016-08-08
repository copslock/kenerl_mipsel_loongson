Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Aug 2016 04:17:52 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35213 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991960AbcHHCRqYsBOX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Aug 2016 04:17:46 +0200
Received: by mail-pf0-f193.google.com with SMTP id h186so23996397pfg.2;
        Sun, 07 Aug 2016 19:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ae2uOy4QfBuWschEi/lFKGuaYkKt8vhQL8jUoPikFFk=;
        b=WI/JO20Mt/XyIFOPf1HrKgu/7uYFTByzJAHdQ/IY0/9DPZeSQNUJIJ+DDKFRNrkljv
         A6r6awgrwRnMMWncFdbLB/jrzxr2FynIqb95WFvQ6Ju7C691ifOjUTk6vOENt7ux+4Rj
         o9rgzWX6CU+XDIYvDtHpJhTPIpXSCIiQpanmG4HGmsJtI6I1MdAudW8BbpSPzjITi2oN
         NdOK/fxY884IJXgw57nCc3gaSAIbzBsTiVquuXlYcCZwqhnqlt6WjZWdgoClh5oue1pC
         kb1508/H6h6zYsHRGwXUEYrzlfNgpIsKopwwQDeUOIU9b/Oojy5J1UNKwNXHIsKSm9zK
         1Vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ae2uOy4QfBuWschEi/lFKGuaYkKt8vhQL8jUoPikFFk=;
        b=PXCIr05VoAjN4UGbCmz+tH75uKVY8exsEJbQFMkWw/YKQ24MVTVfIL6mM7xzX8bsyK
         Ovc5c80zzHNAagnFcXXvqLGvtb1v9EpTk+idnPbaCzWc0XmNoYzZ1JtjGS44lmeTX9mM
         ZKcwAadmQkPs3Saj0VZTt3/4VwMScik0UoywdrKY38eBSNB1ZSitHEuFMkal/9tUDTF3
         07QW2vsP3NFiQq9eiI6ivetxZlu8+poBfl4RjkJm720dCuZIs10H2nB8IMJR6yl17vrs
         FTMLuywuxJECEnxRxBsU/1x7PFalgTXy9Hb9rLbjs14B4R8Gq+C2Su4CgUkp0Io233o0
         k//g==
X-Gm-Message-State: AEkoouuvCFLJKHpEj7VX0xVtxnQ2y/7huBdiNsYTvNZ7c7o+G2FIaA88IiWKPDvN36Axzw==
X-Received: by 10.98.35.7 with SMTP id j7mr158572141pfj.39.1470622660275;
        Sun, 07 Aug 2016 19:17:40 -0700 (PDT)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id r2sm12701468pal.14.2016.08.07.19.17.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 07 Aug 2016 19:17:39 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@linux-mips.org,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 0/4] Add device nodes for BCM7xxx SoCs
Date:   Mon,  8 Aug 2016 11:17:15 +0900
Message-Id: <20160808021719.4680-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.9.2
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54418
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

This patch series adds support for Broadcom BCM7xxx MIPS based SoCs.

The NAND device nodes have common file including chip select, BCH
and partitions for the reference board with the same properties.

Jaedon Shin (4):
  MIPS: BMIPS: Add support PWM device nodes
  MIPS: BMIPS: Add support GPIO device nodes
  MIPS: BMIPS: Add support SDHCI device nodes
  MIPS: BMIPS: Add support NAND device nodes

 arch/mips/boot/dts/brcm/bcm7125.dtsi               | 46 ++++++++++
 arch/mips/boot/dts/brcm/bcm7346.dtsi               | 87 +++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi               | 79 +++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi               | 79 +++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi               | 79 +++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7420.dtsi               | 54 ++++++++++++
 arch/mips/boot/dts/brcm/bcm7425.dtsi               | 99 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi               | 99 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7xxx-nand-cs1-bch8.dtsi | 24 ++++++
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts           | 13 +++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          | 25 ++++++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts           | 21 +++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts           | 21 +++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts           | 21 +++++
 arch/mips/boot/dts/brcm/bcm97420c.dts              | 17 ++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts           | 29 +++++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts           | 29 +++++++
 17 files changed, 822 insertions(+)
 create mode 100644 arch/mips/boot/dts/brcm/bcm7xxx-nand-cs1-bch8.dtsi

-- 
2.9.2
