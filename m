Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 22:55:41 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:58485 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835276Ab3FMUzUC1XxC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jun 2013 22:55:20 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UnEY4-0005JR-2W; Thu, 13 Jun 2013 15:55:12 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH 0/3] Clean up soft reset code for MTI platforms.
Date:   Thu, 13 Jun 2013 15:55:03 -0500
Message-Id: <1371156906-31563-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

This patchset fixes the SEAD-3 platform so that a soft reset can
be performed. The SOFTRES_REG and GORESET definitions are moved
out of the generic header and into the indivdual platform files.

Steven J. Hill (3):
  MIPS: sead3: Fix ability to perform a soft reset.
  MIPS: malta: Move defines of reset registers and values.
  MIPS: malta: Remove software reset defines from generic header.

 arch/mips/include/asm/mips-boards/generic.h |    6 -----
 arch/mips/mti-malta/malta-reset.c           |   33 ++++++--------------------
 arch/mips/mti-sead3/sead3-reset.c           |    5 ++-
 3 files changed, 11 insertions(+), 33 deletions(-)

-- 
1.7.2.5
