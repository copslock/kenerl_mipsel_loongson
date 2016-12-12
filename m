Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Dec 2016 19:25:03 +0100 (CET)
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34736 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993039AbcLLSY5DJls8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Dec 2016 19:24:57 +0100
Received: by mail-pg0-f68.google.com with SMTP id e9so1718995pgc.1
        for <linux-mips@linux-mips.org>; Mon, 12 Dec 2016 10:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=a4VKi6P54mca38pADSWWoU0HjH2HXmlhl1kTRQNwveM=;
        b=VPeY5vXzpHxcFgLzhXa48H+yksOm7XepIMb2jzcR/eB/ZZQYAQXdI/aDqldvdqBpq8
         OJ+1hYcEGjd9CmgPOF049uBZRr0kzU5e90G6UDZXhWW/PlPTlRGuxJrO0QcwKdbFuULW
         loTkeAu3Rs22LcViN71tT5LmYKjSQObgOCOBvlKhIWPb5fP53uWjd5MpXTJyKy1gW2id
         zCvsqk6YOjA/+HIjs6wVwOz1myAttTuykQ8IUiD2H+qbXpD9oELK1VOeAwdPKbnAIGuD
         CzPWhVadt7/pdw9y30SGm9ZMHtX08z6vjmYHRLlP7p1E/BKWZk3a1fazTkUSQOrL2V6K
         InMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=a4VKi6P54mca38pADSWWoU0HjH2HXmlhl1kTRQNwveM=;
        b=VptcP5iRKOfTDDtS9K25QW+6nIkfGRmWC2qo/dt7FKbUxHIJEp+/CYdUXb+mDaj47i
         Uhk/I7j5hfvsVpeBMwdJK+eQRZyCGVdTmFnnFAfR6M6MGDq3Qjb81o6QJd8Lq5+UMvt5
         gVbgbS1VCBDHAV4FuOqo7bPdfWRnqkQDiiLvrp39fab6bj3H8myx/idOcRVGJqLWyTer
         HP/qJ/UcqGt9OK6ohFuUnJDUuX7FeeTigBjQA/GuPyKF5HVep1poFXJoOg4Rsvb6dkms
         EA6mpf2jsvkmiZAc+N08ccMOaX63KpPDRlBaikmDQ2Ph/cbt3xG77MKH7l1fdy7dq34j
         z+Rg==
X-Gm-Message-State: AKaTC02MZ0Nc276FvEST9eVw6paEcjT9cYNrtS5zVu7OnhgEn/3H0NkP9ss1+pHefCLnPA==
X-Received: by 10.84.212.144 with SMTP id e16mr188723711pli.140.1481567090950;
        Mon, 12 Dec 2016 10:24:50 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id b12sm77092296pfb.78.2016.12.12.10.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 10:24:50 -0800 (PST)
Subject: Re: [RFC] MIPS: Add cacheinfo support
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Justin Chen <justinpopo6@gmail.com>
References: <20161208011626.20885-1-justinpopo6@gmail.com>
 <5849EC43.2070802@imgtec.com>
 <CAJx26kW0e-HC0VUTObZ5Or+XjFvE9KmtOToKbFvKYvhE--Vw5A@mail.gmail.com>
 <584A0281.3040505@imgtec.com>
Cc:     linux-mips@linux-mips.org, bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justin.chen@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3004fca6-3688-65bb-7c86-248603482088@gmail.com>
Date:   Mon, 12 Dec 2016 10:24:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <584A0281.3040505@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 12/08/2016 05:01 PM, Leonid Yegoshin wrote:
> On 12/08/2016 04:28 PM, Justin Chen wrote:
>> Thanks for the comments Leonid.
>>
>> We should consider the scope of this patch. The information we are
>> trying to expose to userspace is limited to the struct cacheinfo
>> located at include/linux/cacheinfo.c (of course this can always be
>> expanded). So the question is what information would be useful to
>> expose to userspace.
>> Some justification for exposing the current information in the
>> cacheinfo struct could be: (Pulled from another email chain)
>> "Agreed. So far I have got requests from GCC, JIT and graphics guys.
>> IIUC they need this to support cache flushing for user applications like
>> gcc trampolines and JIT compilers. I am also told that having knowledge
>> of cache architecture can help optimal code strategies, though I don't
>> have much details on that."
>> https://patchwork.kernel.org/patch/5867721/
>>
>> There may be justification for including the points you mentioned
>> above, but I believe that is outside the scope of this patch. The
>> cache information exposed in this patch is limited, but I do not
>> believe it is useless. The points above can be added, but it will
>> require a rework of the base cacheinfo driver. driver/base/cacheinfo.c
>>
>>
> Justin,
> 
> CACHE instruction is not available in user space, only SYNCI on MIPS R2+
> for trampoline.
> Any operation with CACHE requires a syscall.
> 
> As for SYNCI (trampoline from L1D->L1I) the following information in
> user space is needed:
> 
>     1. L1 line size (available via RDHWR $x, $1). It is available now
> directly from CPU, but may be better to supply from kernel because some
> cores has no that.
> 
>     2. The flag that L1I is NOT coherent with L1D and SYNCI is needed
> and available

Available but not exposed AFAICT.

> 
> The knowledge about L1/L2 sizes is not needed for regular application...
> well, if application wants to get advantage of cache sizes, well, in
> this case it can be supplied.
> 
> But it is unreliable because app may be rescheduled into different kind
> of core which has a different L1 size (in heterogeneous system, BTW). It
> can be fixed by setting affinity, of course (not sure - can it be
> reliably done in BIG/LITTLE approach). But that requires in application
> the knowledge and understanding of system CPU structure... well why we
> can allow all that stuff besides information purpose? It corrupts the
> all efforts and optimization in kernel about performance and powersaving.

What Justin's patch is about is not so much about providing hints to
user-space to bypass the kernel's own management of caches, (even though
that has been used as an argument by the original introduction of
cacheinfo), but more to provide some information to user-space about the
cache topology and hierarchy.

Even though this is limited information this is still helpful to
applications like lshw and others out there.

What would be needed from your perspective to get cacheinfo added to
MIPS, shall we go back and address your initial comment about all the
little details about coherency, snooping and re-filling strategy?

Thanks
-- 
Florian
