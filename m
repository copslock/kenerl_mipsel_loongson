Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2009 19:52:39 +0100 (BST)
Received: from mail-pz0-f134.google.com ([209.85.222.134]:59550 "EHLO
	mail-pz0-f134.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021686AbZE0Swd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2009 19:52:33 +0100
Received: by pzk40 with SMTP id 40so4340563pzk.22
        for <multiple recipients>; Wed, 27 May 2009 11:52:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=FQwQm0Y3Nhkbu0wnIddU8klR4WDu7nTpl0Kzt/zVGn4=;
        b=FHy8kZQ7vNY36sy9atc8q/81H9jDIXvGuAkodKncR5FaaQVShysP8L6X53g+waDAzf
         YlclOLig7oOQ9LvqS0D/o/6L/2WKerxFjmXdIi/0jIsTRZ6LHPAWvhLrGghIjMohyCtL
         WeIaXBCfi5ntYEHSyqIBumQmn2s8V61EXgHpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=tK7b5RIQcdoHh0aoGWXWKWzJEZkJZYkT3hIMGRHmciLCfFILJIC2F+qMNKeCrBxEdL
         mhJog0LpgtR/wUzm2oi8pm2XAb96R3/reQWtgPXgE9gBDf7nP2UPfVfdJHNmRr7ugsxI
         jVhWmD2O684/CKpGbArY72xgBgGO50V/82NnE=
Received: by 10.115.18.1 with SMTP id v1mr547142wai.175.1243450346009;
        Wed, 27 May 2009 11:52:26 -0700 (PDT)
Received: from ?192.168.1.100? ([219.246.59.144])
        by mx.google.com with ESMTPS id j34sm165953waf.29.2009.05.27.11.52.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 11:52:25 -0700 (PDT)
Subject: Re: [loongson-PATCH-v2 23/23] Hibernation Support in mips system
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Arnaud Patard <apatard@mandriva.com>, huhb@lemote.com
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <m3my8yoovk.fsf@anduin.mandriva.com>
References: <cover.1243362545.git.wuzj@lemote.com>
	 <1483a7cb0f587bd329ea3ca8d3af2881afadaf5e.1243362545.git.wuzj@lemote.com>
	 <m3my8yoovk.fsf@anduin.mandriva.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 28 May 2009 02:52:19 +0800
Message-Id: <1243450339.11263.125.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, 2009-05-27 at 11:51 +0200, Arnaud Patard wrote:
> > +LEAF(swsusp_arch_resume)
> > +	PTR_L t0, restore_pblist
> > +0:
> > +	PTR_L t1, PBE_ADDRESS(t0)   /* source */
> > +	PTR_L t2, PBE_ORIG_ADDRESS(t0) /* destination */
> > +	PTR_ADDIU t3, t1, _PAGE_SIZE
> > +1:
> > +	REG_L t8, (t1)
> > +	REG_S t8, (t2)
> > +	PTR_ADDIU t1, t1, SZREG
> > +	PTR_ADDIU t2, t2, SZREG
> > +	bne t1, t3, 1b
> > +	PTR_L t0, PBE_NEXT(t0)
> > +	bnez t0, 0b
> 
> you really need to flush cache/tlb here. If you don't do that you'll get
> some weird bugs.
> 

is this okay?

diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
index 9dbe48e..1f06fd5 100644
--- a/arch/mips/power/hibernate.S
+++ b/arch/mips/power/hibernate.S
@@ -2,6 +2,14 @@
 #include <asm/asm-offsets.h>
 #include <asm/regdef.h>
 #include <asm/asm.h>
+
+       .extern flush_cache_all
+#ifdef CONFIG_SMP
+       .extern flush_tlb_all
+#else
+       .extern local_flush_tlb_all
+#define flush_tlb_all local_flush_tlb_all
+#endif
 
 .text
 LEAF(swsusp_arch_suspend)
@@ -39,6 +47,16 @@ LEAF(swsusp_arch_resume)
        bne t1, t3, 1b
        PTR_L t0, PBE_NEXT(t0)
        bnez t0, 0b
+       /* flush caches to make sure context is in memory */
+       PTR_LA t1, flush_cache_all
+       PTR_L t0, 0(t1)
+       jalr t0
+       nop
+       /* flush tlb entries */
+       PTR_LA t1, flush_tlb_all
+       PTR_L t0, 0(t1)
+       jalr t0
+       nop
        PTR_LA t0, saved_regs
        PTR_L ra, PT_R31(t0)
        PTR_L sp, PT_R29(t0)

to Hongbing Hu,
 
    could you please help to test it? i do not have a Yeeloong laptop
currently. the above patch is applied to the latest git branch:
   
   git://dev.lemote.com/rt4ls.git linux-loongson-dev-to-ralf

thx!
Wu Zhangjin
