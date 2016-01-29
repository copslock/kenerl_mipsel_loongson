Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2016 15:03:37 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:47536 "EHLO
        linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010570AbcA2ODdJFpSr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2016 15:03:33 +0100
Received: from localhost (handman.bmw-carit.intra [192.168.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linuxmail.bmw-carit.de (Postfix) with ESMTPS id 2073059CF9;
        Fri, 29 Jan 2016 14:47:27 +0100 (CET)
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, linux-mips@linux-mips.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Maik Broemme <mbroemme@plusserver.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH tip v7 1/7] video: Use bool instead int pointer for get_opt_bool() argument
Date:   Fri, 29 Jan 2016 15:03:22 +0100
Message-Id: <1454076208-28354-2-git-send-email-daniel.wagner@bmw-carit.de>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
References: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.wagner@oss.bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.wagner@bmw-carit.de
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

As the function name already indicates that get_opt_bool() parses
for a bool. It is not a surprise that compiler is complaining
about it when -Werror=incompatible-pointer-types is used:

drivers/video/fbdev/intelfb/intelfbdrv.c: In function ‘intelfb_setup’:
drivers/video/fbdev/intelfb/intelfbdrv.c:353:39: error: passing argument 3 of ‘get_opt_bool’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   if (get_opt_bool(this_opt, "accel", &accel))

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
---
 drivers/video/fbdev/intelfb/intelfbdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/intelfb/intelfbdrv.c b/drivers/video/fbdev/intelfb/intelfbdrv.c
index bbec737..bf20744 100644
--- a/drivers/video/fbdev/intelfb/intelfbdrv.c
+++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
@@ -302,7 +302,7 @@ static __inline__ int get_opt_int(const char *this_opt, const char *name,
 }
 
 static __inline__ int get_opt_bool(const char *this_opt, const char *name,
-				   int *ret)
+				   bool *ret)
 {
 	if (!ret)
 		return 0;
-- 
2.5.0
