Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Oct 2009 17:54:15 +0200 (CEST)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:53100 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492863AbZJJPyJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 10 Oct 2009 17:54:09 +0200
Received: by pzk35 with SMTP id 35so2641072pzk.22
        for <linux-mips@linux-mips.org>; Sat, 10 Oct 2009 08:54:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=MIv1Ol8BM1ylb8W64IMeSxRMgpwreILacay15dZdEgM=;
        b=c8CGk6LuOj85MmMztEoudjTAYxLHHBxrdfcs5N1NBw07u11nN235Fqls/+yZ0wNlRt
         1A22KwJ4mP7qNkKiPt/77xxpwK5yXqhtSFk3w8UFCNEd3jd1djxEhKhD2oriwAuHt198
         NnXpy6Eqnp0WkGOqXsS2M6ekrrNdOC6WUThrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=o3yse2Otv0ihExfBqKKdch+sI1UsruHxgqIL482GcR4YwvrqqtI/wvMv9LxSqwWgxw
         Zpy9b3e1yDmPMl4JFvOPKdSRLC3Wij2EWdOnhjaN3yzf/g1/0p7nIVtjiORm6vMU1lMA
         eAuLEVuKDUN/0UFlleZr/asICK7Sroq3ei1i4=
Received: by 10.115.20.11 with SMTP id x11mr5549272wai.220.1255190042234;
        Sat, 10 Oct 2009 08:54:02 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm1473114pzk.4.2009.10.10.08.53.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Oct 2009 08:54:01 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>,
	loongson-dev@googlegroups.com
Cc:	Jaya Kumar <jayakumar.lkml@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] SND_CS5535AUDIO: Remove the X86 platform dependency
Date:	Sat, 10 Oct 2009 23:53:48 +0800
Message-Id: <1255190029-17584-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

SND_CS5535AUDIO is available on Loongson(MIPS compatible) family
machines, and checked it with ARCH=x86_64, no relative compiling
warnings & errors, so, remove the platform dependency directly.

Reported-by: rixed@happyleptic.org
Acked-by: Andres Salomon <dilinger@collabora.co.uk>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 sound/pci/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index fb5ee3c..75c602b 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -259,7 +259,6 @@ config SND_CS5530
 
 config SND_CS5535AUDIO
 	tristate "CS5535/CS5536 Audio"
-	depends on X86 && !X86_64
 	select SND_PCM
 	select SND_AC97_CODEC
 	help
-- 
1.6.2.1
