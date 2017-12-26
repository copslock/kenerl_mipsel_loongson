Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 11:46:49 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:44959
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990433AbdLZKqZsiOa5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 11:46:25 +0100
Received: by mail-wm0-x241.google.com with SMTP id t8so34500457wmc.3;
        Tue, 26 Dec 2017 02:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JEZqptf3+f3w/JipiCucTZ1yEQ6xWVNkg68irIBb8bg=;
        b=VfWFKrWarbiFxtDWtmJo2fdu6/lthbnwtvqRiugErFhpUoAsvqCOujnGJtH8ViijMn
         P+Ispcq88eT0VpQ0YMvyRDvBniBT6n85DGPldFykN7m803cHUpOOKEL6NATh05AktjZn
         JCahZcYXJ64i0i38PjSKRoom2Xk70lEL8Ram+xxF+HdpyKEj9X32/bkyLcqUV3ubIdFr
         Iz9yFlK75ynIA3GHYV4paEmLAsG0jnCcJ0p+AGGleiXJkTkhQ6SUEl4F8C1njhdVP3dE
         hyY02qjIgl1ttueyejBG/aLPNqCAVMmPPbK1bxJusXgK0YoIrCdvHT7wHZN+Z/qouo2U
         H5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JEZqptf3+f3w/JipiCucTZ1yEQ6xWVNkg68irIBb8bg=;
        b=A8Cyu3vG04lkdFshhZZ4pvmw+gv5YpdD1Q2UiIjbTDrB8Ay5HhTLsnRX89a+YeuTe8
         L+LsyOP0Z7EHNekPHV6PI7cSo339X+ZspnxpHC3UcgirJO8GQo2UIrVIsmBb2YaK+Sie
         iONnHV6zsa2gg4T0td5FkFt2XKgICZjBVgDKEf/IqTLSzwonPUCShDrEldPSDEwrCuOm
         FQfQJ15tAy5uyUOjX154usDRaM1gT5dQLY9RdENx/3cFXn9/hYY+ZP9bYW7qE9Rir0lg
         BItn2Vadhc4LcVWp5Oz/gvJ2ru3L9El5dC41wvnWyDmsJH9AWoQ+Dy8iUEI4o2IKVDDr
         nXmg==
X-Gm-Message-State: AKGB3mJsDXPmgW1V7VDxE+HUepAu2b3AWjoMPW2kqc6HyZ5CWWHvA9kA
        uUIjLX18bYbviXw7gSXNsrbimoj6
X-Google-Smtp-Source: ACJfBovjl7Uvf8pVKdvcf+Z5UDJNsPz3ao+Sr0rZt9NuB4qaH/n/EFEAOBqyVV1h044jBB0lAd30Kw==
X-Received: by 10.28.235.21 with SMTP id j21mr15681931wmh.72.1514285180404;
        Tue, 26 Dec 2017 02:46:20 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id 17sm19819604wmq.10.2017.12.26.02.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Dec 2017 02:46:19 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id CD39310C1B2E; Tue, 26 Dec 2017 11:46:18 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        James Hogan <jhogan@kernel.org>,
        Douglas Leung <douglas.leung@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MIPS: math-emu: Declare ys variable as possibly unused
Date:   Tue, 26 Dec 2017 11:45:51 +0100
Message-Id: <20171226104554.19612-2-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171226104554.19612-1-malat@debian.org>
References: <20171226104554.19612-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Fix non-fatal warning:

arch/mips/math-emu/sp_fdp.c: In function ‘ieee754sp_fdp’:
arch/mips/math-emu/ieee754int.h:60:31: warning: variable ‘ys’ set but not used [-Wunused-but-set-variable]
  unsigned int ym; int ye; int ys; int yc
                               ^
arch/mips/math-emu/sp_fdp.c:37:2: note: in expansion of macro ‘COMPYSP’
  COMPYSP;
  ^~~~~~~

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/math-emu/ieee754int.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/math-emu/ieee754int.h b/arch/mips/math-emu/ieee754int.h
index 06ac0e2ac7ac..cb8f04cd24bf 100644
--- a/arch/mips/math-emu/ieee754int.h
+++ b/arch/mips/math-emu/ieee754int.h
@@ -57,7 +57,7 @@ static inline int ieee754_class_nan(int xc)
 	unsigned int xm; int xe; int xs __maybe_unused; int xc
 
 #define COMPYSP \
-	unsigned int ym; int ye; int ys; int yc
+	unsigned int ym; int ye; int ys __maybe_unused; int yc
 
 #define COMPZSP \
 	unsigned int zm; int ze; int zs; int zc
-- 
2.11.0
