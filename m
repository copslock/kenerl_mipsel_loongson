Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2018 13:23:41 +0200 (CEST)
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992869AbeHMLXgL03mu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Aug 2018 13:23:36 +0200
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50F3F818F02C;
        Mon, 13 Aug 2018 11:23:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id F06661006EAD;
        Mon, 13 Aug 2018 11:23:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 13 Aug 2018 13:23:29 +0200 (CEST)
Date:   Mon, 13 Aug 2018 13:23:25 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, rostedt@goodmis.org,
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
Message-ID: <20180813112324.GA28360@redhat.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
 <20180813100327.GF44470@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813100327.GF44470@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 13 Aug 2018 11:23:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 13 Aug 2018 11:23:29 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65561
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

On 08/13, Srikar Dronamraju wrote:
>
> > +
> > +static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
> > +{
> > +	struct delayed_uprobe *du;
> > +
> > +	if (delayed_uprobe_check(uprobe, mm))
> > +		return 0;
> > +
> > +	du = kzalloc(sizeof(*du), GFP_KERNEL);
> > +	if (!du)
> > +		return -ENOMEM;
> > +
> > +	du->uprobe = uprobe;
> > +	du->mm = mm;
> > +	list_add(&du->list, &delayed_uprobe_list);
> > +	return 0;
> > +}
> > +
>
> Should we keep the delayed uprobe list per mm?
> That way we could avoid the global mutex lock.
> And the list to traverse would also be small.

Plus uprobe_mmap() could simply check list_empty(mm->delayed_list) before
the costly delayed_uprobe_install().

Yes, I mentioned this too. But then I suggested to not do this in the initial
version to make it more simple.

Hopefully we can do this later, but note that this conflicts with the change
in put_uprobe() you commented below.

> >  static void put_uprobe(struct uprobe *uprobe)
> >  {
> > -	if (atomic_dec_and_test(&uprobe->ref))
> > +	if (atomic_dec_and_test(&uprobe->ref)) {
> > +		/*
> > +		 * If application munmap(exec_vma) before uprobe_unregister()
> > +		 * gets called, we don't get a chance to remove uprobe from
> > +		 * delayed_uprobe_list in remove_breakpoint(). Do it here.
> > +		 */
> > +		delayed_uprobe_remove(uprobe, NULL);
>
> I am not getting this part. If unmap happens before unregister,
> why cant we use uprobe_munmap?

How? I mean what exactly can we do in uprobe_munmap() ? Firstly, we will need
to restore build_probe_list/list_for_each_entry_safe(pending_list) in
uprobe_munmap() and this is not nice performance-wise. Then what?

We don't even know if the caller is actually munmap(), it can be vma_adjust()
and in the latter case we can't do delayed_uprobe_remove(uprobe, mm).

Perhaps we can use uprobe_munmap() to cleanup the delayed_uprobe_list, but this
doesn't look simple to me.

In fact I think that we should simply kill uprobe_munmap().

Oleg.
