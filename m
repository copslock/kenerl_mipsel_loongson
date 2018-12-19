Return-Path: <SRS0=x683=O4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2838FC43444
	for <linux-mips@archiver.kernel.org>; Wed, 19 Dec 2018 07:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA99621841
	for <linux-mips@archiver.kernel.org>; Wed, 19 Dec 2018 07:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyTSbmdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeLSHIJ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:08:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52221 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbeLSHIJ (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 19 Dec 2018 02:08:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so4889317wmj.1;
        Tue, 18 Dec 2018 23:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKTUZ4jxMu7q6W0p5Lc6TisV9hX+M4ixTYtAmBCXrfY=;
        b=hyTSbmdndbAfo9EceETIXWLz9w1SBAzddMF0B6XwzhXnUy6F2vd0vYWF93QSwLnWm0
         8fMyectv/MTBaK9XSvAYmXhy38wFHlkaJasLneVaGObOA+VuGaYYVSL2+C1IgOK9cTkl
         9FwRTK23sbjpB2zH34OBYczJ5x0NjGZzQ3UQyQANxAIs/WfSGCNF7fFgE5GXa8CiVLLs
         Ebm02H75vfKWXHdQZwSPPQ5O7TjwgkLT/ikZzJLTS1/picpfoxj0CN+P0zUxMs5GYL3j
         PUBmDLKrJtwXqqGmNVQHwMsLCWoY6DY/T+lF8HqcfgH33hWA8UefRrT0IFN8vMhdR12C
         +oPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKTUZ4jxMu7q6W0p5Lc6TisV9hX+M4ixTYtAmBCXrfY=;
        b=aK7h2o7B/Kh9EM/javvrDa+nZAmS4suNRdxmSLgshRYIVYGLH/x7/Q5oCRWZMsjWFS
         HfJ8LX+ZrIcz69bt5ECO4PLtuH0rv+exzsLL0hUAvnwRhuR0UXXMYpzpS4ZJF2DLR/NC
         qUSPZnWSmzftHr+5pTsw90ZyUDV77zUfFV57w43CdwxZhNmU7n7SZQhDO6VoC+OCbjbr
         aMy5GxkRfGd7F4cxgZ23uwcZKgj6aCl0AEWMwOSVe2Gx/QHe+sITbF/b4ccegBkJbph/
         KjTC5UEM3kCtnBESJUxNACeeMqnN3iH9lG2ApEZdLvWPmWgPzE3gkc8g+kAp59qmESh6
         QQGA==
X-Gm-Message-State: AA+aEWZHv7qGYq0aWk3bjqDQ8H7szESSEdi5JM2gSAn4S//Q6zbhCM7c
        RrDbhRCNN1X4oz7mj/jDd1dbemYg
X-Google-Smtp-Source: AFSGD/XosRE82Tb04H+cg4NVYPX4NnIOOBh5uP/MNxJoYR1JSP1C/kW2TDopxyS8/rq/lOfQsD8IVQ==
X-Received: by 2002:a1c:6e06:: with SMTP id j6mr6084714wmc.3.1545203287286;
        Tue, 18 Dec 2018 23:08:07 -0800 (PST)
Received: from flagship2.speedport.ip (p200300C20BD333581B9ECEB655B1C7D2.dip0.t-ipconnect.de. [2003:c2:bd3:3358:1b9e:ceb6:55b1:c7d2])
        by smtp.gmail.com with ESMTPSA id s16sm3245724wrt.77.2018.12.18.23.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 23:08:06 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@vger.kernel.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 2/5] net: drivers/amd: restore access to MIPS Alchemy platform
Date:   Wed, 19 Dec 2018 08:08:00 +0100
Message-Id: <20181219070803.449981-3-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181219070803.449981-1-manuel.lauss@gmail.com>
References: <20181219070803.449981-1-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The MIPS Alchemy platform needs access to the au1000_eth.c
driver, which resides in the AMD driver directory (as the
chips were at a time made by AMD).

Cc: netdev@vger.kernel.org
Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 drivers/net/ethernet/amd/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/Kconfig b/drivers/net/ethernet/amd/Kconfig
index 9e5cf5583c87..2bd93c7def99 100644
--- a/drivers/net/ethernet/amd/Kconfig
+++ b/drivers/net/ethernet/amd/Kconfig
@@ -7,7 +7,8 @@ config NET_VENDOR_AMD
 	default y
 	depends on DIO || MACH_DECSTATION || MVME147 || ATARI || SUN3 || \
 		   SUN3X || SBUS || PCI || ZORRO || (ISA && ISA_DMA_API) || \
-		   (ARM && ARCH_EBSA110) || ISA || EISA || PCMCIA || ARM64
+		   (ARM && ARCH_EBSA110) || ISA || EISA || PCMCIA || ARM64 || \
+		   MIPS_ALCHEMY
 	---help---
 	  If you have a network (Ethernet) chipset belonging to this class,
 	  say Y.
-- 
2.20.0

