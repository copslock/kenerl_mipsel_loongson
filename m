Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 04:23:17 +0200 (CEST)
Received: from mail-qy0-f171.google.com ([209.85.221.171]:34076 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491874AbZJOCXK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2009 04:23:10 +0200
Received: by qyk1 with SMTP id 1so688223qyk.0
        for <linux-mips@linux-mips.org>; Wed, 14 Oct 2009 19:23:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=+YK/lHr8gXnfepa5EaBlW+6fDXeiRHdQc4MRGRg2hqo=;
        b=MvD33bSxUGcqZMVQOF84aT7uThcKI3OPrtD6Ym6f1wKfnkTvzREZtqyAfhcFUCr+kd
         K2IToVUqf3AnfpH2r+hIN/L8rVTUz982J8ryVq7VearUvPJLixfFCQQGI0i/CuOMa/Q+
         xO1bs4U15EJUSeaVkgQvhHmNH5rZl/zOobu+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=LL6ee+Rmi7H34F85yPZsUMhQfwNP7HtHiv/EB/0rO4bs8RsYwZMCHOm/t0h9ma8+jF
         ubPQiLT7WQ8q3//lQ2QrOFOzdkGVfTF32vLHHhkXgkihS7pI2+qiDC6afhwseYS0F8DR
         hPSiu8i2LwtnrJ/8cl9Gs/hJAKif/2bSrOP8I=
Received: by 10.224.52.221 with SMTP id j29mr7720796qag.347.1255573384714;
        Wed, 14 Oct 2009 19:23:04 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 6sm8102992qwk.13.2009.10.14.19.22.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Oct 2009 19:23:03 -0700 (PDT)
Subject: [PATCH] SND_CS5535AUDIO: Remove the X86 platform dependency
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>,
	loongson-dev@googlegroups.com
Cc:	Jaya Kumar <jayakumar.lkml@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org
In-Reply-To: <1255190029-17584-1-git-send-email-wuzhangjin@gmail.com>
References: <1255190029-17584-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 15 Oct 2009 10:22:54 +0800
Message-Id: <1255573374.7638.22.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Add CC to: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org

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
