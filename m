Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2016 15:07:17 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33854 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991859AbcIZNHKk002i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Sep 2016 15:07:10 +0200
Received: by mail-wm0-f68.google.com with SMTP id l132so14017487wmf.1
        for <linux-mips@linux-mips.org>; Mon, 26 Sep 2016 06:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=albanarts-com.20150623.gappssmtp.com; s=20150623;
        h=sender:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=V8X10Pr/n5z0Aj3SzLLprppNmkGOdh5ROZBamD5b+AM=;
        b=l9k0s1J1+0wLKDUBDsyv2No70WDWEUKalYxkdbeYjJUi0DXbG4HAJEb6W5KjPQOpm5
         E9LDYql/d9QAhJbEUTARjLJuZy9kzKEhIo5C3RLHot10MlS8EUmR7i42lXlEvsusp/9E
         2/I5x+mX9G71zbTMdWFaFoSRQOk/4nayl2TYFO6vUbiGKYgVgPlUlEHvl3NFFWSP1cyX
         iQ0Sq2uCbVVFDvgKgE4k2v/9jYo2NH3AkDOBrWvzXerOjzf7gxvVkcaQeSIVDQYEy38W
         Wbkeqg1PqubSKb04W4Yw0g+9RlwqGrIyll5rNGcLWEYXeXhIy4iGFF8xImJYRqUizWla
         u24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=V8X10Pr/n5z0Aj3SzLLprppNmkGOdh5ROZBamD5b+AM=;
        b=lLPowdaKL0YjOX/YcfyMkln6VK5qsiaE7k93iERMMdAS9JCYR+gDIDLKlB4dswONBP
         vLcYpIhxgXJkl1sVMo30H72oFn4MjnRqaVt8njrCDE1YpcEgg7T15u9LrV/u0Y5zOJYg
         DfHOb0TEs/xhoDsBPy8LCys0SMcUT/Sz/V1UaDXYBFDaWky7dDj63MB8zdLnLxY5ZR+g
         iPPLD7NNsnBA0Vn/lSb6Nsb3r+8qW0Obx0RRcCSpkfkROHqe/soCdosuFWNVWyMzjS7V
         7FQqF7De6vNOwH7vRVY2Ey9SRYZo0muegQeZ6N1aQWzP7q8eXij/Zc25JjRxbC/pnSZG
         fTtQ==
X-Gm-Message-State: AA6/9Rk8F4BB+zY/WmWEvbPnHZrHZyAWxs+95xav5zDYTX6e+aeTKEFON8YcO+DuZmireA==
X-Received: by 10.194.71.104 with SMTP id t8mr1934605wju.17.1474895225256;
        Mon, 26 Sep 2016 06:07:05 -0700 (PDT)
Received: from gollum (jahogan.plus.com. [212.159.75.221])
        by smtp.gmail.com with ESMTPSA id r194sm11191996wmf.22.2016.09.26.06.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Sep 2016 06:07:04 -0700 (PDT)
In-Reply-To: <20160926102437.GB12981@linux-mips.org>
References: <201609240204.arLAdO5Z%fengguang.wu@intel.com> <20160926102437.GB12981@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [mips-sjhill:mips-for-linux-next 58/62] arch/mips/kernel/uprobes.c:304:15: error: variable or field 'kstart' declared void
From:   James Hogan <james.hogan@imgtec.com>
Date:   Mon, 26 Sep 2016 14:07:03 +0100
To:     Ralf Baechle <ralf@linux-mips.org>,
        kbuild test robot <fengguang.wu@intel.com>
