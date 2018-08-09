Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 16:38:43 +0200 (CEST)
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994542AbeHIOiiy1Iot (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2018 16:38:38 +0200
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 713E640216EB;
        Thu,  9 Aug 2018 14:38:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id E80482026D66;
        Thu,  9 Aug 2018 14:38:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  9 Aug 2018 16:38:32 +0200 (CEST)
Date:   Thu, 9 Aug 2018 16:38:28 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, liu.song.a23@gmail.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180809143827.GC22636@redhat.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 09 Aug 2018 14:38:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 09 Aug 2018 14:38:32 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65496
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

I need to read this (hopefully final) version carefully. I'll try to do
this before next Monday.

just one note,

On 08/09, Ravi Bangoria wrote:
>
> +static void delayed_uprobe_remove(struct uprobe *uprobe, struct mm_struct *mm)
> +{
> +	struct list_head *pos, *q;
> +	struct delayed_uprobe *du;
> +
> +	if (!uprobe && !mm)
> +		return;
> +
> +	list_for_each_safe(pos, q, &delayed_uprobe_list) {
> +		du = list_entry(pos, struct delayed_uprobe, list);
> +
> +		if (uprobe && mm && du->uprobe == uprobe && du->mm == mm)
> +			delayed_uprobe_delete(du);
> +		else if (!uprobe && du->mm == mm)
> +			delayed_uprobe_delete(du);
> +		else if (!mm && du->uprobe == uprobe)
> +			delayed_uprobe_delete(du);
> +	}

Sorry, I can't resist... this doesn't look very nice. How about

	list_for_each_safe(pos, q, &delayed_uprobe_list) {
		du = list_entry(pos, struct delayed_uprobe, list);

		if (uprobe && du->uprobe != uprobe)
			continue;
		if (mm && du->mm != mm)
			continue;

		delayed_uprobe_delete();
	}

I won't insist, this is cosmetic after all, but please consider this change
in case you will need to send v9.

Oleg.
