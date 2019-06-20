Return-Path: <SRS0=j293=UT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E81AC43613
	for <linux-mips@archiver.kernel.org>; Thu, 20 Jun 2019 21:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F89206BA
	for <linux-mips@archiver.kernel.org>; Thu, 20 Jun 2019 21:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfd2ehLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfFTVja (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:39:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38789 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfFTVja (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 20 Jun 2019 17:39:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so4499991wrs.5
        for <linux-mips@vger.kernel.org>; Thu, 20 Jun 2019 14:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nds0LhX8tAhIs/UmD34qgTUz4OBaMwTfQsiXTSUrrtY=;
        b=lfd2ehLTjoQsNvCA17H2JkHWxDUKGFpBtGN+tYSfEFrcE8V+KWqjGS90se9wh725gk
         00kovH9yDC+iykuWKKGp3biZPqgr/fY57nJXc8vMPeE/o4sh7gSCvixJ3yVq115ZB7A0
         OhDPJdEzLQly4EyA4iMYl15pIKEQJM+w67sba6WX1G4QU/yeLHw7FUzXKnEtqnAPDxK0
         AJkMOtk8Fp09uBsiyU/InKpD2HcMGDbMJEEEaUxicv2hJLWgR7qBEZ08G2LOheg0xcy6
         MHkIxtPZws8/6An/0Ti/EaT45fw7FXoKL+YlJ3qjBCsNw2xUUepmwIIrqTwyxe8mBxJm
         LkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nds0LhX8tAhIs/UmD34qgTUz4OBaMwTfQsiXTSUrrtY=;
        b=s+KG2ki9ypXk5B68RL5Zjf4us5hO6/VandrCTWFsxrCm3jfNvfj02F3ykqEkEqLdqw
         ahGsKjHwaTGte5zgBWtFnBVJfHVKQ/ozMNHwwHHACfvLOqeKyby+xrzm3exzL5n9Fq10
         bL3+myRBMNlebaEyVBlRWg3RtcZMyV+F4FHFK81j1Ao5P7p8E+xLzdvxCZealjFFLt1p
         YaUxvKPyuxPB9GoBs5O00So0Ar28Wikkp0OhDPfqzY1JnAyR44T14zinOWt0NGojZR24
         nxs7tfsw6dDviIuyjDKMc81vEUX+f/nVvnh6zNkQgE8LrNR5LCwVBdzkLj0tz5v0iryo
         JDxg==
X-Gm-Message-State: APjAAAXEn4jNKTysxM6J9SX56Y357YcEjxcp2O/faqYuih8Uvx1E7G9a
        0EgeSZIPM9gZee0AUsSneZY=
X-Google-Smtp-Source: APXvYqzWaRmTTNfeH0Sq1+xZZTQ40yGpfNoRE0z9WA7r4xu5sfXGbdK+PEqj6IKRIkwubYMTvkt4HA==
X-Received: by 2002:a5d:4cc3:: with SMTP id c3mr17786342wrt.259.1561066767980;
        Thu, 20 Jun 2019 14:39:27 -0700 (PDT)
Received: from kontron.lan (2001-1ae9-0ff1-f191-ecaa-d74f-d492-3738.ip6.tmcz.cz. [2001:1ae9:ff1:f191:ecaa:d74f:d492:3738])
        by smtp.gmail.com with ESMTPSA id j4sm575426wrx.57.2019.06.20.14.39.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 14:39:27 -0700 (PDT)
From:   petrcvekcz@gmail.com
X-Google-Original-From: petrcvekcz.gmail.com
To:     hauke@hauke-m.de, john@phrozen.org
Cc:     Petr Cvek <petrcvekcz@gmail.com>, linux-mips@vger.kernel.org,
        openwrt-devel@lists.openwrt.org, pakahmar@hotmail.com
Subject: [PATCH v2 5/7] MIPS: lantiq: Fix bitfield masking
Date:   Thu, 20 Jun 2019 23:39:37 +0200
Message-Id: <d1ba41743aaeb1ecdb2df7d4845bd5d60a774f92.1561065843.git.petrcvekcz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561065843.git.petrcvekcz@gmail.com>
References: <cover.1561065843.git.petrcvekcz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Petr Cvek <petrcvekcz@gmail.com>

The modification of EXIN register doesn't clean the bitfield before
the writing of a new value. After a few modifications the bitfield would
accumulate only '1's.

Signed-off-by: Petr Cvek <petrcvekcz@gmail.com>
---
 arch/mips/lantiq/irq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 21ccd580f8f5..35d7c5f6d159 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -150,8 +150,9 @@ static int ltq_eiu_settype(struct irq_data *d, unsigned int type)
 			if (edge)
 				irq_set_handler(d->hwirq, handle_edge_irq);
 
-			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_C) |
-				(val << (i * 4)), LTQ_EIU_EXIN_C);
+			ltq_eiu_w32((ltq_eiu_r32(LTQ_EIU_EXIN_C) &
+				    (~(7 << (i * 4)))) | (val << (i * 4)),
+				    LTQ_EIU_EXIN_C);
 		}
 	}
 
-- 
2.21.0

