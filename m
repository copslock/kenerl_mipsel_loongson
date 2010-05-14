Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2010 19:15:31 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:51807 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491913Ab0ENRP0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 May 2010 19:15:26 +0200
Received: by pxi1 with SMTP id 1so1467472pxi.36
        for <multiple recipients>; Fri, 14 May 2010 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Dyugft45e4/CbvXthVjyYNB+hjH3zPcDWQ3JG1uTvI0=;
        b=nQSbykjAEiSnIoLxksZMCbDwWD8Tu+uYBo2i/iECnuzSZYAVshO9Hz+RDJXePMz0nL
         EnvathN6ESGIiaiE6ulTZla+pIEcTvC5rDxIjmNYLQUFDcz5lpuhB5Jlkvbx46hDfbru
         ENMWFAqh6GxoNaXFrtxDkp73nv5E2nXvOnf0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=JiJP1fuNUiU2BstrI9B7ljniqea2o4z9guVGoIz6gCYv57nYwaxdMqYjoHO184auce
         IFL1Qiaj22F5sgkfW9KiHq5tL9/kNgdVNq3T9J5HlFAK0Vrdd5lHtW0DvVSt8xbMsg/x
         8TmsCGmuCq1nrYVctaagD69w49/H0fWsI23X8=
Received: by 10.143.85.1 with SMTP id n1mr895945wfl.201.1273857319249;
        Fri, 14 May 2010 10:15:19 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id 21sm1867204pzk.4.2010.05.14.10.15.17
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 10:15:17 -0700 (PDT)
Message-ID: <4BED8524.8010805@gmail.com>
Date:   Fri, 14 May 2010 10:15:16 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Wu Zhangjin <wuzhangjin@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 7/9] tracing: MIPS: Reduce the overhead of dynamic Function
 Tracer
References: <cover.1273834561.git.wuzhangjin@gmail.com> <6b4495690164114ff7353c86f6b53b979fca2756.1273834562.git.wuzhangjin@gmail.com>
In-Reply-To: <6b4495690164114ff7353c86f6b53b979fca2756.1273834562.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/14/2010 04:08 AM, Wu Zhangjin wrote:
> From: Wu Zhangjin<wuzhangjin@gmail.com>
>
> With the help of uasm, this patch encodes the instructions of dynamic
> Function Tracer in ftrace_dyn_arch_init() when initializing it.
>
[...]
> +#include<asm/uasm.h>
>

All of uasm is _cpuinit, I haven't checked everything, but are you sure 
you aren't calling if from non-_cpuinit code?

David Daney
