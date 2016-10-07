Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2016 17:41:47 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34644 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992214AbcJGPlkQSlxn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Oct 2016 17:41:40 +0200
Received: by mail-pa0-f68.google.com with SMTP id r9so2905449paz.1;
        Fri, 07 Oct 2016 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=YdAo5+BCi7QUvPUhP0q5Nuz5AHwgAHAAZaFjS82XDDo=;
        b=ecNEG7E4ned0PuOi/OWUMQBJvK+OPU38IOkW+0Bl0U8uY85uGtCJvwC5tWD96dll6t
         Wd/l1MlIzjjDdsTbpSi48hZSPpaoFeSniMdYqYnDpuNdZQLwMOTOVIidcbKrL4xxrx4L
         /ipGZzgwKlwUN8GLutHzgl5GZ25mty6aWaDKh/8Fe8ZLRCCcs4Hvoe2+xdaPKA7trt/1
         bvpMx1B++tjbW5DAe0IG5CitcuhVFDOV7bDucqaCRB/SPBqYQ/6LW2bPpExfvOgtmzjf
         wdKjPAp57139QYc32ahhdSpPEcFdrBYvkrRpegPc0/GU0XrBWwoNducbPb0a5RmNOVnw
         wIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=YdAo5+BCi7QUvPUhP0q5Nuz5AHwgAHAAZaFjS82XDDo=;
        b=cUG0ZgZlNvTspkVhfJzFxjYBuE3xTyCVO7YZvkBW9bNJKTd4Gz7yHIYayzLvfmWiBy
         NJDV6zm2USwEeuPMVQIf/ZGyRB5aewSbwZN7V9fRO8nsK/8rJLRsQXG4iPPNjt4A7vGF
         WGdTio0hXVwj0yzfrN+W44AtTUte9ebH+/VbUJdREteuM4bsPF1YtOoH9wvzDe+Mjoou
         wQd2K8LkHrTnys69zDOqHVaclr/XlI/D6cTDMI6eJOBbvD7hx59sJHjFrwyCS1RNluCB
         57FJ2IAHN3BAA+bwXqv3zcsawcKOHgLKRulZOD5e3ZayLwl/PeYe6//fKGXLSmyhXp7z
         c4wg==
X-Gm-Message-State: AA6/9RkiGRN4dqEi3CF041sNf+3C4VQV1vq3FqBmuErnv0ldFm0+BuT5OpCOgbyd1I81mA==
X-Received: by 10.66.188.202 with SMTP id gc10mr32109949pac.104.1475854894531;
        Fri, 07 Oct 2016 08:41:34 -0700 (PDT)
Received: from dl.caveonetworks.com (50-233-148-156-static.hfc.comcastbusiness.net. [50.233.148.156])
        by smtp.googlemail.com with ESMTPSA id 20sm14956845pfk.13.2016.10.07.08.41.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 07 Oct 2016 08:41:33 -0700 (PDT)
Message-ID: <57F7C229.9040608@gmail.com>
Date:   Fri, 07 Oct 2016 08:41:29 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/9] MIPS: traps: 64bit kernels should read CP0_EBase
 64bit
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com> <e826225b15736539cd96a1b6b2a99e2bb2b4eb87.1472747205.git-series.james.hogan@imgtec.com> <20160921130852.GA10899@linux-mips.org> <73eede89-af68-eb17-b0b3-2537084da819@imgtec.com> <alpine.LFD.2.20.1610021038190.25303@eddie.linux-mips.org> <20161005155653.GG15578@jhogan-linux.le.imgtec.org> <alpine.LFD.2.20.1610061709400.1794@eddie.linux-mips.org> <57F7C0D5.6000007@gmail.com>
In-Reply-To: <57F7C0D5.6000007@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 10/07/2016 08:35 AM, David Daney wrote:
> On 10/06/2016 09:18 AM, Maciej W. Rozycki wrote:
>> Hi James,
>>
>>>>   This does look wrong to me, as I noted above EBase is 64-bit with
>>>> MIPS64
>>>> processors as from architecture revision 3.50.  Also I don't think
>>>> we want
>>>
>>> MIPS64 PRA (I'm looking at r5 and r6) seems to allow for write-gate not
>>> to be implemented, in which case the register is only 32-bits.
>>
>>   Indeed, but we need to be prepared to handle the width of 64 bits and
>> `cpu_has_mips64r6' does not seem to me to be the right condition.
>
> It is not the proper condition.
>
> The presence of a 64-bit EBase should be probed for.
>
> The proper check is to test of the EBase[WG] (bit 11) can be set to 1.
> It it can, this indicates that EBase supports 64-bit accesses.
>

One more thing...

In r5 systems, the only time 64-bit Ebase is really interesting is for 
virtualization.

You could also gate probing WG on the presence of the VZ capability.



> David.
>
>
>
