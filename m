Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 22:30:00 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:32836 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013228AbbGFU36ouhdM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 22:29:58 +0200
Received: by laar3 with SMTP id r3so170370469laa.0
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 13:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=U9OS8OAaLqGWxi4HOH+8RW5OJs9aE9JAWp4vfTGVsEI=;
        b=lyGuy+C+b7kTZtUwplaJ8IJ8Hxe+bqwI99+STpDDhpuVjIMRXfvO+T0RJ03UcdA3LR
         5/wZlrJj1oyk/Xfpm6FGRwT0TDtIkBMtwExmPwLCk10f5jmBj1Kz4hPm7yvfIXvMiyOC
         edyeLrl9LyHfvqPmz1gks5zDG9ZLmrlFSjwbecE8QyygoMvYdDtWgLZHkQ209CZAuFzC
         Q6IOnFubEIHTd+yomVrvFc3FhoKmkCz3xiBd1jU70i1VGNza62amfjTDKXLh1nrwjAn5
         WbYC+Jh/SYBzGMaTlLjVwV6Ci6LJ2ec86tXcBd3hgvPgHOIXXt21B66J4YdaOqSLsFCx
         njjA==
X-Gm-Message-State: ALoCoQnR3GSE8YvLEbdt9FacEEVTVq3Xv4nEIv0K/tDV0rDzBJw8jbGyJCHQogwUfFf/JCeVwS9L
X-Received: by 10.152.36.161 with SMTP id r1mr656239laj.88.1436214593231;
        Mon, 06 Jul 2015 13:29:53 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp83-237-249-53.pppoe.mtu-net.ru. [83.237.249.53])
        by mx.google.com with ESMTPSA id o8sm5032086laf.7.2015.07.06.13.29.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 13:29:52 -0700 (PDT)
Message-ID: <559AE53E.6070909@cogentembedded.com>
Date:   Mon, 06 Jul 2015 23:29:50 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
CC:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH 07/14] MIPS/cevt-r4k: Migrate to new 'set-state' interface
References: <cover.1436180306.git.viresh.kumar@linaro.org> <cc71e2a4cdc16660a59919f22358d159f4bd2ccf.1436180306.git.viresh.kumar@linaro.org> <559AC4E0.80205@cogentembedded.com> <559AC7F7.9080600@cogentembedded.com>
In-Reply-To: <559AC7F7.9080600@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 07/06/2015 09:24 PM, Sergei Shtylyov wrote:

>>> Migrate cevt-4k driver to the new 'set-state' interface provided by
>>> clockevents core, the earlier 'set-mode' interface is marked obsolete
>>> now.

>>> This also enables us to implement callbacks for new states of clockevent
>>> devices, for example: ONESHOT_STOPPED.

>>> We weren't doing anything in the ->set_mode() callback. So, this patch
>>> doesn't provide any set-state callbacks.

>>     The code in __clockevents_switch_state() looks like it's going to oops as
>> you're not implementing set_state_oneshot()...

>     In fact, clockevents_sanity_check() should return -EINVAL in this case,
> and so the kernel crash even earlier, duyr to BUG_ON() in
> clockevents_register_device().

    tglx has turned my attention the pre-requisite patch, and I have finally 
found it in the archives. I'm now OK with the patches I  considered broken.

WBR, Sergei
