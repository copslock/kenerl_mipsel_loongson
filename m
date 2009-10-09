Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Oct 2009 05:44:30 +0200 (CEST)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:61984 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491882AbZJIDoX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 Oct 2009 05:44:23 +0200
Received: by pzk32 with SMTP id 32so6568537pzk.21
        for <linux-mips@linux-mips.org>; Thu, 08 Oct 2009 20:44:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=qSIXjthXDeKvXUYnwauXUEP6byIt2Kxyocs7CeVQv9U=;
        b=KBxJoq7YpVUurhtK6J/6PCEJ06K0xTkTJj98uf8aGFoEMFQGz16HTeDtdN1M/aBnHo
         Q85c/ZYAbMj+1MSokcdWwRi3J9IJKj7bLqZWuOHXdHOIvp8H7n2LIgyQ49RfYd1D965A
         tWUcY/zuyTq65mpqg2mOl8CWDz5LuFMclKINE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OTdVwTZbyFAaedFtBj7zLrkcv1smWL8oXUZJIrzmdcDI5LT12iQbdu7+nbg95YMger
         Apajf53SQvziIUQjguU4+RXQyyI43QE6RpINMYc6/CwUuNQefgttB9IA1sTUgZmmM7vg
         FJCgY4qCx7LbbY6uBYq9pHpWp2vLhHA4FSR9Y=
Received: by 10.114.165.35 with SMTP id n35mr3053877wae.183.1255059852610;
        Thu, 08 Oct 2009 20:44:12 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm307581pxi.8.2009.10.08.20.44.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 20:44:11 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>
Cc:	Andres Salomon <dilinger@debian.org>,
	Jaya Kumar <jayakumar.lkml@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	loongson-dev@googlegroups.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] CS5535: Remove the X86 platform dependence of SND_CS5535AUDIO
Date:	Fri,  9 Oct 2009 11:44:02 +0800
Message-Id: <1255059842-12160-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

There is no platform dependence of SND_CS5535AUDIO before 2.6.31, Not
sure who have touched this part, but SND_CS5535AUDIO is at least
available on Loongson family machines, so, Remove the platform
dependence directly.

Reported-by: rixed@happyleptic.org
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
