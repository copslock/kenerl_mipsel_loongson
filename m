Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2015 08:08:55 +0200 (CEST)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33088 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006697AbbFXGIxbgjBs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jun 2015 08:08:53 +0200
Received: by pdjn11 with SMTP id n11so23283053pdj.0;
        Tue, 23 Jun 2015 23:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=R/QCjmjeHW3RJWtH8jkYVD1PhNXj79hMDXfcNK7ICc0=;
        b=mW7xqqrDGjbDu9dWu8xuHf4Vq4XAwdrH0cf6fpPB/rDGQqrzU65ig3MecddYlYUO57
         nIOCYytXrXS2fQ9AnPJoPmckzlpnUwFH0Rj5PKld3aSrFO2CsnNUljVm3EZMLtfWUlmw
         M0ZySoOwPWSBXb7Fc+73vTeeWzhy3nDEBZ4Is2D/ic6CNnFSBC1dKBEv4OQbkRn+NOuK
         nhTJZq02Ozhj+dCx/4qzizfq9e3AdA5bobF19qM4VDEgQwciNTHuSsvxe7HHln/3cx2R
         eXEZeu2cbsR7XTb2DTXruYLoiVNvbjWCGgnMUGs8sKLFMpnG76E839ZYK1f/sM1JN7Pj
         J9pA==
X-Received: by 10.66.222.72 with SMTP id qk8mr76524859pac.7.1435126127135;
        Tue, 23 Jun 2015 23:08:47 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by mx.google.com with ESMTPSA id cd10sm25396180pac.7.2015.06.23.23.08.44
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Jun 2015 23:08:46 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 0/4] MIPS: BMIPS: dts: add NAND device nodes for bcm7xxx platforms
Date:   Wed, 24 Jun 2015 15:08:30 +0900
Message-Id: <cover.1435124524.git.jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.4.4
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48011
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

This patch series contain changing device nodes of the bcm7xxx platforms.

Jaedon Shin (4):
  MIPS: BMIPS: bcm7346: add nodes for NAND
  MIPS: BMIPS: bcm7358: add nodes for NAND
  MIPS: BMIPS: bcm7360: add nodes for NAND
  MIPS: BMIPS: bcm7362: add nodes for NAND

 arch/mips/boot/dts/brcm/bcm7346.dtsi      | 22 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi      | 22 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7360.dtsi      | 22 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi      | 22 ++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts | 23 +++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97358svmb.dts  | 23 +++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97360svmb.dts  | 23 +++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97362svmb.dts  | 23 +++++++++++++++++++++++
 8 files changed, 180 insertions(+)

-- 
2.4.4
