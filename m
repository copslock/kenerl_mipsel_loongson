Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Nov 2011 07:33:49 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:35736 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903804Ab1KBGdp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Nov 2011 07:33:45 +0100
Received: by bkat2 with SMTP id t2so3135931bka.36
        for <linux-mips@linux-mips.org>; Tue, 01 Nov 2011 23:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YhMy5nPx7TJqZmzE5+2SPyqpsF7AQsH7ubt4evHfz/Q=;
        b=GZGjt6XCVNZGY/OrlrHeo9E9QptYzamAwHim5ahDbsYIWlxQVKlVmlVzh64ti87paq
         dYFD3LsQMeVH92jDR+Eeib24JkW/Od+mzfzMyaJFkKiNrO4sawgu35bUhIeCGxM2HtYE
         0hmnx1NIMre2/TS0pOoi/og5QGDX+n+amME6w=
MIME-Version: 1.0
Received: by 10.204.141.88 with SMTP id l24mr2341627bku.37.1320215620018; Tue,
 01 Nov 2011 23:33:40 -0700 (PDT)
Received: by 10.204.138.142 with HTTP; Tue, 1 Nov 2011 23:33:39 -0700 (PDT)
In-Reply-To: <20111101152320.GA30466@redhat.com>
References: <CAGr+u+zkPiZpGefstcbJv_cj929icWKXbqFy1uR22Hns1hzFeQ@mail.gmail.com>
        <20111101152320.GA30466@redhat.com>
Date:   Wed, 2 Nov 2011 12:03:39 +0530
Message-ID: <CAGr+u+wgAYVWgdcG6o+6F0mDzuyNzoOxvsFwq0dMsR3JNnZ-cA@mail.gmail.com>
Subject: Re: Issue with core dump
From:   trisha yad <trisha1march@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trisha1march@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1061

Thanks all for your answer.

In loaded embedded system the time at with code hit do_user_fault()
and core_dump_wait() is bit
high, I check on my  system it took 2.7 sec. so it is very much
possible that core dump is not correct.
It  contain global value updated.

So is it possible at time of send_signal() we can stop modification of
faulty thread memory ?


Thanks



On Tue, Nov 1, 2011 at 8:53 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 11/01, trisha yad wrote:
>>
>> Dear all,
>>
>> I am running a multithreaded  application. So consider a global
>> variable x which is used by a, b and c thread.
>>
>> In thread 'a' do abnormal operation(invalid memory access) and kernel
>> send signal kill to it. In the mean time Thread 'b' and Thread 'c'
>> got schedule and update
>> the variable x. when I got the core file, variable x  got updated, and
>> I am not  getting actual value that is present at time of crash of
>> thread a.
>> But In core file I got updated value of x. I want In core file exact
>> the same memory status as it at time of abnormal operation(invalid
>> memory access)
>
> Yes, this is possible.
>
>> Is there any solution for such problem. ?
>>
>> I want in core dump the same status  of memory as at time of abnormal
>> operation(invalid memory access).
>
> I don't think we can "fix" this.
>
> We can probably change complete_signal() to notify other threads
> "immediately", but this is not simple and obviously can not close
> the window completely.
>
> Whatever we do, we can't "stop" other threads at the time when
> thread 'a' traps. All we can do is to try to shrink the window.
>
> Oleg.
>
>
