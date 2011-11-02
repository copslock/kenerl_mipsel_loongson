Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Nov 2011 16:59:57 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:15008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903953Ab1KBP7r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Nov 2011 16:59:47 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pA2FxR14017167
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 2 Nov 2011 11:59:27 -0400
Received: from tranklukator.englab.brq.redhat.com (dhcp-1-232.brq.redhat.com [10.34.1.232])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id pA2FxMmS013201;
        Wed, 2 Nov 2011 11:59:23 -0400
Received: by tranklukator.englab.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Wed,  2 Nov 2011 16:55:10 +0100 (CET)
Date:   Wed, 2 Nov 2011 16:55:05 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tejun Heo <htejun@gmail.com>
Cc:     trisha yad <trisha1march@gmail.com>, linux-mm <linux-mm@kvack.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        kamezawa.hiroyu@jp.fujitsu.com, mhocko@suse.cz,
        rientjes@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Issue with core dump
Message-ID: <20111102155505.GA30500@redhat.com>
References: <CAGr+u+zkPiZpGefstcbJv_cj929icWKXbqFy1uR22Hns1hzFeQ@mail.gmail.com> <20111101152320.GA30466@redhat.com> <CAGr+u+wgAYVWgdcG6o+6F0mDzuyNzoOxvsFwq0dMsR3JNnZ-cA@mail.gmail.com> <20111102153146.GC12543@dhcp-172-17-108-109.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111102153146.GC12543@dhcp-172-17-108-109.mtv.corp.google.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-archive-position: 31365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1405

On 11/02, Tejun Heo wrote:
>
> Also, the time between do_user_fault() and actual core dumping isn't
> the important factor here.  do_user_fault() directly triggers delivery
> of SIGSEGV (or BUS) and signal delivery will immediately deliver
> SIGKILL to all other threads in the process,

Not really, note the "if (!sig_kernel_coredump(sig))" check. And this
is what we can improve. But this is not simple, and personally I think
doesn't worth the trouble.

Oleg.
