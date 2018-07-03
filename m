Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 19:13:13 +0200 (CEST)
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994583AbeGCRNGDknxy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jul 2018 19:13:06 +0200
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B780A401B3AA;
        Tue,  3 Jul 2018 17:12:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9E1F42156880;
        Tue,  3 Jul 2018 17:12:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  3 Jul 2018 19:12:59 +0200 (CEST)
Date:   Tue, 3 Jul 2018 19:12:56 +0200
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
Message-ID: <20180703171255.GB23144@redhat.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 03 Jul 2018 17:12:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 03 Jul 2018 17:12:59 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64581
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

On 07/03, Ravi Bangoria wrote:
>
> > OK, and how exactly they update the counter? I mean, can we assume that, say,
> > bcc or systemtap can only increment or decrement it?
>
> I don't think we can assume anything here because this is all in user's
> control. User can even manually go and update the counter by directly
> hooking into the memory.

Then how this all can work? I understand that user-space can do anything with
this counter, but we do not care if it does something wrong, say nullifies the
ctr incremented by kernel.

I don't understand this. I think that if a user registers uprobe with
->ref_ctr_offset != 0 we can safely assume that this is a counter, and we do
not care if userspace corrupts it.

> > If yes, perhaps we can simplify the kernel code...
>
> Sure, let me know if you have any better idea.

Can't we (ab)use the most significant bit in this counter?

To simplify, lets suppose for the moment that 2 different uprobes can't have
the same ->ref_ctr_offset. Then we can do something like

	#define UPROBE_KERN_CTR		(SHRT_MAX + 1)	// MSB

	install_breakpoint:

		for (each valid_ref_ctr_vma which maps uprobe->ref_ctr_offset)
			*ctr_ptr |= UPROBE_KERN_CTR;

		set_swbp();

and

	remove_breakpoint:

		for (each valid_ref_ctr_vma which maps uprobe->ref_ctr_offset)
			*ctr_ptr &= ~UPROBE_KERN_CTR;

		set_orig_insn();

IOW, we increment/decrement by UPROBE_KERN_CTR, not by 1. But this way the
"increment" is idempotent, we do not care if "|=" or "&=" was applied more than
once, we do not need to record the fact that the counter was already incremented,
and inc/dec are always balanced.


Now, lets recall that multiple uprobes can share the same counter. install_breakpoint()
is still fine, and we only need to add the additional code into remove_breakpoint:

		for (each uprobe with the same inode and ref_ctr_offset)
			if (filter_chain(uprobe))
				goto keep_ctr;

		for (each valid_ref_ctr_vma which maps uprobe->ref_ctr_offset)
			*ctr_ptr &= ~UPROBE_KERN_CTR;

	keep_ctr:
		set_orig_insn();
				

Just an idea.

What do you think?

Oleg.
