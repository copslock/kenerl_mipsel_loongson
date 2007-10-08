Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2007 15:12:27 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:40602 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021488AbXJHOMS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Oct 2007 15:12:18 +0100
Received: by nf-out-0910.google.com with SMTP id c10so937810nfd
        for <linux-mips@linux-mips.org>; Mon, 08 Oct 2007 07:12:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=jyNnqhqwmVhGNOlWKsvHm68xu0pghzIrJOi2NGT66gk=;
        b=OI18PudzGevWRBMyUIlTWqvxubZ5Eu0TCr2mLBXjpY85FYLEa0bTwFOUQ3DHsZ3GuOUolbpOAYBepkRjFnA3CFB6CBk5R3JKwwv1I+uHKsmca4ISQf0TB3prohoHD7pCtwNdgSCsbMFoF/ILc6sG1Pde/hd330ATOawVb5f2Pxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=s445rPReu+ZfJt7qsewhTtgmt0qlXsZYrhdHbWyzq7Elxi1xhxp5yJbOk4Sn/k354dBAL9K6Yc8WyZKFKGgd7H+bXz5vU7Uf4d58NXhSg+kxVEEBsf8BFgHGlUBtFNUkKDnL5knBwXLGNkLOdVaB/Rfufgo9FIM5PuBD1iBo5gI=
Received: by 10.86.50.8 with SMTP id x8mr5163746fgx.1191852721089;
        Mon, 08 Oct 2007 07:12:01 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id p38sm11604050fke.2007.10.08.07.11.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Oct 2007 07:11:58 -0700 (PDT)
Message-ID: <470A3AA7.7030700@gmail.com>
Date:	Mon, 08 Oct 2007 16:11:51 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org>
In-Reply-To: <20071005115151.GA16145@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> 6828 bytes isn't totally amazing but since the optimization is reasonable
> clean I'm going to queue this one also.
> 

Yes and maybe it worths to queue this on top of your patch ?

--- 8< ---

From: Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH] Verify CPU type when it's hardwiring

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/cpu-probe.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 06448a9..cf0b566 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -817,6 +817,14 @@ __init void cpu_probe(void)
 	default:
 		c->cputype = CPU_UNKNOWN;
 	}
+
+	/*
+	 * Platform code can force the cpu type to optimize code
+	 * generation. In that case be sure the cpu type is correctly
+	 * manually setup otherwise it could trigger some nasty bugs.
+	 */
+	BUG_ON(current_cpu_type() != c->cputype);
+
 	if (c->options & MIPS_CPU_FPU) {
 		c->fpu_id = cpu_get_fpu_id();
 
-- 
1.5.3.3
