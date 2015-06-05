Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2015 16:35:46 +0200 (CEST)
Received: from mail-la0-f41.google.com ([209.85.215.41]:33630 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007510AbbFEOfoOA76G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jun 2015 16:35:44 +0200
Received: by labpy14 with SMTP id py14so55797743lab.0
        for <linux-mips@linux-mips.org>; Fri, 05 Jun 2015 07:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wTooGAb050E1VETtk4jbfPMMLk+860TS6I0Le4FZhwU=;
        b=GHFBPTv3/5rcVkeVn5ninwqYKNvT4nAe0PsF67m5ZQM3O0pY5tKcOsGqPtmaCUms+n
         5Q2Qo5ugHhV5o25qcYEZ6gUDLvNYbkqJoWA5RsXla1wq+DE4L82THEmvYrqz8ZjjpTj5
         GqCUWqRRXw19jlmWcXDdkKIT0v5B7OXxVg+qANYjzd18QZqaci92tN/2OeeVgLrFK8tD
         NHttj46Ci4VGdoHqEX9nGjakSzPfqUv1DTvkaw3a7j1mwOwV9pjcllBWlXWvez95C6qi
         Da0So2yI/T9bhwHQNJDL+Cy37KLM+F6677JOw4CDnyjGWGEHuLfQpcArDjcr5EawqOyv
         TOpQ==
X-Gm-Message-State: ALoCoQkgomGWK7IP1L4k8l/L26Dt0q+5mCmn45dEnQ7DniLUUkMhZTPrefQ2fApsYLK40tQ4Qefr
X-Received: by 10.152.42.140 with SMTP id o12mr3682797lal.15.1433514938611;
        Fri, 05 Jun 2015 07:35:38 -0700 (PDT)
Received: from [192.168.3.154] (ppp83-237-253-8.pppoe.mtu-net.ru. [83.237.253.8])
        by mx.google.com with ESMTPSA id t15sm1812731lbk.0.2015.06.05.07.35.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2015 07:35:37 -0700 (PDT)
Message-ID: <5571B3B6.9090202@cogentembedded.com>
Date:   Fri, 05 Jun 2015 17:35:34 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] MIPS: traps: Add missing include file
References: <1433514585-26380-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1433514585-26380-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47888
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

Hello.

On 6/5/2015 5:29 PM, Guenter Roeck wrote:

> Commit 05155ddc2617 ("MIPS: get rid of 'kgdb_early_setup' cruft")
> removed the include of linux/kgdb.h from arch/mips/kernel/traps.c.

    Sorry about that. And thanks for beating me to it. :-)

> This results in

> arch/mips/kernel/traps.c: In function 'show_stack':
> arch/mips/kernel/traps.c:204:14: error: 'kgdb_active' undeclared

    The build robot has informed me about that one...

> arch/mips/kernel/traps.c: In function 'do_trap_or_bp':
> arch/mips/kernel/traps.c:877:2: error:
> 		implicit declaration of function 'kgdb_ll_trap'

    ... but not about this one.

> when building mips:allmodconfig.
>
> Fixes: 05155ddc2617 ("MIPS: get rid of 'kgdb_early_setup' cruft")
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

WBR, Sergei
