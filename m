Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 23:35:26 +0200 (CEST)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:44254
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993981AbeHUVfNGv0RB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2018 23:35:13 +0200
Received: by mail-qt0-x244.google.com with SMTP id r13-v6so3354083qtr.11;
        Tue, 21 Aug 2018 14:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m+IuSnKQ7IEIHXv+7bjc/GLCfCkBioJh6XY2GGUJ6/Q=;
        b=kWcXVlsCy2IiKe6hqOyOxlAFX47ECftBf2+t3+fIP0zZNJ6X3M+X6yfkkBbMVRe0Y7
         xmS3p2jcMhLuTkoE+Bund+7MapAZGGBYAQSuLt1UkqE8OwLO3Vy3txYxwKbHahSndYwa
         wF8KH6t8ufFMPvQQRTmNk05E64f7WGehUepovS6ershE7VXWFPlzkiNkdHcJj7JNKxpQ
         buqbk7SnTl10EiQUSIC6ozY4FELgoebzSXboqtRF1vaWgPLLtF+Obj3WyVnJanmMewll
         rPX2ocdzLPL/2krFHl8bAEh0VYHATTN07lY4KMdBTw1mf8Vk1A3B35MjuQL9zFsycArj
         9TFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m+IuSnKQ7IEIHXv+7bjc/GLCfCkBioJh6XY2GGUJ6/Q=;
        b=bfo3XFLfHfJMMhW4i1ve+oZdnDyuSUSLJb+/DndfTZ9TDeQWlIxXCZJmirCzhHynzF
         DOx3AH/sJv8J5oFpylF/qiK6ZsW6hnZkSCB633qSj0ZHFvfpByJOLtX1GnT39YlpPNuK
         Vec0KagUMjFXX+xuQle/Sxlgpgw0tNk2OSVtmrRjP5ZF6FzamN8DdztvaM6AaqQbJ2Bt
         Se5FCeyvtz+vEhgrp9DQwqOUTpqysMNCPckMF0K4p8cOg5lD//C4urCjqkSahIBSdBtA
         kfbFA1NzzeeWkCrQnHsCpkPoRAiMbRbqtdZgNiRSe+tvxRrgkdRtMa8eatkdgMfFb6Om
         oyXQ==
X-Gm-Message-State: APzg51AJXBLjhkh+iOVGsHy/XqyDG9aWqkOyItnLHnyfgE0AiQxx5+Ag
        a4erpyGc/AzRtCuPWMdU2Sg0IaUHSfJ2qoeiK74=
X-Google-Smtp-Source: ANB0VdZuxkUFAxvNdQa50Cl7Yi5z6uXU8nLdL5gJjVy3fsFzkrWBpzc5jjMDMw3JWfUmSyl2se3HT4FJ6sTmdULIbRI=
X-Received: by 2002:a0c:9251:: with SMTP id 17-v6mr12209992qvz.239.1534887307151;
 Tue, 21 Aug 2018 14:35:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 14:35:06
 -0700 (PDT)
In-Reply-To: <CAPhsuW7XAfade333RpwrauYDgeWNEwQhXFjx64vAbtnyb-3wdA@mail.gmail.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <20180820044250.11659-2-ravi.bangoria@linux.ibm.com> <CAPhsuW7XAfade333RpwrauYDgeWNEwQhXFjx64vAbtnyb-3wdA@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 21 Aug 2018 14:35:06 -0700
Message-ID: <CAPhsuW5jW0bED4-PV6S_M-vg36scKxjGth1J0quLPr9Q+Uc39Q@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <liu.song.a23@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liu.song.a23@gmail.com
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

