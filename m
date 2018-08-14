Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2018 18:35:45 +0200 (CEST)
Received: from mail-qk0-x242.google.com ([IPv6:2607:f8b0:400d:c09::242]:36507
        "EHLO mail-qk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992960AbeHNQfmDBTUp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2018 18:35:42 +0200
Received: by mail-qk0-x242.google.com with SMTP id x192-v6so13813697qkb.3;
        Tue, 14 Aug 2018 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Pqmj3ClLJHm0NWuPcuK5T5mzzNcGqtnI3cr79Wbf/BE=;
        b=JsYr5nvjfZGsIkd4j3LjWGsU0CZexJlXnv+bhDZIWUoOZrcD0Jz3tRhkjZQG2+RCfy
         P1wGl7Xt4rD9FeR34KfEDqtvmauOUarEzdONy+ZMuel2gwAXO9nsdSfZVCOkFEZ3JQ/w
         yQtv3XqObH/MYh44UKcN7yZCFv4S/J5OWnh+9k5PKKZrvsQ5Ip5Ay2gjWyKKYLFGieQY
         4hTUpfSXFwPzFrOwVxDbKLaORsXcYQpFnXo1KS0mTNAM+MI6MRxIpcqErar9Ml6jd+ON
         nqXd5OtScVYYps5iocIFzZLd9IqpVH7UFE/WMd3gvYerTvBcS5S5icmDwAxvOZ9JscTO
         NARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Pqmj3ClLJHm0NWuPcuK5T5mzzNcGqtnI3cr79Wbf/BE=;
        b=hMmqKeYwmyG8O/wGyWJhnOud3w2Psiggn+/Q8d9rSDu8EPG2QngF6y+wsleJFjQ2bg
         VcEF5tus068KERnCfV6zJpSL95ay2ncGi14lFrjhO5vhHMx+eWMJz8kx2E2tpdDYAia1
         cvHLy8zVFstuWRHVmKEqi4Jq3BYIW3bmFXlAeuO/RIyAlHamms1wo2Ryv5SLXmkh1eUg
         mMtYfFi4gXRu0l3+P0svOpuQ9ziax+wP6B7qEyvDR/yANRy/MsbY4H9GG36E8BEps1tx
         A8e6sdaXPZ3WDOzam7WLLYq2UgX0vnNqI4nxYFmS25ZqWhAi+hJauSbz4dNO2cX5gz3f
         /gew==
X-Gm-Message-State: AOUpUlGHJsuLiRHoSepCD6JdvJnWMraZ6aw5O1EKvmWrLWjQ88E4Vb7Y
        zpKnG8nwSef5lneGKTY5MDk0qUVHkDkCUL7QKLg=
X-Google-Smtp-Source: AA+uWPwQPHjJpNg+Nt3nD0HCqFo3QCVn25BfaNtwuVjkAYuDcR2sYfxf/WjddMfk/u5g3ccOZpuW2+x+A1FkTwV+M9M=
X-Received: by 2002:a37:2916:: with SMTP id p22-v6mr20182515qkh.327.1534264535796;
 Tue, 14 Aug 2018 09:35:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 09:35:35
 -0700 (PDT)
In-Reply-To: <58d21bac-5a31-85df-4b9f-05815b64f465@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com> <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
 <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com> <20180813115019.GB28360@redhat.com>
 <fa85d19f-b22c-e09c-b8d2-f68f0c79de15@linux.ibm.com> <20180813131723.GC28360@redhat.com>
 <CAPhsuW4KT=6vR_0ogTy_+Fwcz7cZ0Rac8sYohLngQmEBCd0HLw@mail.gmail.com> <58d21bac-5a31-85df-4b9f-05815b64f465@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 14 Aug 2018 09:35:35 -0700
Message-ID: <CAPhsuW5YoX=5HVYWFNaBHOeM+opfA6waqMMCwLQy2YS_+2k6ng@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <liu.song.a23@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liu.song.a23@gmail.com
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

On Mon, Aug 13, 2018 at 9:37 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> Hi Song,
>
> On 08/13/2018 10:42 PM, Song Liu wrote:
>> On Mon, Aug 13, 2018 at 6:17 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>> On 08/13, Ravi Bangoria wrote:
>>>>
>>>>> But damn, process creation (exec) is trivial. We could add a new uprobe_exec()
>>>>> hook and avoid delayed_uprobe_install() in uprobe_mmap().
>>>>
>>>> I'm sorry. I didn't get this.
>>>
>>> Sorry for confusion...
>>>
>>> I meant, if only exec*( could race with _register(), we could add another uprobe
>>> hook which updates all (delayed) counters before return to user-mode.
>>>
>>>>> Afaics, the really problematic case is dlopen() which can race with _register()
>>>>> too, right?
>>>>
>>>> dlopen() should internally use mmap() right? So what is the problem here? Can
>>>> you please elaborate.
>>>
>>> What I tried to say is that we can't avoid uprobe_mmap()->delayed_uprobe_install()
>>> because dlopen() can race with _register() too, just like exec.
>>>
>>> Oleg.
>>>
>>
>> How about we do delayed_uprobe_install() per file? Say we keep a list
>> of delayed_uprobe
>> in load_elf_binary(). Then we can install delayed_uprobe after loading
>> all sections of the
>> file.
>
> I'm not sure if I totally understood the idea. But how this approach can
> solve dlopen() race with _register()?
>
> Rather, making delayed_uprobe_list an mm field seems simple and effective
> idea to me. The only overhead will be list_empty(mm->delayed_list) check.
>
> Please let me know if I misunderstood you.
>
> Thanks,
> Ravi

I misunderstood the problem here. I guess mm->delayed_list is the
easiest solution of the race condition.

Thanks,
Song
