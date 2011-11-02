Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Nov 2011 12:31:45 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54017 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903946Ab1KBLbh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Nov 2011 12:31:37 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA2BUa1D014989;
        Wed, 2 Nov 2011 11:30:36 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA2BUV0T014982;
        Wed, 2 Nov 2011 11:30:31 GMT
Date:   Wed, 2 Nov 2011 11:30:31 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     trisha yad <trisha1march@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-mm <linux-mm@kvack.org>,
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
Message-ID: <20111102113030.GE22462@linux-mips.org>
References: <CAGr+u+zkPiZpGefstcbJv_cj929icWKXbqFy1uR22Hns1hzFeQ@mail.gmail.com>
 <20111101152320.GA30466@redhat.com>
 <CAGr+u+wgAYVWgdcG6o+6F0mDzuyNzoOxvsFwq0dMsR3JNnZ-cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr+u+wgAYVWgdcG6o+6F0mDzuyNzoOxvsFwq0dMsR3JNnZ-cA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1175

On Wed, Nov 02, 2011 at 12:03:39PM +0530, trisha yad wrote:

> Thanks all for your answer.
> 
> In loaded embedded system the time at with code hit do_user_fault()
> and core_dump_wait() is bit
> high, I check on my  system it took 2.7 sec. so it is very much
> possible that core dump is not correct.
> It  contain global value updated.
> 
> So is it possible at time of send_signal() we can stop modification of
> faulty thread memory ?

On existing hardware it is impossible to take a consistent snapshot of a
multi-threaded application at the time of one thread faulting.

A software simulator can handle this sort of race condition but of course
this approach has other disadvantages.

  Ralf
