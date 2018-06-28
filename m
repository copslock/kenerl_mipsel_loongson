Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2018 21:51:26 +0200 (CEST)
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993852AbeF1TvTUJ4sm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jun 2018 21:51:19 +0200
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C38D6BF573;
        Thu, 28 Jun 2018 19:51:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 21E932026D69;
        Thu, 28 Jun 2018 19:51:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 28 Jun 2018 21:51:12 +0200 (CEST)
Date:   Thu, 28 Jun 2018 21:51:06 +0200
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
Message-ID: <20180628195106.GA3952@redhat.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 28 Jun 2018 19:51:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 28 Jun 2018 19:51:12 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64491
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

I have to admit that after a quick glance I can't understand this patch
at all... I'll try to read it again tomorrow, but could you at least explain
how find_node_in_range/build_probe_list can work if off_type==REF_CTR_OFFSET?

On 06/28, Ravi Bangoria wrote:
>
> -find_node_in_range(struct inode *inode, loff_t min, loff_t max)
> +find_node_in_range(struct inode *inode, int off_type, loff_t min, loff_t max)
>  {
>  	struct rb_node *n = uprobes_tree.rb_node;
>  
>  	while (n) {
>  		struct uprobe *u = rb_entry(n, struct uprobe, rb_node);
> +		loff_t offset = uprobe_get_offset(u, off_type);
>  
>  		if (inode < u->inode) {
>  			n = n->rb_left;
>  		} else if (inode > u->inode) {
>  			n = n->rb_right;
>  		} else {
> -			if (max < u->offset)
> +			if (max < offset)
>  				n = n->rb_left;
> -			else if (min > u->offset)
> +			else if (min > offset)
>  				n = n->rb_right;
>  			else
>  				break;

To simplify, lets forget about uprobe->inode (which acts as a key too). So uprobes_tree
is a binary tree sorted by uprobe->offset key and that is why the binary search works.

But it is not sorted by uprobe->ref_ctr_offset. So for example n->rb_left can have the
n->ref_ctr_offset key that is greater than the n's ref_ctr_offset. So how we can use the
binary search if REF_CTR_OFFSET?

I must have missed something, I assume you tested this patch and it works somehow...

Oleg.
