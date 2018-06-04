Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2018 18:57:24 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:35462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994077AbeFDQ5PqeEUZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jun 2018 18:57:15 +0200
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA8220845;
        Mon,  4 Jun 2018 16:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528131429;
        bh=KxAltdC67B4/gnviqencXrspH0WAlD/JdAsCAwpSvF4=;
        h=From:To:Cc:Subject:Date:From;
        b=pm45TerARRGe7d625OOeYaoBcpjcPnuVtjDxwsvD8aJbHDA/5OSoqjVL1q1QZ1NMp
         dkGRX8L/QX1M4Kuun0oOgeuYcXxUOruKgyPpW4aAhMHACjieIsApfl+WQg5vuDDFZ9
         XhP6e5JdwBRsLDrebD1RYfwNuVDLJzNcoxfjFMdc=
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Maciej W . Rozycki" <macro@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>
Subject: [PATCH] MAINTAINERS: Add Paul Burton as MIPS co-maintainer
Date:   Mon,  4 Jun 2018 17:56:56 +0100
Message-Id: <20180604165656.11589-1-jhogan@kernel.org>
X-Mailer: git-send-email 2.17.1
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64177
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

I soon won't have access to much MIPS hardware, nor enough time to
properly maintain MIPS on my own, so add Paul Burton as a co-maintainer.

Also add a link to a new shared git repository on kernel.org for
linux-next branches and pull request tags.

Signed-off-by: James Hogan <jhogan@kernel.org>
Acked-by: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Matt Redfearn <matt.redfearn@mips.com>
Cc: Maciej W. Rozycki <macro@mips.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: John Crispin <john@phrozen.org>
Cc: Steven J. Hill <Steven.Hill@cavium.com>
Cc: linux-mips@linux-mips.org
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bceccf9c1997..6122e3986c81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9320,10 +9320,12 @@ F:	drivers/usb/image/microtek.*
 
 MIPS
 M:	Ralf Baechle <ralf@linux-mips.org>
+M:	Paul Burton <paul.burton@mips.com>
 M:	James Hogan <jhogan@kernel.org>
 L:	linux-mips@linux-mips.org
 W:	http://www.linux-mips.org/
 T:	git git://git.linux-mips.org/pub/scm/ralf/linux.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 Q:	http://patchwork.linux-mips.org/project/linux-mips/list/
 S:	Supported
 F:	Documentation/devicetree/bindings/mips/
-- 
2.17.1
