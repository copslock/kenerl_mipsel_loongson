Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jun 2009 07:37:22 +0100 (WEST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:43135 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021578AbZFIGhP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 Jun 2009 07:37:15 +0100
Received: by bwz25 with SMTP id 25so3609085bwz.0
        for <multiple recipients>; Mon, 08 Jun 2009 23:37:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :organization:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=nILFh+BsWm0odJWKkIy+FCIYG/25EgmGSKju7JDMMJI=;
        b=tlIwdUIURSUk2lkYryzBdzU+0vB0N4H9DhW94JKlPpqNWHaLtiKbzIfxNKcsnDBsyf
         lIbdzjSGptcY195EI3wiY/4Eh5mmhedfjQ6p9r0TZmBB9r/V4+iGzuoy1Pzv9xFL78re
         s0qEC78gz72VyDvSV9uS1LlDCAB2NzhFzZBVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=i5qPETQiwXnSdGYWwBhpAHBclBGs2PiL7S2Spwhl7kFv93f4Qa0WvvkfcVxsTsAb7K
         ntWLGMiwB0eLkuCwFUdWUV/okWetidE9ow9F5WUvJ92tgd97BAT1/dplTF3gyit6AlnT
         0jO5vT+33+P0t98zIwzraAGZBUAmjWli9taz4=
Received: by 10.103.219.8 with SMTP id w8mr249663muq.104.1244529429506;
        Mon, 08 Jun 2009 23:37:09 -0700 (PDT)
Received: from ?0.0.0.0? (p5496FE03.dip.t-dialin.net [84.150.254.3])
        by mx.google.com with ESMTPS id s11sm8026187mue.11.2009.06.08.23.37.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Jun 2009 23:37:08 -0700 (PDT)
Message-ID: <4A2E0347.3010009@gmail.com>
Date:	Tue, 09 Jun 2009 08:37:59 +0200
From:	Manuel Lauss <manuel.lauss@googlemail.com>
Organization: Private
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/5] Alchemy GPIO rewrite v7
References: <1244290198-27162-1-git-send-email-manuel.lauss@gmail.com> <20090608185516.GA15590@linux-mips.org>
In-Reply-To: <20090608185516.GA15590@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> Thanks, queued.  Looking much better than earlier versions but there
> still are many magic numbers being used in the code.

Thanks!

Does the below patch address your concerns?

---

From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] Alchemy: gpio: document magic numbers.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
  arch/mips/include/asm/mach-au1x00/au1000.h      |    3 +++
  arch/mips/include/asm/mach-au1x00/gpio-au1000.h |   13 +++++++++----
  2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 854e95f..b672390 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -1550,6 +1550,9 @@ enum soc_au1200_ints {
  #define GPIO2_INTENABLE 	(GPIO2_BASE + 0x10)
  #define GPIO2_ENABLE		(GPIO2_BASE + 0x14)

+#define GPIO2_ENABLE_RESET	(1 << 1)	/* reset peripheral */
+#define GPIO2_ENABLE_CLK	(1 << 0)	/* clock enable */
+
  /* Power Management */
  #define SYS_SCRATCH0		0xB1900018
  #define SYS_SCRATCH1		0xB190001C
diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
index 127d4ed..cc7a998 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
@@ -275,10 +275,15 @@ static inline void __alchemy_gpio2_mod_dir(int gpio, int to_out)
  	au_sync();
  }

+/* GPIO2_OUTPUT expects the levels of output pins in bits 0-15;
+ * bits 16-31 indicate whether the level change should be carried out
+ * for a particular pin.
+ */
  static inline void alchemy_gpio2_set_value(int gpio, int v)
  {
  	unsigned long mask;
-	mask = ((v) ? 0x00010001 : 0x00010000) << (gpio - ALCHEMY_GPIO2_BASE);
+	mask = (1 << 16) | (v ? 1 : 0);		/* set up en | value */
+	mask <<= gpio - ALCHEMY_GPIO2_BASE;
  	au_writel(mask, GPIO2_OUTPUT);
  	au_sync();
  }
@@ -420,9 +425,9 @@ static inline void alchemy_gpio2_disable_int(int gpio2)
   */
  static inline void alchemy_gpio2_enable(void)
  {
-	au_writel(3, GPIO2_ENABLE);	/* reset, clock enabled */
+	au_writel(GPIO2_ENABLE_RESET | GPIO2_ENABLE_CLK, GPIO2_ENABLE);
  	au_sync();
-	au_writel(1, GPIO2_ENABLE);	/* clock enabled */
+	au_writel(GPIO2_ENABLE_CLK, GPIO2_ENABLE);
  	au_sync();
  }

@@ -433,7 +438,7 @@ static inline void alchemy_gpio2_enable(void)
   */
  static inline void alchemy_gpio2_disable(void)
  {
-	au_writel(2, GPIO2_ENABLE);	/* reset, clock disabled */
+	au_writel(GPIO2_ENABLE_RESET, GPIO2_ENABLE);
  	au_sync();
  }

-- 
1.6.3.1
