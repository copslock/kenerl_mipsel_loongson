Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 May 2017 21:49:04 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.131]:60274 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993935AbdEETs4gOMsp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 May 2017 21:48:56 +0200
Received: from wuerfel.lan ([78.42.17.5]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MeGdC-1dPtSV3C18-00PrH9; Fri, 05 May 2017 21:48:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.16-stable 83/87] MIPS: ip22: Fix ip28 build for modern gcc
Date:   Fri,  5 May 2017 21:47:41 +0200
Message-Id: <20170505194745.3627137-84-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170505194745.3627137-1-arnd@arndb.de>
References: <20170505194745.3627137-1-arnd@arndb.de>
X-Provags-ID: V03:K0:jXR50+s0Juw+AbpmOeZZJTItSLRf4x1Vmrb7GXxRkdHT1SM/nXI
 FAas18mVsMfvKQgpfX90ufq+BSGRnw5/pKUMsyVXVPwj3akJa3qsHqfaEU98sNZ5tamzV82
 Ko9yrCHARAPOKqJyAwRC0we1jolEyISiRmoaMe/eJUx5GBgWgXYoMaFw/bGmC+nHwyYJc6H
 In/QQAP2v788+UD6TZ3mQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tQdujVvIEeQ=:9pwUygk3mdeRVnt7Q3Nsnm
 ZnG0NssN/oXjYrl9o8y/e5RjjVJsMcsRuMFkjDxQzJ2p1Du/JcfSEo134hR4hVW6bLdy3DmaG
 8cEhMYBJJuLZp3jE1qfOwjv4OD2v6xsAycdq/AYH/xKY3mhRK3fgb1je5Ifdaa9nBat7vyM5p
 6l4BYO2+o3GthaS7L/0YQW10Jt0zdo5/QJ7Y6kQmH6zA44nd3E0VMJnbDDQaZIBrYi35z5XI2
 H1fZDxzv99nYxxI9slCcaoptfUitky1I2oFv6ImxyBDqWmu6rs2jgyj7PlHnynfhX77mni1Ww
 BAP5mqB37ceJNFlfQ1evMlMxPyFNLzLnxenwT+LovOYa3C1t+HUcX0CM5Jfyd1Y/TQQxkOxG3
 wEQtovQlfhSsg5lELSHsf9Ge0DoynOpGt/TnWEMpe+7zncUry7yeSAoVmRmrlUmq7o0cWhm5/
 dCjTz2qWbFuOq7NZvdXig3kIp0Ts+5uMhSpMAQ/+Ro6Kh92j0TjqWlGz9hBRxQPZGyPZ9lUIL
 AMn6zFeZyW3CjqQtMZPCYQFl+CPyseOH1TqMXXsKqE1MB8alJkGFmAz5v2XKdFIQX5Dc/pL2R
 +wHvVr3qBSETHqSh7oULnE9Fh/mwaMvlciq4lD4SqIpqnMvy6gXcLFjNlUFl6EPYjLOEJRK8f
 bnreAJD0+9TV7RnzOI9F9n2fk5/nu3Sk+oukXGbDJk7HTnwThMm4ZOWDSoRNUGI4EN+M=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

Commit c3ef8bf59deea37d1105ffb771b163d3c322fff7 upstream.

kernelci reports a failure of the ip28_defconfig build after upgrading its
gcc version:

arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed option -mr10k-cache-barrier=store.  Stop.

The problem apparently is that the -mr10k-cache-barrier=store option is now
rejected for CPUs other than r10k. Explicitly including the CPU in the
check fixes this and is safe because both options were introduced in
gcc-4.4.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15049/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/sgi-ip22/Platform | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/sgi-ip22/Platform b/arch/mips/sgi-ip22/Platform
index b7a4b7e04c38..e8f6b3a42a48 100644
--- a/arch/mips/sgi-ip22/Platform
+++ b/arch/mips/sgi-ip22/Platform
@@ -25,7 +25,7 @@ endif
 # Simplified: what IP22 does at 128MB+ in ksegN, IP28 does at 512MB+ in xkphys
 #
 ifdef CONFIG_SGI_IP28
-  ifeq ($(call cc-option-yn,-mr10k-cache-barrier=store), n)
+  ifeq ($(call cc-option-yn,-march=r10000 -mr10k-cache-barrier=store), n)
       $(error gcc doesn't support needed option -mr10k-cache-barrier=store)
   endif
 endif
-- 
2.9.0
