Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 19:57:07 +0100 (CET)
Received: from mout.web.de ([212.227.17.11]:53362 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992221AbdARS5BSite- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Jan 2017 19:57:01 +0100
Received: from [192.168.1.2] ([78.48.198.118]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5fsK-1cepWV0Zx2-00xZq8; Wed, 18
 Jan 2017 19:56:51 +0100
Subject: [PATCH 3/3] MIPS-syscall: Return directly in mips_mmap()
To:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>
References: <bb402413-83e5-9b34-304c-9f4bca6037d9@users.sourceforge.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <65e23f25-f12e-9b94-9038-fd901dae92db@users.sourceforge.net>
Date:   Wed, 18 Jan 2017 19:56:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <bb402413-83e5-9b34-304c-9f4bca6037d9@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:JUt575K2hNz7xFp5BaVPUqDJlRUKAUglBOE7a6QEpunoLul+o2n
 xJTOXsE67AD8NcPXEaytkav5nfSlZ5x0vVfHhjSpvmoorNegQ46u9VsHkIfHQUlTYSrxSh4
 Yyng9cYLDv1yXBRq+N8ZzM7VfRQHG0Rj0ghyqvbRkqO0KtK5WSOctUiQlnz3uxQ+EMRupZ1
 hKz2A6hnzGNdUadyybrmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6Zz6wgS5Ijk=:EKDTTlMBccioFM5AZ4TkHz
 xhmmEWuN0UJhu/ro58WTjAz7O9ua2lXvqDCGu08L+4ypTX0pb1D4hGdbSsn8RpUsqIveK0VkV
 h1EEhve9rJOjlohU0meI3BwZjcF/7Dhj7NW1LJs1PwQ6JhgnBRU7+gFoukcHaLj6zji2QiwSf
 XkTZi8apSGgpw894r6HxZERjOq7WMreVOINaCWBGMBj0ifP6i5hClIoCiLbyrbqaN+/mvcCcp
 tv73Cywfo/4jNeFE3bch8E9EeaZLUP4MJayNChWj/BdcCGhWq8F3k8aJ4LDeKp3JpMfvmPpkx
 MLjYn+TSSxuctd/K3K3+pHrbHlzJ4nc5xCiTKSzMPOrAa8U/a32pgdeDOvv7EBdkGxyDVSnfc
 pSkTPUNvMROcLa8QNZB/c8MH+khbs4vd4CIwk1Q8a59zsJTgT+H5Oef7YZQoDLNRtvY6G1FsB
 OYxvrVQNcb0/bDPgcTz73V0HC3XKjCO1uRziP0UXGs7gXQ12pa30xju0RrDa/FKKSqfknckSL
 qjI/EZjaRtO4+aKvLCpGChpzl0P/fYD+8XLK1cOfVOtKXk9lKdo/duC0b7HyJdwJjjb6mxBLH
 hB8IfCkSqo9mjbjZqUjf46OY2JCq8+o++e8aavUaR1eXr7NLgqQ0ESEAbgpVseHfYtg2hDMv2
 P08eGszXu09JPUpOzZ4l/45fOje6unupV/HcqilVojMXSGu1I1U0OuFRKu047EIobYJpRertx
 EHUqgIVDurB4dllV71w2LjlMIxCuK57xYNr+6M45XbBjjdgiFZYpPxkuwXh3wYh8vKbgUFXq+
 7UJal63
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56401
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
Date: Wed, 18 Jan 2017 19:30:47 +0100

* Return an error code without storing it in an intermediate variable.

* Delete the local variable "result" which became unnecessary with
  this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/kernel/syscall.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 53a7ef9a8f32..e4e99888799d 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -60,16 +60,9 @@ SYSCALL_DEFINE6(mips_mmap, unsigned long, addr, unsigned long, len,
 	unsigned long, prot, unsigned long, flags, unsigned long,
 	fd, off_t, offset)
 {
-	unsigned long result;
-
-	result = -EINVAL;
 	if (offset & ~PAGE_MASK)
-		goto out;
-
-	result = sys_mmap_pgoff(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
-
-out:
-	return result;
+		return -EINVAL;
+	return sys_mmap_pgoff(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
 }
 
 SYSCALL_DEFINE6(mips_mmap2, unsigned long, addr, unsigned long, len,
-- 
2.11.0
