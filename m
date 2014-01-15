Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 15:02:54 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:38410 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827345AbaAOOBkyJI7O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 15:01:40 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH 09/10] cpuidle: declare cpuidle_dev in cpuidle.h
Date:   Wed, 15 Jan 2014 13:55:36 +0000
Message-ID: <1389794137-11361-10-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_14_01_35
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Declaring this allows drivers which need to initialise each struct
cpuidle_device at initialisation time to make use of the structures
already defined in cpuidle.c, rather than having to wastefully define
their own.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 include/linux/cpuidle.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 50fcbb0..bab4f33 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -84,6 +84,7 @@ struct cpuidle_device {
 };
 
 DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
+DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
 
 /**
  * cpuidle_get_last_residency - retrieves the last state's residency time
-- 
1.8.4.2
