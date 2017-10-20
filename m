Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2017 16:29:41 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58525 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992366AbdJTO3QZpoSQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Oct 2017 16:29:16 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 5706F1A4803;
        Fri, 20 Oct 2017 16:29:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local [10.10.13.111])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 3743A1A47DC;
        Fri, 20 Oct 2017 16:29:10 +0200 (CEST)
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
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
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
Subject: [PATCH 2/2] MIPS: Update Goldfish RTC driver maintainer email address
Date:   Fri, 20 Oct 2017 16:27:45 +0200
Message-Id: <1508509687-3074-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1508509687-3074-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1508509687-3074-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60499
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

Change all relevant instances of miodrag.dinic@imgtec.com
email address to miodrag.dinic@mips.com.

Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index bd14d63..2494b4b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -118,6 +118,7 @@ Matt Ranostay <matt.ranostay@konsulko.com> <matt@ranostay.consulting>
 Mayuresh Janorkar <mayur@ti.com>
 Michael Buesch <m@bues.ch>
 Michel Dänzer <michel@tungstengraphics.com>
+Miodrag Dinic <miodrag.dinic@imgtec.com> <miodrag.dinic@mips.com>
 Mitesh shah <mshah@teja.com>
 Mohit Kumar <mohit.kumar@st.com> <mohit.kumar.dhaka@gmail.com>
 Morten Welinder <terra@gnome.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 6e753610..4a3de82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -873,7 +873,7 @@ F:	drivers/android/
 F:	drivers/staging/android/
 
 ANDROID GOLDFISH RTC DRIVER
-M:	Miodrag Dinic <miodrag.dinic@imgtec.com>
+M:	Miodrag Dinic <miodrag.dinic@mips.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
 F:	drivers/rtc/rtc-goldfish.c
-- 
2.7.4
