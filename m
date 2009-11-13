Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2009 03:03:53 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:59620 "EHLO
	mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492111AbZKMCDr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Nov 2009 03:03:47 +0100
Received: by yxe42 with SMTP id 42so4293019yxe.22
        for <multiple recipients>; Thu, 12 Nov 2009 18:03:40 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=uitlUtHY2h4uiz6PUQP8cDguSpGa8xo6YC7EbQNC5pE=;
        b=SZwEEjNh+j4aomlppjtQaRq+3erFd2M/b2Br6iAlWo1WWzBsbgRoEqlTLAHfxpIjBf
         fScu3ZvzQipehQvKTTyRzzueQPFRIf7LXVGTOXf79Np/kebu/X4Nfijlt35WqijZKPSU
         fA4koIFdD/r32JDvmQfTn87mBNtYdz+S+lEXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ZsVgealpo+lMJZSmM79DrGo0QbtbeZcKO80WAvS/bju7gmpsBesAJ1n0ZWniZjHTVA
         kR980lxRFiwR5nCyAKjFPR3/rJdtBE2sjoZI71v8vRtmJuOSRc2ia4677VkLxkBJqokY
         Ylf3gtDCxf2cpxDLJhyERbe33CQp8IEVkLMjQ=
Received: by 10.101.29.5 with SMTP id g5mr4152984anj.103.1258077819948;
        Thu, 12 Nov 2009 18:03:39 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1570717yxe.39.2009.11.12.18.03.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 18:03:39 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] [loongson] Fixups of "MIPS: Loongson 2F: Add suspend support framework"
Date:	Fri, 13 Nov 2009 10:03:28 +0800
Message-Id: <1258077808-582-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf

You have helped changing the CPU_SUPPORT_CPUFREQ to
CPU_SUPPORTS_CPUFREQ(arch/mips/Kconfig), we need to change it here too.

Could you please fold this patch into "MIPS: Loongson 2F: Add suspend
support framework"?

Thanks & Regards,
	Wu Zhangjin

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 029360f..17e72fd 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -65,4 +65,4 @@ config CS5536
 config LOONGSON_SUSPEND
 	bool
 	default y
-	depends on CPU_SUPPORT_CPUFREQ && SUSPEND
+	depends on CPU_SUPPORTS_CPUFREQ && SUSPEND
-- 
1.6.2.1
