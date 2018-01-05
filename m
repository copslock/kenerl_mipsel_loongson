Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 22:37:44 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:43844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990439AbeAEVhgd-Rbg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Jan 2018 22:37:36 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94C912075B;
        Fri,  5 Jan 2018 21:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C912075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        David Daney <david.daney@cavium.com>,
        John Crispin <john@phrozen.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>
Subject: [PATCH] MAINTAINERS: Add James as MIPS co-maintainer
Date:   Fri,  5 Jan 2018 21:36:47 +0000
Message-Id: <20180105213647.28850-1-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

I've been taking on some co-maintainer duties already, so lets make it
official in the MAINTAINERS file.

Link: https://lkml.kernel.org/r/33db77a2-32e4-6b2c-d463-9d116ba55623@imgtec.com
Link: https://lkml.kernel.org/r/20171207110549.GM27409@jhogan-linux.mipstec.com
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: David Daney <david.daney@cavium.com>
Cc: John Crispin <john@phrozen.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Matt Redfearn <matt.redfearn@mips.com>
Cc: linux-mips@linux-mips.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d3d750b19c0..61bccbd3715f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8983,6 +8983,7 @@ F:	drivers/usb/image/microtek.*
 
 MIPS
 M:	Ralf Baechle <ralf@linux-mips.org>
+M:	James Hogan <jhogan@kernel.org>
 L:	linux-mips@linux-mips.org
 W:	http://www.linux-mips.org/
 T:	git git://git.linux-mips.org/pub/scm/ralf/linux.git
-- 
2.13.6
