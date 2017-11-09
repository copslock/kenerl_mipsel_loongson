Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 06:54:32 +0100 (CET)
Received: from conssluserg-02.nifty.com ([210.131.2.81]:22736 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990413AbdKIFyZpVEuQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 06:54:25 +0100
Received: from mail-yw0-f173.google.com (mail-yw0-f173.google.com [209.85.161.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id vA95rjQZ008125
        for <linux-mips@linux-mips.org>; Thu, 9 Nov 2017 14:53:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com vA95rjQZ008125
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1510206826;
        bh=CJUdwFiyJi3Hw2xcYpUnDlGISb01EscKthy/hec4ct8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Esyj+7uPLJI1LY9n436/4yHlDfh9WAGIDyELeko7z/xnxXmHRuHaTmsVquT5p5Ff6
         FkbW5D9I/5iWlkIdU+07Jv3P5wxZmUvY6p7mXoolkT47DSdOt2WX6SiYuCDpBqshla
         RN9OH13RdMkEpeH/WavA7xdrlx2mXiOkCsmoFGTCmehkFsvffgCAuUiY0ShopGdpjA
         J7GWJLGEqmYcH1nq1gJDPe3Qcp0f0OPPSw4oav+cXPhUHzBoCP61vLAmijnn7ixpdN
         q6vScz1fyoMyd8auTE0ZUB+X595BSG4Sj001IRSSmFmOCCXbCXR7pSKsDPWGoSHHcy
         5Pe0snK6q9s1A==
X-Nifty-SrcIP: [209.85.161.173]
Received: by mail-yw0-f173.google.com with SMTP id k11so4401392ywh.1
        for <linux-mips@linux-mips.org>; Wed, 08 Nov 2017 21:53:45 -0800 (PST)
X-Gm-Message-State: AJaThX4d+r8mMmF9rHJPXgeNRy/PWjOe7CSFyUJHq7+LdpFp66BoXv2h
        eMI1JV4PDEckqacsNdJviWV63iPoNmpf7l+9Xts=
X-Google-Smtp-Source: ABhQp+QHyuNP8i3v5YnpnJjZJnj0YG2TGyRwWZQtH+DPSlvXTg4lYSgUkO5r0/j9jYQdrrIZJXGb4RV/ofuTH1JC/e8=
X-Received: by 10.37.189.19 with SMTP id f19mr89094ybk.220.1510206824651; Wed,
 08 Nov 2017 21:53:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.110.139 with HTTP; Wed, 8 Nov 2017 21:53:04 -0800 (PST)
In-Reply-To: <20171109053529.GA12717@ravnborg.org>
References: <1510072307-16819-1-git-send-email-yamada.masahiro@socionext.com>
 <1510072307-16819-2-git-send-email-yamada.masahiro@socionext.com> <20171109053529.GA12717@ravnborg.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 9 Nov 2017 14:53:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNARyrgRBYOW7NGURnVUhhArL3C46UWiSosveM9KGmvEY4Q@mail.gmail.com>
Message-ID: <CAK7LNARyrgRBYOW7NGURnVUhhArL3C46UWiSosveM9KGmvEY4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: create built-in.o automatically if parent
 directory wants it
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Michal Marek <mmarek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

Hi Sam,

Thanks for your review.

2017-11-09 14:35 GMT+09:00 Sam Ravnborg <sam@ravnborg.org>:
> Hi Masahiro.
>
> Thanks for picking this up.
>
>> A key point is, the parent Makefile knows whether built-in.o is needed
>> or not.  If a subdirectory needs to create built-in.o, its parent can
>> tell the fact when Kbuild descends into it.
> Good observation!
>>
>> diff --git a/Makefile b/Makefile
>> index 008a4e5..cc0b618 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1003,7 +1003,7 @@ $(sort $(vmlinux-deps)): $(vmlinux-dirs) ;
>>
>>  PHONY += $(vmlinux-dirs)
>>  $(vmlinux-dirs): prepare scripts
>> -     $(Q)$(MAKE) $(build)=$@
>> +     $(Q)$(MAKE) $(build)=$@ need-builtin=1
>
> The need-bultin may also be required for the shortcuts
> that allows one to use:
>
>         make <dir>/
>
>     example:
>
>         make net/


I do not want to add need-builtin=1 for single targets.


make scripts/
would create false scripts/built-in.o
This is odd.

I wrote the solution in the commit log:
  $(obj-y) should be still checked to support the single target "%/".


If net/Makefile contains at least one obj-y,
"make net/" will create built-in.o





> And maybe selftest, documentation shortcuts too?
> Other than that - looks good.
>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>
>         Sam
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
