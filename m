Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 17:00:01 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:45760 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901351Ab1KAP75 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2011 16:59:57 +0100
Received: by ggnk3 with SMTP id k3so8122400ggn.36
        for <linux-mips@linux-mips.org>; Tue, 01 Nov 2011 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=niMISTMFnh5R4oEAU5DX47GEf+r8XSa/lL3yalhTxtQ=;
        b=u0Ly0DQZohCzoFNid1UHfHcjYoP9R1dfKTyac4Ud0BuSCfRk66nH1H1LSYppTgEd05
         UObGiXrYO9+f8FK9Xk7NCYtVhOP20ddBWaeIbKOQZ+/Z5Cpxd2Vi4eUDLJ0pknc84cAu
         hG+8IbZTeldOB4p4HDfglxGmm1ILgUhNSvZm0=
Received: by 10.236.195.36 with SMTP id o24mr102917yhn.57.1320163191348;
        Tue, 01 Nov 2011 08:59:51 -0700 (PDT)
Received: from google.com (tejun.mtv.corp.google.com [172.18.96.198])
        by mx.google.com with ESMTPS id o64sm8104639yhk.3.2011.11.01.08.59.47
        (version=SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 08:59:49 -0700 (PDT)
Date:   Tue, 1 Nov 2011 08:59:45 -0700
From:   Tejun Heo <htejun@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
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
Message-ID: <20111101155945.GQ18855@google.com>
References: <CAGr+u+zkPiZpGefstcbJv_cj929icWKXbqFy1uR22Hns1hzFeQ@mail.gmail.com>
 <20111101152320.GA30466@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111101152320.GA30466@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 31339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: htejun@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 488

Hello,

On Tue, Nov 01, 2011 at 04:23:20PM +0100, Oleg Nesterov wrote:
> Whatever we do, we can't "stop" other threads at the time when
> thread 'a' traps. All we can do is to try to shrink the window.

Yeah, "at the time" can't even be defined preciesly.  Order of
operation isn't clearly defined in absence of synchronization
constructs.  In the described example, there's unspecified amount of
time (or cycles rather) between the load of the global variable and
the thread faulting.  Anything could have happened inbetween no matter
how immediate core dump was.

As long as we're reasonably immediate, which I think we already are, I
don't think there's much which needs to be changed.

Thanks.

-- 
tejun
