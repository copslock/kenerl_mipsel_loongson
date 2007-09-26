Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 16:22:15 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.174]:45316 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20029756AbXIZPWG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 16:22:06 +0100
Received: by ug-out-1314.google.com with SMTP id u2so1319527uge
        for <linux-mips@linux-mips.org>; Wed, 26 Sep 2007 08:22:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=CDMDCcMvv7kXPtLR0oHFr62rQOJ2c19qPkuD4yXtZCU=;
        b=o04oawuWmDx2T4GxdPuob+MuUOazic4vi3M6lTOkE3fJZaayJ8tFvJ8xvKwcIPUmacHn5loaviKqQwEpEInPDrzZG7o3UDA+f3sqQQfiaeS0G+V5x+kLdaCgAaV/AI8yg0krbXEy64yoa3nH320eTVyZKPbMk2JXBYWXvZiz5aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=P274ejhIgt2jeNKFOcbPoYi1hYFhnaQPYH69a1vGw4J0bOqe6Vv2pGdaSBxO7DBTpB3ZKFnVa4G6SykvsNs1ZGu2xSFe9RouiTHcpVEt1y9jzfhiQJnhDqY4C+foOCm5u2lgrrK9M4QLjdppGZmAw/dKn8CCSyNyylAeMewaU08=
Received: by 10.66.239.16 with SMTP id m16mr2320700ugh.1190820126198;
        Wed, 26 Sep 2007 08:22:06 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id g28sm1874691fkg.2007.09.26.08.22.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Sep 2007 08:22:05 -0700 (PDT)
Message-ID: <46FA78AA.9050104@gmail.com>
Date:	Wed, 26 Sep 2007 17:20:10 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	nigel@mips.com, linux-mips <linux-mips@linux-mips.org>
Subject: Re: Useless stack randomization patch
References: <46FA6846.2080704@gmail.com> <20070926150433.GA28017@linux-mips.org>
In-Reply-To: <20070926150433.GA28017@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Sep 26, 2007 at 04:10:14PM +0200, Franck Bui-Huu wrote:
> I suppose we should give it a sane definition.  Not sure what would be
> useful, if it should be like an ASCII string with the processor type or
> more corse grained like just "mips32r2", should ASEs be mentioned ...
> 

Well before giving any sane definition, shouldn't we know why this
dependency (ELF_PLATFORM/sp-randomization) exists at all...

Is something like the patch below better ?

		Franck

-- 8< --


diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 43143c5..e8713fb 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -150,6 +150,13 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	struct vm_area_struct *vma;
 
 	/*
+	 * In some cases (e.g. Hyper-Threading), we want to avoid L1
+	 * evictions by the processes running on the same package. One
+	 * thing we can do is to shuffle the initial stack for them.
+	 */
+	p = arch_align_stack(p);
+
+	/*
 	 * If this architecture has a platform capability string, copy it
 	 * to userspace.  In some cases (Sparc), this info is impossible
 	 * for userspace to get any other way, in others (i386) it is
@@ -159,14 +166,6 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	if (k_platform) {
 		size_t len = strlen(k_platform) + 1;
 
-		/*
-		 * In some cases (e.g. Hyper-Threading), we want to avoid L1
-		 * evictions by the processes running on the same package. One
-		 * thing we can do is to shuffle the initial stack for them.
-		 */
-
-		p = arch_align_stack(p);
-
 		u_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
 		if (__copy_to_user(u_platform, k_platform, len))
 			return -EFAULT;
