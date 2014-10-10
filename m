Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2014 00:29:17 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:36767
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27010897AbaJJW3PTgBnj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2014 00:29:15 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 00/10] MIPS: lantiq: various fixes
Date:   Sat, 11 Oct 2014 00:02:24 +0200
Message-Id: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

This is the firt lot of patches that have been staged inside openwrt for a
while. There are also fixes for pinctrl, serial and gpio coming up and 2 new
drivers for nand and i2c on falcon.

John Crispin (10):
  MIPS: lantiq: handle vmmc memory reservation
  MIPS: lantiq: add reset-controller api support
  MIPS: lantiq: reboot gphy on restart
  MIPS: lantiq: add support for xrx200 firmware depending on soc type
  MIPS: lantiq: export soc type
  MIPS: lantiq: move eiu init after irq_domain register
  MIPS: lantiq: copy the commandline from the devicetree
  MIPS: lantiq: the detection of the gpe clock is broken
  MIPS: lantiq: add missing spi clock on falcon SoC
  MIPS: lantiq: refactor the falcon sysctrl code

 arch/mips/Kconfig                          |    2 +
 arch/mips/include/asm/mach-lantiq/lantiq.h |    2 +
 arch/mips/lantiq/falcon/sysctrl.c          |  108 ++++++++++++----------------
 arch/mips/lantiq/irq.c                     |   48 ++++++-------
 arch/mips/lantiq/prom.c                    |    7 ++
 arch/mips/lantiq/xway/Makefile             |    2 +
 arch/mips/lantiq/xway/reset.c              |   70 +++++++++++++++++-
 arch/mips/lantiq/xway/vmmc.c               |   69 ++++++++++++++++++
 arch/mips/lantiq/xway/xrx200_phy_fw.c      |   23 +++++-
 9 files changed, 244 insertions(+), 87 deletions(-)
 create mode 100644 arch/mips/lantiq/xway/vmmc.c

-- 
1.7.10.4
