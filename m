Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 13:17:35 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:52224 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903686Ab1KAMR3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2011 13:17:29 +0100
Received: by bkat2 with SMTP id t2so2161884bka.36
        for <linux-mips@linux-mips.org>; Tue, 01 Nov 2011 05:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=gLiyolbpNh0eZP671b/USfVcNUTt3pfPRozBCPazPlM=;
        b=b8cMxrcU+Yua4E4PyAUu0c5hoLDA8vHsQFAuJ/saEjRoEQZstimei94gic4LmVj+Vw
         jIoFZs/sjas7gEiMEXsuw5vDmvhB9fRzAaOfZlYwnNgdvOpAeKLgfD2QzlJA4XxdkXnL
         eGSDvGOOH4vWsVzgw+pHk05xOJddHoOF34bxc=
MIME-Version: 1.0
Received: by 10.204.130.153 with SMTP id t25mr14772184bks.11.1320149844263;
 Tue, 01 Nov 2011 05:17:24 -0700 (PDT)
Received: by 10.204.138.142 with HTTP; Tue, 1 Nov 2011 05:17:24 -0700 (PDT)
Date:   Tue, 1 Nov 2011 17:47:24 +0530
Message-ID: <CAGr+u+zkPiZpGefstcbJv_cj929icWKXbqFy1uR22Hns1hzFeQ@mail.gmail.com>
Subject: Issue with core dump
From:   trisha yad <trisha1march@gmail.com>
To:     linux-mm <linux-mm@kvack.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        kamezawa.hiroyu@jp.fujitsu.com, oleg@redhat.com, mhocko@suse.cz,
        rientjes@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Tejun Heo <htejun@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trisha1march@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 358

Dear all,

I am running a multithreaded  application. So consider a global
variable x which is used by a, b and c thread.

In thread 'a' do abnormal operation(invalid memory access) and kernel
send signal kill to it. In the mean time Thread 'b' and Thread 'c'
got schedule and update
the variable x. when I got the core file, variable x  got updated, and
I am not  getting actual value that is present at time of crash of
thread a.
But In core file I got updated value of x. I want In core file exact
the same memory status as it at time of abnormal operation(invalid
memory access)

Is there any solution for such problem. ?

I want in core dump the same status  of memory as at time of abnormal
operation(invalid memory access).

Thanks