CC:     kbuild-all@01.org, linux-mips@linux-mips.org
Message-ID: <5302CFBF-1016-4704-B3AE-3BD986E5DD3B@imgtec.com>
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 26 September 2016 11:24:38 BST, Ralf Baechle <ralf@linux-mips.org> wrote:
>On Sat, Sep 24, 2016 at 02:06:11AM +0800, kbuild test robot wrote:
>
>> From: kbuild test robot <fengguang.wu@intel.com>
>> To: James Hogan <james.hogan@imgtec.com>
>> Cc: kbuild-all@01.org, linux-mips@linux-mips.org, Ralf Baechle
>>  <ralf@linux-mips.org>
>> Subject: [mips-sjhill:mips-for-linux-next 58/62]
>>  arch/mips/kernel/uprobes.c:304:15: error: variable or field 'kstart'
>>  declared void
>> Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
>> 
>> tree:   git://git.linux-mips.org/pub/scm/sjhill/linux-sjhill.git
>mips-for-linux-next
>> head:   3cd97a2d95ac84bf17d4d538960d3e17585a791c
>> commit: a0b7ccb92e7b57f3c4cf5bf8a875fe7ecf00fe2c [58/62] MIPS:
>uprobes: Flush icache via kernel address
>> config: mips-allmodconfig (attached as .config)
>> compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>         wget
>https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross
>-O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout a0b7ccb92e7b57f3c4cf5bf8a875fe7ecf00fe2c
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=mips 
>> 
>> All error/warnings (new ones prefixed by >>):
>> 
>>    arch/mips/kernel/uprobes.c: In function 'arch_uprobe_copy_ixol':
>> >> arch/mips/kernel/uprobes.c:304:15: error: variable or field
>'kstart' declared void
>>      void *kaddr, kstart;
>>                   ^~~~~~
>> >> arch/mips/kernel/uprobes.c:308:9: warning: assignment makes
>integer from pointer without a cast [-Wint-conversion]
>>      kstart = kaddr + (vaddr & ~PAGE_MASK);
>>             ^
>> >> arch/mips/kernel/uprobes.c:309:9: warning: passing argument 1 of
>'memcpy' makes pointer from integer without a cast [-Wint-conversion]
>>      memcpy(kstart, src, len);
>>             ^~~~~~
>>    In file included from include/linux/string.h:18:0,
>>                     from include/linux/bitmap.h:8,
>>                     from include/linux/cpumask.h:11,
>>                     from arch/mips/include/asm/processor.h:15,
>>                     from arch/mips/include/asm/thread_info.h:15,
>>                     from include/linux/thread_info.h:54,
>>                     from include/asm-generic/preempt.h:4,
>>                     from
>./arch/mips/include/generated/asm/preempt.h:1,
>>                     from include/linux/preempt.h:59,
>>                     from include/linux/spinlock.h:50,
>>                     from include/linux/wait.h:8,
>>                     from include/linux/fs.h:5,
>>                     from include/linux/highmem.h:4,
>>                     from arch/mips/kernel/uprobes.c:1:
>>    arch/mips/include/asm/string.h:138:14: note: expected 'void *' but
>argument is of type 'int'
>>     extern void *memcpy(void *__to, __const__ void *__from, size_t
>__n);
>>                  ^~~~~~
>> 
>> vim +/kstart +304 arch/mips/kernel/uprobes.c
>> 
>>    298				*(uprobe_opcode_t *)&auprobe->orig_inst[0].word);
>>    299	}
>>    300	
>>    301	void __weak arch_uprobe_copy_ixol(struct page *page, unsigned
>long vaddr,
>>    302					  void *src, unsigned long len)
>>    303	{
>>  > 304		void *kaddr, kstart;
>>    305	
>>    306		/* Initialize the slot */
>>    307		kaddr = kmap_atomic(page);
>>  > 308		kstart = kaddr + (vaddr & ~PAGE_MASK);
>>  > 309		memcpy(kstart, src, len);
>>    310		flush_icache_range(kstart, kstart + len);
>>    311		kunmap_atomic(kaddr);
>>    312	}
>
>Something like below patch should do the trick.  James?

My intention was I think for kstart to be void * (and to use void * arithmetic), but i'm indifferent if you prefer unsigned long for that. Apparently my build coverage was lacking for this patch, sorry about that!

Thanks
James

>
>  Ralf
>
>Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>
> arch/mips/kernel/uprobes.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
>index 9a507ab..a896417 100644
>--- a/arch/mips/kernel/uprobes.c
>+++ b/arch/mips/kernel/uprobes.c
>@@ -301,14 +301,14 @@ int set_orig_insn(struc arch_uprobe *auprobe,
>struct mm_struct *mm,
>void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long
>vaddr,
> 				  void *src, unsigned long len)
> {
>-	void *kaddr, kstart;
>+	unsigned long kaddr, kstart;
> 
> 	/* Initialize the slot */
>-	kaddr = kmap_atomic(page);
>+	kaddr = (unsigned long)kmap_atomic(page);
> 	kstart = kaddr + (vaddr & ~PAGE_MASK);
>-	memcpy(kstart, src, len);
>+	memcpy((void *)kstart, src, len);
> 	flush_icache_range(kstart, kstart + len);
>-	kunmap_atomic(kaddr);
>+	kunmap_atomic((void *)kaddr);
> }
> 
> /**


--
James Hogan
