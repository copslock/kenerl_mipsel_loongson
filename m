Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:49:37 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:54986 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903761Ab2FZEtb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:49:31 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNba-0002zj-Gx; Mon, 25 Jun 2012 23:42:22 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 33/33] MIPS: vr41xx: Cleanup files effected by firmware changes.
Date:   Mon, 25 Jun 2012 23:41:48 -0500
Message-Id: <1340685708-14408-34-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33818
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

Make headers consistent across the files and make changes based on
running the checkpatch script.
---
 arch/mips/vr41xx/common/init.c |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/mips/vr41xx/common/init.c b/arch/mips/vr41xx/common/init.c
index a4c1f02..6706864 100644
--- a/arch/mips/vr41xx/common/init.c
+++ b/arch/mips/vr41xx/common/init.c
@@ -1,21 +1,11 @@
 /*
- *  init.c, Common initialization routines for NEC VR4100 series.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  Copyright (C) 2003-2009  Yoichi Yuasa <yuasa@linux-mips.org>
+ * init.c, Common initialization routines for NEC VR4100 series.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * Copyright (C) 2003-2009  Yoichi Yuasa <yuasa@linux-mips.org>
  */
 #include <linux/init.h>
 #include <linux/ioport.h>
-- 
1.7.10.3
