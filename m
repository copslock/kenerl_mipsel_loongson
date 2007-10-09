Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 21:39:43 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:44049 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022290AbXJIUji (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Oct 2007 21:39:38 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1328417nfd
        for <linux-mips@linux-mips.org>; Tue, 09 Oct 2007 13:39:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=fQk79EeXC0qM1iUetlh6tm7MpJyTlvCpv4VIa92ZDH0=;
        b=gc7krg8k27K8OMPXR+LS42ocdqssascYR+Y0d0OFIZdkZC7vv+5JVC1DoE3AWeBT9ah3brQdJf54wicOlT2Tv3tNsgw/wVpmOGKNYRJSvsbQZKwSdk7K09Bfdfxe/NqXjCRf7bN6403M7rd+7XgCVtpGRta4tphEekmAz2X5K04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=IMua0hwIo4JcjOjJeUMFEgmbIKwNfwNaw+0lTK7BHafoCbCqGgmfPI1OxJB+lAttVgt/JcMMou0R96bjgfVDGD3LBFaO4QPHcn3fU9kQl01xeMGgnc3mfyYleCqxhWDjmALfe8XgaYMol0vk/OtkVJ2vD33cTavIpK0zdHYNpKs=
Received: by 10.86.100.7 with SMTP id x7mr6294559fgb.1191962360842;
        Tue, 09 Oct 2007 13:39:20 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id 28sm9065597fkx.2007.10.09.13.39.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Oct 2007 13:39:19 -0700 (PDT)
Message-ID: <470BE6E5.2060707@gmail.com>
Date:	Tue, 09 Oct 2007 22:39:01 +0200
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: [PATCH 6/6] tlbex.c: cleanup include files   
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org> <470BE58A.9070709@gmail.com>
In-Reply-To: <470BE58A.9070709@gmail.com>
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips


Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/mm/tlbex.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index e725072..05dc390 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -19,20 +19,11 @@
  * (Condolences to Napoleon XIV)
  */
 
-#include <stdarg.h>
-
-#include <linux/mm.h>
 #include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/init.h>
 
-#include <asm/pgtable.h>
-#include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/inst.h>
 #include <asm/elf.h>
-#include <asm/smp.h>
 #include <asm/war.h>
 
 static inline int r45k_bvahwbug(void)
-- 
1.5.3.3