On Sun, Aug 19, 2018 at 10:53 PM, Song Liu <liu.song.a23@gmail.com> wrote:
> On Sun, Aug 19, 2018 at 9:42 PM, Ravi Bangoria
> <ravi.bangoria@linux.ibm.com> wrote:
>> Userspace Statically Defined Tracepoints[1] are dtrace style markers
>> inside userspace applications. Applications like PostgreSQL, MySQL,
>> Pthread, Perl, Python, Java, Ruby, Node.js, libvirt, QEMU, glib etc
>> have these markers embedded in them. These markers are added by developer
>> at important places in the code. Each marker source expands to a single
>> nop instruction in the compiled code but there may be additional
>> overhead for computing the marker arguments which expands to couple of
>> instructions. In case the overhead is more, execution of it can be
>> omitted by runtime if() condition when no one is tracing on the marker:
>>
>>     if (reference_counter > 0) {
>>         Execute marker instructions;
>>     }
>>
>> Default value of reference counter is 0. Tracer has to increment the
>> reference counter before tracing on a marker and decrement it when
>> done with the tracing.
>>
>> Implement the reference counter logic in core uprobe. User will be
>> able to use it from trace_uprobe as well as from kernel module. New
>> trace_uprobe definition with reference counter will now be:
>>
>>     <path>:<offset>[(ref_ctr_offset)]
>>
>> where ref_ctr_offset is an optional field. For kernel module, new
>> variant of uprobe_register() has been introduced:
>>
>>     uprobe_register_refctr(inode, offset, ref_ctr_offset, consumer)
>>
>> No new variant for uprobe_unregister() because it's assumed to have
>> only one reference counter for one uprobe.
>>
>> [1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
>>
>> Note: 'reference counter' is called as 'semaphore' in original Dtrace
>> (or Systemtap, bcc and even in ELF) documentation and code. But the
>> term 'semaphore' is misleading in this context. This is just a counter
>> used to hold number of tracers tracing on a marker. This is not really
>> used for any synchronization. So we are calling it a 'reference counter'
>> in kernel / perf code.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
>> [Only trace_uprobe.c]
>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>
> Reviewed-by: Song Liu <songliubraving@fb.com>

Reviewed-and-tested-by: Song Liu <songliubraving@fb.com>

>
>> ---
>>  include/linux/uprobes.h     |   5 +
>>  kernel/events/uprobes.c     | 259 ++++++++++++++++++++++++++++++++++++++++++--
>>  kernel/trace/trace.c        |   2 +-
>>  kernel/trace/trace_uprobe.c |  38 ++++++-
>>  4 files changed, 293 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
>> index bb9d2084af03..103a48a48872 100644
>> --- a/include/linux/uprobes.h
>> +++ b/include/linux/uprobes.h
>> @@ -123,6 +123,7 @@ extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
>>  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
>>  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
>>  extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
>> +extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
>>  extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
>>  extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
>>  extern int uprobe_mmap(struct vm_area_struct *vma);
>> @@ -160,6 +161,10 @@ uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
>>  {
>>         return -ENOSYS;
>>  }
>> +static inline int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc)
>> +{
>> +       return -ENOSYS;
>> +}
>>  static inline int
>>  uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool add)
>>  {
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index 919c1ce32beb..35065febcb6c 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -73,6 +73,7 @@ struct uprobe {
>>         struct uprobe_consumer  *consumers;
>>         struct inode            *inode;         /* Also hold a ref to inode */
>>         loff_t                  offset;
>> +       loff_t                  ref_ctr_offset;
>>         unsigned long           flags;
>>
>>         /*
>> @@ -88,6 +89,15 @@ struct uprobe {
>>         struct arch_uprobe      arch;
>>  };
>>
>> +struct delayed_uprobe {
>> +       struct list_head list;
>> +       struct uprobe *uprobe;
>> +       struct mm_struct *mm;
>> +};
>> +
>> +static DEFINE_MUTEX(delayed_uprobe_lock);
>> +static LIST_HEAD(delayed_uprobe_list);
>> +
>>  /*
>>   * Execute out of line area: anonymous executable mapping installed
>>   * by the probed task to execute the copy of the original instruction
>> @@ -282,6 +292,166 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
>>         return 1;
>>  }
>>
>> +static struct delayed_uprobe *
>> +delayed_uprobe_check(struct uprobe *uprobe, struct mm_struct *mm)
>> +{
>> +       struct delayed_uprobe *du;
>> +
>> +       list_for_each_entry(du, &delayed_uprobe_list, list)
>> +               if (du->uprobe == uprobe && du->mm == mm)
>> +                       return du;
>> +       return NULL;
>> +}
>> +
>> +static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
>> +{
>> +       struct delayed_uprobe *du;
>> +
>> +       if (delayed_uprobe_check(uprobe, mm))
>> +               return 0;
>> +
>> +       du  = kzalloc(sizeof(*du), GFP_KERNEL);
>> +       if (!du)
>> +               return -ENOMEM;
>> +
>> +       du->uprobe = uprobe;
>> +       du->mm = mm;
>> +       list_add(&du->list, &delayed_uprobe_list);
>> +       return 0;
>> +}
>> +
>> +static void delayed_uprobe_delete(struct delayed_uprobe *du)
>> +{
>> +       if (WARN_ON(!du))
>> +               return;
>> +       list_del(&du->list);
>> +       kfree(du);
>> +}
>> +
>> +static void delayed_uprobe_remove(struct uprobe *uprobe, struct mm_struct *mm)
>> +{
>> +       struct list_head *pos, *q;
>> +       struct delayed_uprobe *du;
>> +
>> +       if (!uprobe && !mm)
>> +               return;
>> +
>> +       list_for_each_safe(pos, q, &delayed_uprobe_list) {
>> +               du = list_entry(pos, struct delayed_uprobe, list);
>> +
>> +               if (uprobe && du->uprobe != uprobe)
>> +                       continue;
>> +               if (mm && du->mm != mm)
>> +                       continue;
>> +
>> +               delayed_uprobe_delete(du);
>> +       }
>> +}
>> +
>> +static bool valid_ref_ctr_vma(struct uprobe *uprobe,
>> +                             struct vm_area_struct *vma)
>> +{
>> +       unsigned long vaddr = offset_to_vaddr(vma, uprobe->ref_ctr_offset);
>> +
>> +       return uprobe->ref_ctr_offset &&
>> +               vma->vm_file &&
>> +               file_inode(vma->vm_file) == uprobe->inode &&
>> +               (vma->vm_flags & (VM_WRITE|VM_SHARED)) == VM_WRITE &&
>> +               vma->vm_start <= vaddr &&
>> +               vma->vm_end > vaddr;
>> +}
>> +
>> +static struct vm_area_struct *
>> +find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
>> +{
>> +       struct vm_area_struct *tmp;
>> +
>> +       for (tmp = mm->mmap; tmp; tmp = tmp->vm_next)
>> +               if (valid_ref_ctr_vma(uprobe, tmp))
>> +                       return tmp;
>> +
>> +       return NULL;
>> +}
>> +
>> +static int
>> +__update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
>> +{
>> +       void *kaddr;
>> +       struct page *page;
>> +       struct vm_area_struct *vma;
>> +       int ret;
>> +       short *ptr;
>> +
>> +       if (!vaddr || !d)
>> +               return -EINVAL;
>> +
>> +       ret = get_user_pages_remote(NULL, mm, vaddr, 1,
>> +                       FOLL_WRITE, &page, &vma, NULL);
>> +       if (unlikely(ret <= 0)) {
>> +               /*
>> +                * We are asking for 1 page. If get_user_pages_remote() fails,
>> +                * it may return 0, in that case we have to return error.
>> +                */
>> +               return ret == 0 ? -EBUSY : ret;
>> +       }
>> +
>> +       kaddr = kmap_atomic(page);
>> +       ptr = kaddr + (vaddr & ~PAGE_MASK);
>> +
>> +       if (unlikely(*ptr + d < 0)) {
>> +               pr_warn("ref_ctr going negative. vaddr: 0x%lx, "
>> +                       "curr val: %d, delta: %d\n", vaddr, *ptr, d);
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       *ptr += d;
>> +       ret = 0;
>> +out:
>> +       kunmap_atomic(kaddr);
>> +       put_page(page);
>> +       return ret;
>> +}
>> +
>> +static void update_ref_ctr_warn(struct uprobe *uprobe,
>> +                               struct mm_struct *mm, short d)
>> +{
>> +       pr_warn("ref_ctr %s failed for inode: 0x%lx offset: "
>> +               "0x%llx ref_ctr_offset: 0x%llx of mm: 0x%pK\n",
>> +               d > 0 ? "increment" : "decrement", uprobe->inode->i_ino,
>> +               (unsigned long long) uprobe->offset,
>> +               (unsigned long long) uprobe->ref_ctr_offset, mm);
>> +}
>> +
>> +static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
>> +                         short d)
>> +{
>> +       struct vm_area_struct *rc_vma;
>> +       unsigned long rc_vaddr;
>> +       int ret = 0;
>> +
>> +       rc_vma = find_ref_ctr_vma(uprobe, mm);
>> +
>> +       if (rc_vma) {
>> +               rc_vaddr = offset_to_vaddr(rc_vma, uprobe->ref_ctr_offset);
>> +               ret = __update_ref_ctr(mm, rc_vaddr, d);
>> +               if (ret)
>> +                       update_ref_ctr_warn(uprobe, mm, d);
>> +
>> +               if (d > 0)
>> +                       return ret;
>> +       }
>> +
>> +       mutex_lock(&delayed_uprobe_lock);
>> +       if (d > 0)
>> +               ret = delayed_uprobe_add(uprobe, mm);
>> +       else
>> +               delayed_uprobe_remove(uprobe, mm);
>> +       mutex_unlock(&delayed_uprobe_lock);
>> +
>> +       return ret;
>> +}
>> +
>>  /*
>>   * NOTE:
>>   * Expect the breakpoint instruction to be the smallest size instruction for
>> @@ -302,9 +472,13 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
>>  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>>                         unsigned long vaddr, uprobe_opcode_t opcode)
>>  {
>> +       struct uprobe *uprobe;
>>         struct page *old_page, *new_page;
>>         struct vm_area_struct *vma;
>> -       int ret;
>> +       int ret, is_register, ref_ctr_updated = 0;
>> +
>> +       is_register = is_swbp_insn(&opcode);
>> +       uprobe = container_of(auprobe, struct uprobe, arch);
>>
>>  retry:
>>         /* Read the page with vaddr into memory */
>> @@ -317,6 +491,15 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>>         if (ret <= 0)
>>                 goto put_old;
>>
>> +       /* We are going to replace instruction, update ref_ctr. */
>> +       if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
>> +               ret = update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
>> +               if (ret)
>> +                       goto put_old;
>> +
>> +               ref_ctr_updated = 1;
>> +       }
>> +
>>         ret = anon_vma_prepare(vma);
>>         if (ret)
>>                 goto put_old;
>> @@ -337,6 +520,11 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>>
>>         if (unlikely(ret == -EAGAIN))
>>                 goto retry;
>> +
>> +       /* Revert back reference counter if instruction update failed. */
>> +       if (ret && is_register && ref_ctr_updated)
>> +               update_ref_ctr(uprobe, mm, -1);
>> +
>>         return ret;
>>  }
>>
>> @@ -378,8 +566,15 @@ static struct uprobe *get_uprobe(struct uprobe *uprobe)
>>
>>  static void put_uprobe(struct uprobe *uprobe)
>>  {
>> -       if (atomic_dec_and_test(&uprobe->ref))
>> +       if (atomic_dec_and_test(&uprobe->ref)) {
>> +               /*
>> +                * If application munmap(exec_vma) before uprobe_unregister()
>> +                * gets called, we don't get a chance to remove uprobe from
>> +                * delayed_uprobe_list from remove_breakpoint(). Do it here.
>> +                */
>> +               delayed_uprobe_remove(uprobe, NULL);
>>                 kfree(uprobe);
>> +       }
>>  }
>>
>>  static int match_uprobe(struct uprobe *l, struct uprobe *r)
>> @@ -484,7 +679,8 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
>>         return u;
>>  }
>>
>> -static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
>> +static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>> +                                  loff_t ref_ctr_offset)
>>  {
>>         struct uprobe *uprobe, *cur_uprobe;
>>
>> @@ -494,6 +690,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
>>
>>         uprobe->inode = inode;
>>         uprobe->offset = offset;
>> +       uprobe->ref_ctr_offset = ref_ctr_offset;
>>         init_rwsem(&uprobe->register_rwsem);
>>         init_rwsem(&uprobe->consumer_rwsem);
>>
>> @@ -895,7 +1092,7 @@ EXPORT_SYMBOL_GPL(uprobe_unregister);
>>   * else return 0 (success)
>>   */
>>  static int __uprobe_register(struct inode *inode, loff_t offset,
>> -                            struct uprobe_consumer *uc)
>> +                            loff_t ref_ctr_offset, struct uprobe_consumer *uc)
>>  {
>>         struct uprobe *uprobe;
>>         int ret;
>> @@ -912,7 +1109,7 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
>>                 return -EINVAL;
>>
>>   retry:
>> -       uprobe = alloc_uprobe(inode, offset);
>> +       uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
>>         if (!uprobe)
>>                 return -ENOMEM;
>>         /*
>> @@ -938,10 +1135,17 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
>>  int uprobe_register(struct inode *inode, loff_t offset,
>>                     struct uprobe_consumer *uc)
>>  {
>> -       return __uprobe_register(inode, offset, uc);
>> +       return __uprobe_register(inode, offset, 0, uc);
>>  }
>>  EXPORT_SYMBOL_GPL(uprobe_register);
>>
>> +int uprobe_register_refctr(struct inode *inode, loff_t offset,
>> +                          loff_t ref_ctr_offset, struct uprobe_consumer *uc)
>> +{
>> +       return __uprobe_register(inode, offset, ref_ctr_offset, uc);
>> +}
>> +EXPORT_SYMBOL_GPL(uprobe_register_refctr);
>> +
>>  /*
>>   * uprobe_apply - unregister a already registered probe.
>>   * @inode: the file in which the probe has to be removed.
>> @@ -1060,6 +1264,35 @@ static void build_probe_list(struct inode *inode,
>>         spin_unlock(&uprobes_treelock);
>>  }
>>
>> +/* @vma contains reference counter, not the probed instruction. */
>> +static int delayed_ref_ctr_inc(struct vm_area_struct *vma)
>> +{
>> +       struct list_head *pos, *q;
>> +       struct delayed_uprobe *du;
>> +       unsigned long vaddr;
>> +       int ret = 0, err = 0;
>> +
>> +       mutex_lock(&delayed_uprobe_lock);
>> +       list_for_each_safe(pos, q, &delayed_uprobe_list) {
>> +               du = list_entry(pos, struct delayed_uprobe, list);
>> +
>> +               if (du->mm != vma->vm_mm ||
>> +                   !valid_ref_ctr_vma(du->uprobe, vma))
>> +                       continue;
>> +
>> +               vaddr = offset_to_vaddr(vma, du->uprobe->ref_ctr_offset);
>> +               ret = __update_ref_ctr(vma->vm_mm, vaddr, 1);
>> +               if (ret) {
>> +                       update_ref_ctr_warn(du->uprobe, vma->vm_mm, 1);
>> +                       if (!err)
>> +                               err = ret;
>> +               }
>> +               delayed_uprobe_delete(du);
>> +       }
>> +       mutex_unlock(&delayed_uprobe_lock);
>> +       return err;
>> +}
>> +
>>  /*
>>   * Called from mmap_region/vma_adjust with mm->mmap_sem acquired.
>>   *
>> @@ -1072,7 +1305,15 @@ int uprobe_mmap(struct vm_area_struct *vma)
>>         struct uprobe *uprobe, *u;
>>         struct inode *inode;
>>
>> -       if (no_uprobe_events() || !valid_vma(vma, true))
>> +       if (no_uprobe_events())
>> +               return 0;
>> +
>> +       if (vma->vm_file &&
>> +           (vma->vm_flags & (VM_WRITE|VM_SHARED)) == VM_WRITE &&
>> +           test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags))
>> +               delayed_ref_ctr_inc(vma);
>> +
>> +       if (!valid_vma(vma, true))
>>                 return 0;
>>
>>         inode = file_inode(vma->vm_file);
>> @@ -1246,6 +1487,10 @@ void uprobe_clear_state(struct mm_struct *mm)
>>  {
>>         struct xol_area *area = mm->uprobes_state.xol_area;
>>
>> +       mutex_lock(&delayed_uprobe_lock);
>> +       delayed_uprobe_remove(NULL, mm);
>> +       mutex_unlock(&delayed_uprobe_lock);
>> +
>>         if (!area)
>>                 return;
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 2dad27809794..23689831f656 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -4620,7 +4620,7 @@ static const char readme_msg[] =
>>    "place (kretprobe): [<module>:]<symbol>[+<offset>]|<memaddr>\n"
>>  #endif
>>  #ifdef CONFIG_UPROBE_EVENTS
>> -       "\t    place: <path>:<offset>\n"
>> +  "   place (uprobe): <path>:<offset>[(ref_ctr_offset)]\n"
>>  #endif
>>         "\t     args: <name>=fetcharg[:type]\n"
>>         "\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
>> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
>> index ac02fafc9f1b..a7ef6c4ca16e 100644
>> --- a/kernel/trace/trace_uprobe.c
>> +++ b/kernel/trace/trace_uprobe.c
>> @@ -59,6 +59,7 @@ struct trace_uprobe {
>>         struct inode                    *inode;
>>         char                            *filename;
>>         unsigned long                   offset;
>> +       unsigned long                   ref_ctr_offset;
>>         unsigned long                   nhit;
>>         struct trace_probe              tp;
>>  };
>> @@ -364,10 +365,10 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
>>  static int create_trace_uprobe(int argc, char **argv)
>>  {
>>         struct trace_uprobe *tu;
>> -       char *arg, *event, *group, *filename;
>> +       char *arg, *event, *group, *filename, *rctr, *rctr_end;
>>         char buf[MAX_EVENT_NAME_LEN];
>>         struct path path;
>> -       unsigned long offset;
>> +       unsigned long offset, ref_ctr_offset;
>>         bool is_delete, is_return;
>>         int i, ret;
>>
>> @@ -376,6 +377,7 @@ static int create_trace_uprobe(int argc, char **argv)
>>         is_return = false;
>>         event = NULL;
>>         group = NULL;
>> +       ref_ctr_offset = 0;
>>
>>         /* argc must be >= 1 */
>>         if (argv[0][0] == '-')
>> @@ -450,6 +452,26 @@ static int create_trace_uprobe(int argc, char **argv)
>>                 goto fail_address_parse;
>>         }
>>
>> +       /* Parse reference counter offset if specified. */
>> +       rctr = strchr(arg, '(');
>> +       if (rctr) {
>> +               rctr_end = strchr(rctr, ')');
>> +               if (rctr > rctr_end || *(rctr_end + 1) != 0) {
>> +                       ret = -EINVAL;
>> +                       pr_info("Invalid reference counter offset.\n");
>> +                       goto fail_address_parse;
>> +               }
>> +
>> +               *rctr++ = '\0';
>> +               *rctr_end = '\0';
>> +               ret = kstrtoul(rctr, 0, &ref_ctr_offset);
>> +               if (ret) {
>> +                       pr_info("Invalid reference counter offset.\n");
>> +                       goto fail_address_parse;
>> +               }
>> +       }
>> +
>> +       /* Parse uprobe offset. */
>>         ret = kstrtoul(arg, 0, &offset);
>>         if (ret)
>>                 goto fail_address_parse;
>> @@ -484,6 +506,7 @@ static int create_trace_uprobe(int argc, char **argv)
>>                 goto fail_address_parse;
>>         }
>>         tu->offset = offset;
>> +       tu->ref_ctr_offset = ref_ctr_offset;
>>         tu->path = path;
>>         tu->filename = kstrdup(filename, GFP_KERNEL);
>>
>> @@ -602,6 +625,9 @@ static int probes_seq_show(struct seq_file *m, void *v)
>>                         trace_event_name(&tu->tp.call), tu->filename,
>>                         (int)(sizeof(void *) * 2), tu->offset);
>>
>> +       if (tu->ref_ctr_offset)
>> +               seq_printf(m, "(0x%lx)", tu->ref_ctr_offset);
>> +
>>         for (i = 0; i < tu->tp.nr_args; i++)
>>                 seq_printf(m, " %s=%s", tu->tp.args[i].name, tu->tp.args[i].comm);
>>
>> @@ -917,7 +943,13 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
>>
>>         tu->consumer.filter = filter;
>>         tu->inode = d_real_inode(tu->path.dentry);
>> -       ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
>> +       if (tu->ref_ctr_offset) {
>> +               ret = uprobe_register_refctr(tu->inode, tu->offset,
>> +                               tu->ref_ctr_offset, &tu->consumer);
>> +       } else {
>> +               ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
>> +       }
>> +
>>         if (ret)
>>                 goto err_buffer;
>>
>> --
>> 2.14.4
>>
