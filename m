Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2014 15:01:05 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:47666 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6871413AbaBTOAEbUA8X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Feb 2014 15:00:04 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/5] Update Malta defconfigs
Date:   Thu, 20 Feb 2014 14:00:23 +0000
Message-ID: <1392904828-12969-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_02_20_13_59_58
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Hi,

This patchset updates the Malta defconfigs and adds a new
one for SMVP/EVA.

Therefore, it needs to be applied after the EVA patchset.

The patchset is based on top of the upstream-sfr/mips-for-linux-next tree

Markos Chandras (2):
  MIPS: Malta: Enable DEVTMPFS
  MIPS: Add defconfig for Malta SMVP with EVA

Paul Burton (3):
  MIPS: regenerate malta defconfigs
  MIPS: Set page size to 16KB for malta SMP defconfigs
  MIPS: Default NR_CPUS=8 for malta SMP defconfigs

 arch/mips/configs/malta_defconfig           |   9 +-
 arch/mips/configs/malta_kvm_defconfig       |  10 +-
 arch/mips/configs/malta_kvm_guest_defconfig |   7 +-
 arch/mips/configs/maltaaprp_defconfig       |   3 +-
 arch/mips/configs/maltasmtc_defconfig       |   4 +-
 arch/mips/configs/maltasmvp_defconfig       |   5 +-
 arch/mips/configs/maltasmvp_eva_defconfig   | 200 ++++++++++++++++++++++++++++
 arch/mips/configs/maltaup_defconfig         |   3 +-
 8 files changed, 214 insertions(+), 27 deletions(-)
 create mode 100644 arch/mips/configs/maltasmvp_eva_defconfig

-- 
1.8.5.5
