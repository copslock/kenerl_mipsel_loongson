Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2010 12:22:32 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:57166 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491755Ab0JRKW3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Oct 2010 12:22:29 +0200
Received: by pzk26 with SMTP id 26so116199pzk.36
        for <linux-mips@linux-mips.org>; Mon, 18 Oct 2010 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rmwI80ooueWTuKDCnyYFChow+KsAs1xHct1Y3Sh8fwE=;
        b=uUIJcgXUZkittRebHCZdWnnvaQ6i+AL/m5BoKwdpwfZntotADGiv4iBI8v7qMIGlmu
         2PEaet54pXiLpEeOKgIxUKObllzyFJicSAf27dvIFj//n/6/stnaTFvnE/IdEDfKogQA
         lB/v8LK4QEreNbF/cVgywgJCRGYyJvkJlUKGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uKTO7BPtoT2gy4YWj8Vm2ykPmENXCJbHwq5ck0Ch3SUPmdNGRO0g5sLJHkVRmBRI7V
         1T2H4n/XSsQ+FR//QYiT4RPT6cYok1X3QlT18TCMvvjv9MOCPPw/AY/PpfVJfPLdK7Vj
         Mkf7UCUQmUsiR4O8+uKVBx/w7RuXSac4561Gc=
Received: by 10.142.192.20 with SMTP id p20mr866904wff.42.1287397342489;
        Mon, 18 Oct 2010 03:22:22 -0700 (PDT)
Received: from cr0.nay.redhat.com ([60.247.97.98])
        by mx.google.com with ESMTPS id p8sm22653314wff.16.2010.10.18.03.22.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 03:22:05 -0700 (PDT)
Date:   Mon, 18 Oct 2010 18:26:39 +0800
From:   =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
To:     "wilbur.chan" <wilbur512@gmail.com>
Cc:     linux-kernel <Linux-kernel@zh-kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Question about kimage_alloc_page in kexec.c, bug?
Message-ID: <20101018102639.GM5281@cr0.nay.redhat.com>
References: <AANLkTi=ST1v55skkQbfsNQsmiBpOARwAnTxCpptsTdtB@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTi=ST1v55skkQbfsNQsmiBpOARwAnTxCpptsTdtB@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <xiyou.wangcong@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiyou.wangcong@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Oct 11, 2010 at 10:46:59PM +0800, wilbur.chan wrote:
>Hi all !
>
>I have a question on kimage_alloc_page:
>
...

You can Cc me on kexec/kdump issues. :)

>
>
>If  a page frame is right at physical address 0x20000000 ,  then when calling
>
>machine_kexec , the following code:
>
>*ptr = (unsigned long) phys_to_virt(*ptr);
>
>will generate an virtual address of 0xa0000000 = 0x20000000+0x80000000 , which
>
>results in physical address 0.
>
>
>
>should it be like this?  :
>
>--- kexec.c     2010-08-27 07:47:12.000000000 +0800
>+++ kexec.changed.c     2010-10-11 22:04:08.000000000 +0800
>@@ -723,7 +723,7 @@
>                if (!page)
>                        return NULL;
>                /* If the page cannot be used file it away */
>-               if (page_to_pfn(page) >
>+               if (page_to_pfn(page) >=
>                                (KEXEC_SOURCE_MEMORY_LIMIT >> PAGE_SHIFT)) {
>                        list_add(&page->lru, &image->unuseable_pages);
>                        continue;
>

No, this could break x86_64.

IMHO, what needs to fix is the definition of KEXEC_SOURCE_MEMORY_LIMIT
on MIPS, something like:

- #define KEXEC_SOURCE_MEMORY_LIMIT (0x20000000)
+ #define KEXEC_SOURCE_MEMORY_LIMIT (0x1FFFFFFF)


Thanks.
