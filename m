Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2012 08:45:15 +0100 (CET)
Received: from mail-da0-f49.google.com ([209.85.210.49]:46797 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823033Ab2KMHpPDjKI2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2012 08:45:15 +0100
Received: by mail-da0-f49.google.com with SMTP id q27so2837887daj.36
        for <linux-mips@linux-mips.org>; Mon, 12 Nov 2012 23:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=jEC4ZuooUd0KVQD1qfb9u3fYaJuy66puN29jEN3i+4s=;
        b=dI/pcdOHaHTY+xbHk1LrZ1+uvkHmMva0n/tGLq4QxoyY9D0+OJrq1Y7Bu5jLZhjjw+
         QOGbevgvZJ6m+b7puBOvZPEi0fE/02p4ymzllh8qDJmH2y+gxSqj6ev0zdX2tVFfhelg
         1/bsQcH2X/8UalgRhSavmnI84USdmZ7W+Dn8WppgMsNga8CSPuZOT2dpctmq7/4gTtPX
         q18g3fMRhte4FMm5RS28HuDsIgw+ec5QV27GaNpaCyCCITdvZkgfhkmKXnxJ4/XYIVWR
         YHvoE7gGEfunto5Tr5g/RgbhMgQvRyeFnk33JIXVsj1wy/guAfNt+hvehHU/xUnd9LUL
         ly/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type:x-gm-message-state;
        bh=jEC4ZuooUd0KVQD1qfb9u3fYaJuy66puN29jEN3i+4s=;
        b=VrGvdXXiIRWMICku/krKZlNTxxt4tVjG50YaeEAG1A5lAX6x+r8JX6G1AsDxvAEVb5
         oMgO38pC3sjZ7cT9ZBbQO0tmYEU1/SY5Pc+17FbBkriqk2H1lz1aQn7uwKKDVvcRvAUX
         ueBwtTa78f9Iz3z3dywvG7QCDByAwTBnT73kazED1v3r62tskcgDD2S7HAJ5vRp2xOGn
         yPMgGsKsnZHwpQqmAJHo0lrb2sgUnGYq/Txt7uZsXEPmt5vrzjZ7uSUmsbRbGZ2IIeNr
         qPiAdUQXQ28yNfgLcx3BOjB/dJ/Z/g81LiDzhWlCWUobIm3PVvq8yXJxM02pwLswGoSm
         BDKw==
Received: by 10.68.130.197 with SMTP id og5mr64863144pbb.138.1352792708012;
        Mon, 12 Nov 2012 23:45:08 -0800 (PST)
Received: from [2620:0:1008:1101:be30:5bff:fed8:5e64] ([2620:0:1008:1101:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPS id sz6sm5570394pbc.52.2012.11.12.23.45.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 23:45:07 -0800 (PST)
Date:   Mon, 12 Nov 2012 23:45:06 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
cc:     linux-mips@linux-mips.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [patch] mips, arc: fix build failure
In-Reply-To: <20121113170046.48e2c790d5c6c1e5f51c593d@canb.auug.org.au>
Message-ID: <alpine.DEB.2.00.1211122342570.29609@chino.kir.corp.google.com>
References: <20121113170046.48e2c790d5c6c1e5f51c593d@canb.auug.org.au>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Gm-Message-State: ALoCoQlINWsy0dt77jdgMYZkZlr69KaksJAT8AWn0nGJYcc+GWZs6/j4tjNJWOjXVLwnspUSaOgFiB8dU2BeHIMraVSaIq8MKBCA7kQGLZZBBQ19xtKravzNGAWyOpXMsc0TW0aox5NlRt/XXgqKD9HY/qxg2aUZ8UN8oBBQNkmFMh2CYuV/jNtt6ygLATZsoXPN8ydDroNrp8nu9iVBXbHIjU4mK1H79Q==
X-archive-position: 34979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Using a cross-compiler to fix another issue, the following build error 
occurred for mips defconfig:

arch/mips/fw/arc/misc.c: In function 'ArcHalt':
arch/mips/fw/arc/misc.c:25:2: error: implicit declaration of function 'local_irq_disable'

Fix it up by including irqflags.h.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/mips/fw/arc/misc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/fw/arc/misc.c b/arch/mips/fw/arc/misc.c
--- a/arch/mips/fw/arc/misc.c
+++ b/arch/mips/fw/arc/misc.c
@@ -11,6 +11,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/irqflags.h>
 
 #include <asm/bcache.h>
 
