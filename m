Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 22:01:09 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:24074 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133553AbWAXWAv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 22:00:51 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id F00E264D3D; Tue, 24 Jan 2006 22:04:15 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id EE910854B; Tue, 24 Jan 2006 22:03:29 +0000 (GMT)
Date:	Tue, 24 Jan 2006 22:03:29 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Set CONFIG_BUILD_ELF64 for defconfigs where CONFIG_64BIT is set
Message-ID: <20060124220329.GA10421@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Modern toolchain requires you to build ELF64 objects when you build a
64-bit kernel.  Therefore enable CONFIG_BUILD_ELF64 in all mips defconfig
files which have CONFIG_64BIT=y.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

 ip32_defconfig         |    2 +-
 ocelot_c_defconfig     |    2 +-
 ocelot_g_defconfig     |    2 +-
 sb1250-swarm_defconfig |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index 23dcecc..bb06298 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -226,7 +226,7 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
-# CONFIG_BUILD_ELF64 is not set
+CONFIG_BUILD_ELF64=y
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_MIPS32_O32=y
diff --git a/arch/mips/configs/ocelot_c_defconfig b/arch/mips/configs/ocelot_c_defconfig
index bbb5316..81e6ebf 100644
--- a/arch/mips/configs/ocelot_c_defconfig
+++ b/arch/mips/configs/ocelot_c_defconfig
@@ -222,7 +222,7 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_BUILD_ELF64 is not set
+CONFIG_BUILD_ELF64=y
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_MIPS32_O32=y
diff --git a/arch/mips/configs/ocelot_g_defconfig b/arch/mips/configs/ocelot_g_defconfig
index 062e0e6..c5029b4 100644
--- a/arch/mips/configs/ocelot_g_defconfig
+++ b/arch/mips/configs/ocelot_g_defconfig
@@ -225,7 +225,7 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_BUILD_ELF64 is not set
+CONFIG_BUILD_ELF64=y
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_MIPS32_O32=y
diff --git a/arch/mips/configs/sb1250-swarm_defconfig b/arch/mips/configs/sb1250-swarm_defconfig
index bc79f49..550b6f7 100644
--- a/arch/mips/configs/sb1250-swarm_defconfig
+++ b/arch/mips/configs/sb1250-swarm_defconfig
@@ -249,7 +249,7 @@ CONFIG_MMU=y
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-# CONFIG_BUILD_ELF64 is not set
+CONFIG_BUILD_ELF64=y
 CONFIG_MIPS32_COMPAT=y
 CONFIG_COMPAT=y
 CONFIG_MIPS32_O32=y

-- 
Martin Michlmayr
http://www.cyrius.com/
