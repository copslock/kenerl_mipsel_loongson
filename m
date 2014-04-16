Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 15:08:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:37657 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837187AbaDPNGq1awAe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 15:06:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 21971227BA803;
        Wed, 16 Apr 2014 14:06:36 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 14:06:38 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 14:06:38 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH 37/39] cpuidle: declare cpuidle_dev in cpuidle.h
Date:   Wed, 16 Apr 2014 14:06:30 +0100
Message-ID: <1397653590-4923-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39844
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
index b0238cb..99cbd7a 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -84,6 +84,7 @@ struct cpuidle_device {
 };
 
 DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
+DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
 
 /**
  * cpuidle_get_last_residency - retrieves the last state's residency time
-- 
1.8.5.3
