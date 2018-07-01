Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Jul 2018 23:09:53 +0200 (CEST)
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990474AbeGAVJqN0HF2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 1 Jul 2018 23:09:46 +0200
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE99C7788C;
        Sun,  1 Jul 2018 21:09:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 682567C24;
        Sun,  1 Jul 2018 21:09:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sun,  1 Jul 2018 23:09:39 +0200 (CEST)
Date:   Sun, 1 Jul 2018 23:09:35 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180701210935.GA14404@redhat.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sun, 01 Jul 2018 21:09:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sun, 01 Jul 2018 21:09:40 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
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

On 06/28, Ravi Bangoria wrote:
>
> @@ -294,6 +462,15 @@ int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
>  	if (ret <= 0)
>  		goto put_old;
>  
> +	/* Update the ref_ctr if we are going to replace instruction. */
> +	if (!ref_ctr_updated) {
> +		ret = update_ref_ctr(uprobe, mm, is_register);
> +		if (ret)
> +			goto put_old;
> +
> +		ref_ctr_updated = 1;
> +	}

Why can't this code live in install_breakpoint() and remove_breakpoint() ?
this way we do not need to export "struct uprobe" and change set_swbp/set_orig_insn,
and the logic will be more simple.

And let me ask again... May be you have already explained this, but I can't
find the previous discussion.

So why do we need a counter but not a boolean? IIRC, because the counter can
be shared, in particular 2 different uprobes can have the same >ref_ctr_offset,
right?

But who else can use this counter and how? Say, can userspace update it too?
If yes, why this can't race with __update_ref_ctr() ?

And btw, why does __update_ref_ctr() use FOLL_FORCE? This vma should be writeable
or valid_ref_ctr_vma() should nack it?

And shouldn't valid_ref_ctr_vma() check VM_SHARED? IIUC we do not want to write
to this file?

Oleg.
