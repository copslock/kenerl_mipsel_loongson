Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 19:40:51 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:42836 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835004Ab3FSRkqKabXJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jun 2013 19:40:46 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UpMN3-0001b5-Iz; Wed, 19 Jun 2013 12:40:37 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 0/2] Revert commits preventing platforms from booting.
Date:   Wed, 19 Jun 2013 12:40:30 -0500
Message-Id: <1371663632-30252-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37014
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

These revert two patches that prevent all MTI and bcm63xx platforms
from booting. The kernel boot quietly hangs and gives not indication
of what happened.

Steven J. Hill (2):
  Revert "MIPS: Move definition of SMP processor id register to header
    file"
  Revert "MIPS: mm: Use scratch for PGD when
    !CONFIG_MIPS_PGD_C0_CONTEXT"

 arch/mips/include/asm/mmu_context.h |   22 ++++--
 arch/mips/include/asm/stackframe.h  |   24 +++++--
 arch/mips/include/asm/thread_info.h |   30 +--------
 arch/mips/mm/tlbex.c                |  135 ++++++++++++++++++++---------------
 4 files changed, 111 insertions(+), 100 deletions(-)

-- 
1.7.2.5
