Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 16:22:08 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:43792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993981AbeGXOWEXoGV0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 16:22:04 +0200
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D377920856;
        Tue, 24 Jul 2018 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532442117;
        bh=09ZGqof5HX0SojLo2neT/tl59bx5LFxVgotxGF4O9rs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bdIXiBmlLVruQG1CHQVEusp9t8YuSwW97KfndhB537TK1IOVORqSKEd2UO6+neQtQ
         FbnFzB0ntXTfvMNAd8wntKN3RMY/5FVx1DjRsFBxTi/810a9cOQ1aFh+D20GJdKCTA
         e0wWtFEx6RgjyB549X6SucX8lHh72ZF170bvBJJ0=
Date:   Tue, 24 Jul 2018 23:21:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     srikar@linux.vnet.ibm.com, oleg@redhat.com, rostedt@goodmis.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v6 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
Message-Id: <20180724232152.3579ab9379ede04f410d315f@kernel.org>
In-Reply-To: <20180716084706.28244-4-ravi.bangoria@linux.ibm.com>
References: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
        <20180716084706.28244-4-ravi.bangoria@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mhiramat@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhiramat@kernel.org
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

Hi Ravi,

Thank you for updating the series. At least trace_uprobe side,
it looks good to me ;)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

On Mon, 16 Jul 2018 14:17:03 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> Userspace Statically Defined Tracepoints[1] are dtrace style markers
> inside userspace applications. Applications like PostgreSQL, MySQL,
> Pthread, Perl, Python, Java, Ruby, Node.js, libvirt, QEMU, glib etc
> have these markers embedded in them. These markers are added by developer
> at important places in the code. Each marker source expands to a single
> nop instruction in the compiled code but there may be additional
> overhead for computing the marker arguments which expands to couple of
> instructions. In case the overhead is more, execution of it can be
> omitted by runtime if() condition when no one is tracing on the marker:
> 
>     if (reference_counter > 0) {
>         Execute marker instructions;
>     }
> 
> Default value of reference counter is 0. Tracer has to increment the
> reference counter before tracing on a marker and decrement it when
> done with the tracing.
> 
> Implement the reference counter logic in core uprobe. User will be
> able to use it from trace_uprobe as well as from kernel module. New
> trace_uprobe definition with reference counter will now be:
> 
>     <path>:<offset>[(ref_ctr_offset)]
> 
> where ref_ctr_offset is an optional field. For kernel module, new
> variant of uprobe_register() has been introduced:
> 
>     uprobe_register_refctr(inode, offset, ref_ctr_offset, consumer)
> 
> No new variant for uprobe_unregister() because it's assumed to have
> only one reference counter for one uprobe.
> 
> [1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
> 
> Note: 'reference counter' is called as 'semaphore' in original Dtrace
> (or Systemtap, bcc and even in ELF) documentation and code. But the
> term 'semaphore' is misleading in this context. This is just a counter
> used to hold number of tracers tracing on a marker. This is not really
> used for any synchronization. So we are referring it as 'reference
> counter' in kernel / perf code.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  include/linux/uprobes.h     |   5 +
>  kernel/events/uprobes.c     | 232 ++++++++++++++++++++++++++++++++++++++++++--
>  kernel/trace/trace.c        |   2 +-
>  kernel/trace/trace_uprobe.c |  38 +++++++-
>  4 files changed, 267 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index bb9d2084af03..103a48a48872 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -123,6 +123,7 @@ extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
>  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
>  extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
>  extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
> +extern int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
>  extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
>  extern int uprobe_mmap(struct vm_area_struct *vma);
> @@ -160,6 +161,10 @@ uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
>  {
>  	return -ENOSYS;
>  }
> +static inline int uprobe_register_refctr(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc)
> +{
> +	return -ENOSYS;
> +}
>  static inline int
>  uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool add)
>  {
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index c0418ba52ba8..84da8512a974 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -73,6 +73,7 @@ struct uprobe {
>  	struct uprobe_consumer	*consumers;
>  	struct inode		*inode;		/* Also hold a ref to inode */
>  	loff_t			offset;
> +	loff_t			ref_ctr_offset;
>  	unsigned long		flags;
>  
>  	/*
> @@ -88,6 +89,15 @@ struct uprobe {
>  	struct arch_uprobe	arch;
>  };
>  
> +struct delayed_uprobe {
> +	struct list_head list;
> +	struct uprobe *uprobe;
> +	struct mm_struct *mm;
> +};
> +
> +static DEFINE_MUTEX(delayed_uprobe_lock);
> +static LIST_HEAD(delayed_uprobe_list);
> +
>  /*
>   * Execute out of line area: anonymous executable mapping installed
>   * by the probed task to execute the copy of the original instruction
> @@ -282,6 +292,154 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
>  	return 1;
>  }
>  
> +static struct delayed_uprobe *
> +delayed_uprobe_check(struct uprobe *uprobe, struct mm_struct *mm)
> +{
> +	struct delayed_uprobe *du;
> +
> +	list_for_each_entry(du, &delayed_uprobe_list, list)
> +		if (du->uprobe == uprobe && du->mm == mm)
> +			return du;
> +	return NULL;
> +}
> +
> +static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
> +{
> +	struct delayed_uprobe *du;
> +
> +	if (delayed_uprobe_check(uprobe, mm))
> +		return 0;
> +
> +	du  = kzalloc(sizeof(*du), GFP_KERNEL);
> +	if (!du)
> +		return -ENOMEM;
> +
> +	du->uprobe = uprobe;
> +	du->mm = mm;
> +	list_add(&du->list, &delayed_uprobe_list);
> +	return 0;
> +}
> +
> +static void delayed_uprobe_delete(struct delayed_uprobe *du)
> +{
> +	if (!du)
> +		return;
> +	list_del(&du->list);
> +	kfree(du);
> +}
> +
> +static void delayed_uprobe_remove(struct uprobe *uprobe, struct mm_struct *mm)
> +{
> +	struct list_head *pos, *q;
> +	struct delayed_uprobe *du;
> +
> +	list_for_each_safe(pos, q, &delayed_uprobe_list) {
> +		du = list_entry(pos, struct delayed_uprobe, list);
> +		if (uprobe) {
> +			if (du->uprobe == uprobe && du->mm == mm)
> +				delayed_uprobe_delete(du);
> +		} else if (du->mm == mm) {
> +			delayed_uprobe_delete(du);
> +		}
> +	}
> +}
> +
> +static bool valid_ref_ctr_vma(struct uprobe *uprobe,
> +			      struct vm_area_struct *vma)
> +{
> +	unsigned long vaddr = offset_to_vaddr(vma, uprobe->ref_ctr_offset);
> +
> +	return uprobe->ref_ctr_offset &&
> +		vma->vm_file &&
> +		file_inode(vma->vm_file) == uprobe->inode &&
> +		vma->vm_flags & VM_WRITE &&
> +		!(vma->vm_flags & VM_SHARED) &&
> +		vma->vm_start <= vaddr &&
> +		vma->vm_end > vaddr;
> +}
> +
> +static struct vm_area_struct *
> +find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
> +{
> +	struct vm_area_struct *tmp;
> +
> +	for (tmp = mm->mmap; tmp; tmp = tmp->vm_next)
> +		if (valid_ref_ctr_vma(uprobe, tmp))
> +			return tmp;
> +
> +	return NULL;
> +}
> +
> +static int
> +__update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
> +{
> +	void *kaddr;
> +	struct page *page;
> +	struct vm_area_struct *vma;
> +	int ret = 0;
> +	short *ptr;
> +
> +	if (vaddr == 0 || d == 0)
> +		return -EINVAL;
> +
> +	ret = get_user_pages_remote(NULL, mm, vaddr, 1,
> +			FOLL_WRITE, &page, &vma, NULL);
> +	if (unlikely(ret <= 0)) {
> +		/*
> +		 * We are asking for 1 page. If get_user_pages_remote() fails,
> +		 * it may return 0, in that case we have to return error.
> +		 */
> +		ret = (ret == 0) ? -EBUSY : ret;
> +		pr_warn("Failed to %s ref_ctr. (%d)\n",
> +			d > 0 ? "increment" : "decrement", ret);
> +		return ret;
> +	}
> +
> +	kaddr = kmap_atomic(page);
> +	ptr = kaddr + (vaddr & ~PAGE_MASK);
> +
> +	if (unlikely(*ptr + d < 0)) {
> +		pr_warn("ref_ctr going negative. vaddr: 0x%lx, "
> +			"curr val: %d, delta: %d\n", vaddr, *ptr, d);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	*ptr += d;
> +	ret = 0;
> +out:
> +	kunmap_atomic(kaddr);
> +	put_page(page);
> +	return ret;
> +}
> +
> +static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
> +			  bool is_register)
> +{
> +	struct vm_area_struct *rc_vma;
> +	unsigned long rc_vaddr;
> +	int ret = 0;
> +
> +	rc_vma = find_ref_ctr_vma(uprobe, mm);
> +
> +	if (rc_vma) {
> +		rc_vaddr = offset_to_vaddr(rc_vma, uprobe->ref_ctr_offset);
> +		ret = __update_ref_ctr(mm, rc_vaddr, is_register ? 1 : -1);
> +
> +		if (is_register)
> +			return ret;
> +	}
> +
> +	mutex_lock(&delayed_uprobe_lock);
> +	if (is_register)
> +		ret = delayed_uprobe_add(uprobe, mm);
> +	else
> +		delayed_uprobe_remove(uprobe, mm);
> +	mutex_unlock(&delayed_uprobe_lock);
> +
> +	return ret;
> +}
> +
>  /*
>   * NOTE:
>   * Expect the breakpoint instruction to be the smallest size instruction for
> @@ -302,9 +460,13 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
>  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  			unsigned long vaddr, uprobe_opcode_t opcode)
>  {
> +	struct uprobe *uprobe;
>  	struct page *old_page, *new_page;
>  	struct vm_area_struct *vma;
> -	int ret;
> +	int ret, is_register, ref_ctr_updated = 0;
> +
> +	is_register = is_swbp_insn(&opcode);
> +	uprobe = container_of(auprobe, struct uprobe, arch);
>  
>  retry:
>  	/* Read the page with vaddr into memory */
> @@ -317,6 +479,15 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  	if (ret <= 0)
>  		goto put_old;
>  
> +	/* We are going to replace instruction, update ref_ctr. */
> +	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
> +		ret = update_ref_ctr(uprobe, mm, is_register);
> +		if (ret)
> +			goto put_old;
> +
> +		ref_ctr_updated = 1;
> +	}
> +
>  	ret = anon_vma_prepare(vma);
>  	if (ret)
>  		goto put_old;
> @@ -337,6 +508,11 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  
>  	if (unlikely(ret == -EAGAIN))
>  		goto retry;
> +
> +	/* Revert back reference counter if instruction update failed. */
> +	if (ret && is_register && ref_ctr_updated)
> +		update_ref_ctr(uprobe, mm, false);
> +
>  	return ret;
>  }
>  
> @@ -484,7 +660,8 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
>  	return u;
>  }
>  
> -static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
> +static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
> +				   loff_t ref_ctr_offset)
>  {
>  	struct uprobe *uprobe, *cur_uprobe;
>  
> @@ -494,6 +671,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset)
>  
>  	uprobe->inode = inode;
>  	uprobe->offset = offset;
> +	uprobe->ref_ctr_offset = ref_ctr_offset;
>  	init_rwsem(&uprobe->register_rwsem);
>  	init_rwsem(&uprobe->consumer_rwsem);
>  
> @@ -895,7 +1073,7 @@ EXPORT_SYMBOL_GPL(uprobe_unregister);
>   * else return 0 (success)
>   */
>  static int __uprobe_register(struct inode *inode, loff_t offset,
> -			     struct uprobe_consumer *uc)
> +			     loff_t ref_ctr_offset, struct uprobe_consumer *uc)
>  {
>  	struct uprobe *uprobe;
>  	int ret;
> @@ -912,7 +1090,7 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
>  		return -EINVAL;
>  
>   retry:
> -	uprobe = alloc_uprobe(inode, offset);
> +	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
>  	if (!uprobe)
>  		return -ENOMEM;
>  	/*
> @@ -938,10 +1116,17 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
>  int uprobe_register(struct inode *inode, loff_t offset,
>  		    struct uprobe_consumer *uc)
>  {
> -	return __uprobe_register(inode, offset, uc);
> +	return __uprobe_register(inode, offset, 0, uc);
>  }
>  EXPORT_SYMBOL_GPL(uprobe_register);
>  
> +int uprobe_register_refctr(struct inode *inode, loff_t offset,
> +			   loff_t ref_ctr_offset, struct uprobe_consumer *uc)
> +{
> +	return __uprobe_register(inode, offset, ref_ctr_offset, uc);
> +}
> +EXPORT_SYMBOL_GPL(uprobe_register_refctr);
> +
>  /*
>   * uprobe_apply - unregister a already registered probe.
>   * @inode: the file in which the probe has to be removed.
> @@ -1060,6 +1245,31 @@ static void build_probe_list(struct inode *inode,
>  	spin_unlock(&uprobes_treelock);
>  }
>  
> +static int delayed_uprobe_install(struct vm_area_struct *vma)
> +{
> +	struct list_head *pos, *q;
> +	struct delayed_uprobe *du;
> +	unsigned long vaddr;
> +	int ret = 0, err = 0;
> +
> +	mutex_lock(&delayed_uprobe_lock);
> +	list_for_each_safe(pos, q, &delayed_uprobe_list) {
> +		du = list_entry(pos, struct delayed_uprobe, list);
> +
> +		if (!du->uprobe->ref_ctr_offset ||
> +		    !valid_ref_ctr_vma(du->uprobe, vma))
> +			continue;
> +
> +		vaddr = offset_to_vaddr(vma, du->uprobe->ref_ctr_offset);
> +		ret = __update_ref_ctr(vma->vm_mm, vaddr, 1);
> +		/* Record an error and continue. */
> +		err = ret & !err ? ret : err;
> +		delayed_uprobe_delete(du);
> +	}
> +	mutex_unlock(&delayed_uprobe_lock);
> +	return err;
> +}
> +
>  /*
>   * Called from mmap_region/vma_adjust with mm->mmap_sem acquired.
>   *
> @@ -1072,7 +1282,13 @@ int uprobe_mmap(struct vm_area_struct *vma)
>  	struct uprobe *uprobe, *u;
>  	struct inode *inode;
>  
> -	if (no_uprobe_events() || !valid_vma(vma, true))
> +	if (no_uprobe_events())
> +		return 0;
> +
> +	if (vma->vm_flags & VM_WRITE)
> +		delayed_uprobe_install(vma);
> +
> +	if (!valid_vma(vma, true))
>  		return 0;
>  
>  	inode = file_inode(vma->vm_file);
> @@ -1246,6 +1462,10 @@ void uprobe_clear_state(struct mm_struct *mm)
>  {
>  	struct xol_area *area = mm->uprobes_state.xol_area;
>  
> +	mutex_lock(&delayed_uprobe_lock);
> +	delayed_uprobe_remove(NULL, mm);
> +	mutex_unlock(&delayed_uprobe_lock);
> +
>  	if (!area)
>  		return;
>  
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index f054bd6a1c66..b431790779f7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4614,7 +4614,7 @@ static const char readme_msg[] =
>    "place (kretprobe): [<module>:]<symbol>[+<offset>]|<memaddr>\n"
>  #endif
>  #ifdef CONFIG_UPROBE_EVENTS
> -	"\t    place: <path>:<offset>\n"
> +  "   place (uprobe): <path>:<offset>[(ref_ctr_offset)]\n"
>  #endif
>  	"\t     args: <name>=fetcharg[:type]\n"
>  	"\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index bf89a51e740d..bf2be098eb08 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -59,6 +59,7 @@ struct trace_uprobe {
>  	struct inode			*inode;
>  	char				*filename;
>  	unsigned long			offset;
> +	unsigned long			ref_ctr_offset;
>  	unsigned long			nhit;
>  	struct trace_probe		tp;
>  };
> @@ -364,10 +365,10 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
>  static int create_trace_uprobe(int argc, char **argv)
>  {
>  	struct trace_uprobe *tu;
> -	char *arg, *event, *group, *filename;
> +	char *arg, *event, *group, *filename, *rctr, *rctr_end;
>  	char buf[MAX_EVENT_NAME_LEN];
>  	struct path path;
> -	unsigned long offset;
> +	unsigned long offset, ref_ctr_offset;
>  	bool is_delete, is_return;
>  	int i, ret;
>  
> @@ -376,6 +377,7 @@ static int create_trace_uprobe(int argc, char **argv)
>  	is_return = false;
>  	event = NULL;
>  	group = NULL;
> +	ref_ctr_offset = 0;
>  
>  	/* argc must be >= 1 */
>  	if (argv[0][0] == '-')
> @@ -450,6 +452,26 @@ static int create_trace_uprobe(int argc, char **argv)
>  		goto fail_address_parse;
>  	}
>  
> +	/* Parse reference counter offset if specified. */
> +	rctr = strchr(arg, '(');
> +	if (rctr) {
> +		rctr_end = strchr(rctr, ')');
> +		if (rctr > rctr_end || *(rctr_end + 1) != 0) {
> +			ret = -EINVAL;
> +			pr_info("Invalid reference counter offset.\n");
> +			goto fail_address_parse;
> +		}
> +
> +		*rctr++ = '\0';
> +		*rctr_end = '\0';
> +		ret = kstrtoul(rctr, 0, &ref_ctr_offset);
> +		if (ret) {
> +			pr_info("Invalid reference counter offset.\n");
> +			goto fail_address_parse;
> +		}
> +	}
> +
> +	/* Parse uprobe offset. */
>  	ret = kstrtoul(arg, 0, &offset);
>  	if (ret)
>  		goto fail_address_parse;
> @@ -484,6 +506,7 @@ static int create_trace_uprobe(int argc, char **argv)
>  		goto fail_address_parse;
>  	}
>  	tu->offset = offset;
> +	tu->ref_ctr_offset = ref_ctr_offset;
>  	tu->path = path;
>  	tu->filename = kstrdup(filename, GFP_KERNEL);
>  
> @@ -602,6 +625,9 @@ static int probes_seq_show(struct seq_file *m, void *v)
>  			trace_event_name(&tu->tp.call), tu->filename,
>  			(int)(sizeof(void *) * 2), tu->offset);
>  
> +	if (tu->ref_ctr_offset)
> +		seq_printf(m, "(0x%lx)", tu->ref_ctr_offset);
> +
>  	for (i = 0; i < tu->tp.nr_args; i++)
>  		seq_printf(m, " %s=%s", tu->tp.args[i].name, tu->tp.args[i].comm);
>  
> @@ -917,7 +943,13 @@ probe_event_enable(struct trace_uprobe *tu, struct trace_event_file *file,
>  
>  	tu->consumer.filter = filter;
>  	tu->inode = d_real_inode(tu->path.dentry);
> -	ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
> +	if (tu->ref_ctr_offset) {
> +		ret = uprobe_register_refctr(tu->inode, tu->offset,
> +				tu->ref_ctr_offset, &tu->consumer);
> +	} else {
> +		ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
> +	}
> +
>  	if (ret)
>  		goto err_buffer;
>  
> -- 
> 2.14.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
