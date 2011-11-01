Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 16:27:59 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:61954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901351Ab1KAP1z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Nov 2011 16:27:55 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pA1FRe1n000376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 1 Nov 2011 11:27:41 -0400
Received: from tranklukator.englab.brq.redhat.com (dhcp-1-232.brq.redhat.com [10.34.1.232])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id pA1FRaur024093;
        Tue, 1 Nov 2011 11:27:36 -0400
Received: by tranklukator.englab.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Tue,  1 Nov 2011 16:23:25 +0100 (CET)
Date:   Tue, 1 Nov 2011 16:23:20 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     trisha yad <trisha1march@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        kamezawa.hiroyu@jp.fujitsu.com, mhocko@suse.cz,
        rientjes@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Tejun Heo <htejun@gmail.com>
Subject: Re: Issue with core dump
Message-ID: <20111101152320.GA30466@redhat.com>
References: <CAGr+u+zkPiZpGefstcbJv_cj929icWKXbqFy1uR22Hns1hzFeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr+u+zkPiZpGefstcbJv_cj929icWKXbqFy1uR22Hns1hzFeQ@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-archive-position: 31338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 471

On 11/01, trisha yad wrote:
>
> Dear all,
>
> I am running a multithreaded  application. So consider a global
> variable x which is used by a, b and c thread.
>
> In thread 'a' do abnormal operation(invalid memory access) and kernel
> send signal kill to it. In the mean time Thread 'b' and Thread 'c'
> got schedule and update
> the variable x. when I got the core file, variable x  got updated, and
> I am not  getting actual value that is present at time of crash of
> thread a.
> But In core file I got updated value of x. I want In core file exact
> the same memory status as it at time of abnormal operation(invalid
> memory access)

Yes, this is possible.

> Is there any solution for such problem. ?
>
> I want in core dump the same status  of memory as at time of abnormal
> operation(invalid memory access).

I don't think we can "fix" this.

We can probably change complete_signal() to notify other threads
"immediately", but this is not simple and obviously can not close
the window completely.

Whatever we do, we can't "stop" other threads at the time when
thread 'a' traps. All we can do is to try to shrink the window.

Oleg.
