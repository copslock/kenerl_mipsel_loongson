Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 07:19:29 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:49488 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006895AbbCDGSfzJXTf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 07:18:35 +0100
Received: from localhost (unknown [166.170.43.162])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4F6A2990;
        Wed,  4 Mar 2015 06:18:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.18 071/151] MIPS: asm: pgtable: Add c0 hazards on HTW start/stop sequences
Date:   Tue,  3 Mar 2015 22:13:25 -0800
Message-Id: <20150304055509.131103263@linuxfoundation.org>
X-Mailer: git-send-email 2.3.1
In-Reply-To: <20150304055457.084276421@linuxfoundation.org>
References: <20150304055457.084276421@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46136
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit 461d1597ffad7a826f8aaa63ab0727c37b632e34 upstream.

When we use htw_{start,stop}() outside of htw_reset(), we need
to ensure that c0 changes have been propagated properly before
we attempt to continue with subsequence memory operations.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9114/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/pgtable.h |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -99,16 +99,20 @@ extern void paging_init(void);
 
 #define htw_stop()							\
 do {									\
-	if (cpu_has_htw)						\
+	if (cpu_has_htw) {						\
 		write_c0_pwctl(read_c0_pwctl() &			\
 			       ~(1 << MIPS_PWCTL_PWEN_SHIFT));		\
+		back_to_back_c0_hazard();				\
+	}								\
 } while(0)
 
 #define htw_start()							\
 do {									\
-	if (cpu_has_htw)						\
+	if (cpu_has_htw) {						\
 		write_c0_pwctl(read_c0_pwctl() |			\
 			       (1 << MIPS_PWCTL_PWEN_SHIFT));		\
+		back_to_back_c0_hazard();				\
+	}								\
 } while(0)
 
 
@@ -116,9 +120,7 @@ do {									\
 do {									\
 	if (cpu_has_htw) {						\
 		htw_stop();						\
-		back_to_back_c0_hazard();				\
 		htw_start();						\
-		back_to_back_c0_hazard();				\
 	}								\
 } while(0)
 
