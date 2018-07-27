Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2018 15:55:43 +0200 (CEST)
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992492AbeG0NzjjgHcF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jul 2018 15:55:39 +0200
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D6E940216E7;
        Fri, 27 Jul 2018 13:55:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id F0E221102E29;
        Fri, 27 Jul 2018 13:55:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 27 Jul 2018 15:55:33 +0200 (CEST)
Date:   Fri, 27 Jul 2018 15:55:29 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v6 5/6] Uprobes/sdt: Prevent multiple reference counter
 for same uprobe
Message-ID: <20180727135528.GA3618@redhat.com>
References: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
 <20180716084706.28244-6-ravi.bangoria@linux.ibm.com>
 <20180725110802.GA27325@redhat.com>
 <19d8abb0-44a3-cb26-405d-95f63fc01517@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d8abb0-44a3-cb26-405d-95f63fc01517@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 27 Jul 2018 13:55:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 27 Jul 2018 13:55:33 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65203
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

Hi Ravi,

On 07/27, Ravi Bangoria wrote:
>
> > I simply can't understand this "bool installed"....
>
>
> That boolean is needed because consumer_filter() returns false when this
> function gets called first time from uprobe_register().

Ah yes, I forgot about the (ugly) 2-stage TRACE_REG_PERF_REGISTER +
TRACE_REG_PERF_OPEN logic...

But then I think the whole idea of REF_CTR_OFF_RELOADED is even more broken.
Nevermind.

> I have a solution for this. Idea is, if reference counter is reloaded, save
> of all mms for which consumer_filter() denied to updated when being called
> from register_for_each_vma(). Use this list of mms as checklist next time
> onwards. I don't know if it's good to do that or not.

Sounds horrible ;) and I bet this is not enough.

> Please let me know if you have any better approach.

Just drop this patch.

If we can't make it per consumer, let it be global like it was in first version.

Oleg.
