Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 09:06:03 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:31898 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022267AbXIZIFz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 09:05:55 +0100
Received: by ug-out-1314.google.com with SMTP id u2so1243506uge
        for <linux-mips@linux-mips.org>; Wed, 26 Sep 2007 01:05:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=fL8BhB2rH8F8U0OalTgKfLErDqlfe47+CPLOGG0nPOw=;
        b=aqEpgzbdGZ7y25ELvX9mIkP85b9qajmKR/jRWIVGOGohjzpRqkU9cbnDp3+pciG6YwPURmbQa4TWDjhdZwThRESVrhGT/+1s+U/DaFMXU6yYs0cDIC6qkAlsuW8/5yMAQeCaVsJ9OgeuqtpVgQ3Z0dQbHdzxG6S14L0LttC1Ppc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qdr+dXL9v0r0L9AxSj0XsgZBOhlScd3aA+jSHiIUL3FUUDp9brLZuM0GBpskC8bGz8z8P8iXTFer+RBu1t2EVFsTXSpFhqOkX41FbTrVYXWJ7++XR4MHjR7I3w/uA0G9csj86PIuMhr2DeyfybEh7g18qFoYcyfT9Rur33RO8ok=
Received: by 10.67.28.3 with SMTP id f3mr1827527ugj.1190793936957;
        Wed, 26 Sep 2007 01:05:36 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id v23sm1000705fkd.2007.09.26.01.05.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Sep 2007 01:05:36 -0700 (PDT)
Message-ID: <46FA1260.4000404@gmail.com>
Date:	Wed, 26 Sep 2007 10:03:44 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Martin Michlmayr <tbm@cyrius.com>
CC:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
References: <20070925181353.GA15412@deprecation.cyrius.com>
In-Reply-To: <20070925181353.GA15412@deprecation.cyrius.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> IP32 kernels that are built with CONFIG_BUILD_ELF64=y only produce an
> exception when booted.  This worked with 2.6.19 and before.  I haven't
> had a chance to dig deep yet but it seems both Franck Bui-Huu and
> Atsushi Nemoto had patches in 2.6.20 that might have caused this.

I'm the culprit ;) but...

> This still happens with 2.6.22.  I cannot boot current git for other
> reasons.
> 
> If anyone has an idea which specific patch might have caused this,
> please let me know.  Otherwise I'll try to find time in the next few
> days to revert various patches.

It's sad to see this issue is still not fixed. Some people complained
about IPxx kernels broken by CONFIG_BUILD_ELF64 config but disappear
once they reported the problem. Anyways, hopefully this time we could
do a better job...

OK, it seems that Ralf's commit
db423f6e86c3c4c70edf3eaf504e22c467b9f97c fixes your issue. But
actually I think it just hides another problem. Because with
CONFIG_BUILD_ELF64=y you claim to run a kernel with 64 bit
symbols. However if the previous commit fixes your issue then it shows
that your kernel handles a symbol linked in CKSEG0 although
CONFIG_BUILD_ELF64 is set.

To verify this, could you apply the following patch _without_ Ralf's
commit and report back the trace. You may need to enable early printk
to see something and be sure CONFIG_KALLSYMS_ALL is set.

thanks,
		Franck

-- 8< --

diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index b92dd8c..a469cf1 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -149,8 +149,17 @@ typedef struct { unsigned long pgprot; } pgprot_t;
     __x < CKSEG0 ? XPHYSADDR(__x) : CPHYSADDR(__x);			\
 })
 #else
-#define __pa(x)								\
-    ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
+static inline unsigned long __pa(void *p)
+{
+	unsigned long x = (unsigned long)p;
+
+	if (x > CKSEG0 - 1) {
+		__print_symbol("*** __pa: symbol in CKSEG0 found: %s\n", x);
+		BUG();
+	}
+
+	return x - PAGE_OFFSET + PHYS_OFFSET;
+}
 #endif
 #define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
 #define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x),0))
