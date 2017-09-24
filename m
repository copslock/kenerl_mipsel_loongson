Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Sep 2017 22:40:16 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:33980 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991048AbdIXUhrGLl0z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Sep 2017 22:37:47 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 97A98414;
        Sun, 24 Sep 2017 20:37:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        James.Hogan@imgtec.com, Paul.Burton@imgtec.com,
        Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.9 19/77] MIPS: math-emu: Handle zero accumulator case in MADDF and MSUBF separately
Date:   Sun, 24 Sep 2017 22:32:04 +0200
Message-Id: <20170924203243.631443417@linuxfoundation.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170924203242.904856530@linuxfoundation.org>
References: <20170924203242.904856530@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

commit ddbfff7429a75d954bf5bdff9f2222bceb4c236a upstream.

If accumulator value is zero, just return the value of previously
calculated product. This brings logic in MADDF/MSUBF implementation
closer to the logic in ADD/SUB case.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Cc: James.Hogan@imgtec.com
Cc: Paul.Burton@imgtec.com
Cc: Raghu.Gandham@imgtec.com
Cc: Leonid.Yegoshin@imgtec.com
Cc: Douglas.Leung@imgtec.com
Cc: Petar.Jovanovic@imgtec.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16512/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/math-emu/dp_maddf.c |    5 ++++-
 arch/mips/math-emu/sp_maddf.c |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/arch/mips/math-emu/dp_maddf.c
+++ b/arch/mips/math-emu/dp_maddf.c
@@ -54,7 +54,7 @@ static union ieee754dp _dp_maddf(union i
 		return ieee754dp_nanxcpt(z);
 	case IEEE754_CLASS_DNORM:
 		DPDNORMZ;
-	/* QNAN is handled separately below */
+	/* QNAN and ZERO cases are handled separately below */
 	}
 
 	switch (CLPAIR(xc, yc)) {
@@ -210,6 +210,9 @@ static union ieee754dp _dp_maddf(union i
 	}
 	assert(rm & (DP_HIDDEN_BIT << 3));
 
+	if (zc == IEEE754_CLASS_ZERO)
+		return ieee754dp_format(rs, re, rm);
+
 	/* And now the addition */
 	assert(zm & DP_HIDDEN_BIT);
 
--- a/arch/mips/math-emu/sp_maddf.c
+++ b/arch/mips/math-emu/sp_maddf.c
@@ -54,7 +54,7 @@ static union ieee754sp _sp_maddf(union i
 		return ieee754sp_nanxcpt(z);
 	case IEEE754_CLASS_DNORM:
 		SPDNORMZ;
-	/* QNAN is handled separately below */
+	/* QNAN and ZERO cases are handled separately below */
 	}
 
 	switch (CLPAIR(xc, yc)) {
@@ -203,6 +203,9 @@ static union ieee754sp _sp_maddf(union i
 	}
 	assert(rm & (SP_HIDDEN_BIT << 3));
 
+	if (zc == IEEE754_CLASS_ZERO)
+		return ieee754sp_format(rs, re, rm);
+
 	/* And now the addition */
 
 	assert(zm & SP_HIDDEN_BIT);
