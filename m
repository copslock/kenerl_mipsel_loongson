Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 19:55:31 +0100 (CET)
Received: from mout.web.de ([212.227.17.12]:50236 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992221AbdARSzYZSBS- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Jan 2017 19:55:24 +0100
Received: from [192.168.1.2] ([78.48.198.118]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lk8gg-1d0EBx3MHi-00c89r; Wed, 18
 Jan 2017 19:54:32 +0100
Subject: [PATCH 1/3] MIPS: Return directly in 32_mmap2()
To:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>
References: <bb402413-83e5-9b34-304c-9f4bca6037d9@users.sourceforge.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <82853b63-432d-a012-5791-139fee51a0a5@users.sourceforge.net>
Date:   Wed, 18 Jan 2017 19:54:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <bb402413-83e5-9b34-304c-9f4bca6037d9@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:J0CQOMSEIROrg+zLq/TOLFEkS3y/h10Slfnsg0aaBccFpn5kQs+
 frmavbSiZznv3RFwjiq5Nr8SpDaw1EqOh++Lg3cLhem/eQKI9VLIvrzihK5Wf9KAgZxNci1
 ckPFd9GwzrYcHKwOjsDzLlbLFZMVPiUomaxsH9DplQ0kFFR+aQUK7Rvkhw4gIr7WXZZAiNB
 fTjsqfMqQoNCZ9qMjYH9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:whjC+q356HA=:4eX2n/IPahb5qEpRa6GPbX
 I/bbuwidYy1koGnKjrX9adiBJyTuG5o3/buGB4mdrgnrSeWMGSqM4ixqQnubi7ioCQyWD0ga0
 xGWr3VZM+JPLna37OlJGE9jlS+svLMzSQS19fuZAj21w1O63P0P9tFfQCkziFcoVT6KvgUOSy
 xNIvuMYCTsiTvubH+7MDsxZK351W+xox9bpoirh1wusPDSBT262+PbnVhMq98FoaJBH5Ws6wu
 sxjxnPG/JuJ3jMbcdDGy2ZH7t50vkLryg5dfWw2hPmjd0mUq3LO5aKRx2dpKo/y/t59i/kJPc
 YKqmcpNQjAmTHvUwHRcEnLphxyqxNDS9R9qwsw5KirkUiAcGmnITxZ4IpTehd0wIuWoFyJ2eg
 YsaItZ+edR077wucdsRMp/7K8B/UtuXhykgvffUMi5y5Q09vFPveflBBrl8uxFAE8q2D+25mk
 WylZolICY/aWlwX0OHu7FWybCw7sXC8sZsONzbR7YtiYTo13akr7UQkRXLSiZMY5lSS1I2y3O
 4k5eeIII+9WfxcpM0+I60LQjkwWL4jj0w9MiAm5KZhBhArh/L0pLCQBRt4cFr3+3mqTMWQbWZ
 cTtwwq3WBWzBHlvBBqqjumZLvxMcgWjH890GWWvkrHu9XHhz/rsQfZOhlM9BZwdwnLopBheP2
 QEoG19HDZugiQJMKqY87o6sTblUHuBpPXAkGGgXiOBzbiV6zDfOycr31dUMP8jtaSKiFjOTG4
 TbH4CcTt+8LTyS1HWlIt7KJjnRbf3NoQyhwn/BzNydwAxAw6Vd6UKx+NVMLVy+W+12kpUdcvD
 mtgSxGQ
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Jan 2017 19:00:05 +0100

* Return a failure indication without storing it
  in an intermediate variable.

* Delete the local variable "error" which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/kernel/linux32.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 50fb62544df7..6fa6cdfa6e22 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -64,15 +64,10 @@ SYSCALL_DEFINE6(32_mmap2, unsigned long, addr, unsigned long, len,
 	unsigned long, prot, unsigned long, flags, unsigned long, fd,
 	unsigned long, pgoff)
 {
-	unsigned long error;
-
-	error = -EINVAL;
 	if (pgoff & (~PAGE_MASK >> 12))
-		goto out;
-	error = sys_mmap_pgoff(addr, len, prot, flags, fd,
-			       pgoff >> (PAGE_SHIFT-12));
-out:
-	return error;
+		return -EINVAL;
+	return sys_mmap_pgoff(addr, len, prot, flags, fd,
+			      pgoff >> (PAGE_SHIFT-12));
 }
 
 #define RLIM_INFINITY32 0x7fffffff
-- 
2.11.0
