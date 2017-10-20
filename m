Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 16:29:14 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58428 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992181AbdJTO3BhRrgQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Oct 2017 16:29:01 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 823D71A47DB;
        Fri, 20 Oct 2017 16:28:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 604E81A47C6;
        Fri, 20 Oct 2017 16:28:55 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martink@posteo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 1/2] MIPS: Update RINT emulation maintainer email address
Date:   Fri, 20 Oct 2017 16:27:44 +0200
Message-Id: <1508509687-3074-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1508509687-3074-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1508509687-3074-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Aleksandar Markovic <aleksandar.markovic@mips.com>

Change all relevant instances of aleksandar.markovic@imgtec.com
email address to aleksandar.markovic@mips.com.

Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index c7b10ca..bd14d63 100644
--- a/.mailmap
+++ b/.mailmap
@@ -15,6 +15,7 @@ Adriana Reus <adi.reus@gmail.com> <adriana.reus@intel.com>
 Alan Cox <alan@lxorguk.ukuu.org.uk>
 Alan Cox <root@hraefn.swansea.linux.org.uk>
 Aleksey Gorelov <aleksey_gorelov@phoenix.com>
+Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic@imgtec.com>
 Al Viro <viro@ftp.linux.org.uk>
 Al Viro <viro@zenIV.linux.org.uk>
 Andreas Herrmann <aherrman@de.ibm.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index a74227a..6e753610 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9019,7 +9019,7 @@ F:	drivers/*/*loongson1*
 F:	drivers/*/*/*loongson1*
 
 MIPS RINT INSTRUCTION EMULATION
-M:	Aleksandar Markovic <aleksandar.markovic@imgtec.com>
+M:	Aleksandar Markovic <aleksandar.markovic@mips.com>
 L:	linux-mips@linux-mips.org
 S:	Supported
 F:	arch/mips/math-emu/sp_rint.c
-- 
2.7.4
