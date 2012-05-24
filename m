Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2012 22:56:03 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:42845 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903735Ab2EXUz6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 May 2012 22:55:58 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SXf4a-0003sB-GW; Thu, 24 May 2012 15:55:52 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 0/4] Optimise core MIPS library functions for microMIPS.
Date:   Thu, 24 May 2012 15:55:38 -0500
Message-Id: <1337892942-24492-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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

From: "Steven J. Hill" <sjhill@mips.com>

Steven J. Hill (4):
  MIPS: Optimise core library function 'memset' for microMIPS.
  MIPS: Optimise core library function 'strncpy' for microMIPS.
  MIPS: Optimise core library function 'strlen' for microMIPS.
  MIPS: Optimise core library function 'strnlen' for microMIPS.

 arch/mips/include/asm/asm.h  |    2 +
 arch/mips/lib/memset.S       |   84 +++++++++++++++++++++++++++---------------
 arch/mips/lib/strlen_user.S  |    9 +++--
 arch/mips/lib/strncpy_user.S |   28 +++++++-------
 arch/mips/lib/strnlen_user.S |    2 +-
 5 files changed, 77 insertions(+), 48 deletions(-)

-- 
1.7.10
