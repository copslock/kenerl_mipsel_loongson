Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 21:38:07 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:52479 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022227AbXJIUh6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Oct 2007 21:37:58 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1328075nfd
        for <linux-mips@linux-mips.org>; Tue, 09 Oct 2007 13:37:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=Z/eRmMHZpeqIRWklbGNgVwZEv7NzUHEYQ3a4maj/vOU=;
        b=mA/smiZKCNovDlfAeZks+H8PkcXVrcYB6b+4urg2Jk8EAMEyWqa1EJPUcas5nT7eqr6a2Jk9rAyWCGCTO+7Q33G/aAmQDXnYHPXSV3zfiiALu296D0pSxJBUJ8h6tZn40jS8nxNuq2iMW/PRve1zWl9dpNs6LgMpK35DFCKDxX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=txbOfI3SJocryiU55VevgjWwk11tmDlPXFoJfskeUXO5FZC9y2kFq6P/9BhsQRf0anmVNc5Hau0RJmkqBCtQ6yBiKKzvNwjioLQNc2a//VCRATxZ3C8LKepViL8phg9euTrUvgePDW2MbOGYY4TDN5kypZVjXVThDxeU3B/lzuM=
Received: by 10.86.70.8 with SMTP id s8mr6292840fga.1191962276176;
        Tue, 09 Oct 2007 13:37:56 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id o11sm9149813fkf.2007.10.09.13.37.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Oct 2007 13:37:53 -0700 (PDT)
Message-ID: <470BE68F.5090000@gmail.com>
Date:	Tue, 09 Oct 2007 22:37:35 +0200
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: [PATCH 4/6] tlbex.c: remove final_handler[] from init.data section
 
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
X-archive-position: 16916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

This patch uses 256 stack bytes and decreases the kernel image
of the same size.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/mm/tlbex.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index cbcb320..6991b89 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1248,15 +1248,12 @@ static void __init build_update_entries(u32 **p, unsigned int tmp,
  * other one.To keep things simple, we first assume linear space,
  * then we relocate it to the final handler layout as needed.
  */
-static u32 final_handler[64] __initdata;
-
-
 static void __init build_r4000_tlb_refill_handler(void)
 {
 	u32 tlb_handler[128], *p = tlb_handler;
+	u32 final_handler[64], *f;
 	struct label labels[128], *l = labels;
 	struct reloc relocs[128], *r = relocs;
-	u32 *f;
 	unsigned int final_len;
 	int i;
 
-- 
1.5.3.3
