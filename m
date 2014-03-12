Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Mar 2014 12:45:54 +0100 (CET)
Received: from 0.mx.nanl.de ([217.115.11.12]:49634 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826484AbaCLLpuwLqSB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Mar 2014 12:45:50 +0100
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com [209.85.192.44])
        by mail.nanl.de (Postfix) with ESMTPSA id ABABA45FA6;
        Wed, 12 Mar 2014 11:45:31 +0000 (UTC)
Received: by mail-qg0-f44.google.com with SMTP id a108so28761409qge.3
        for <multiple recipients>; Wed, 12 Mar 2014 04:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lm7tx/qp8RtZJ74IgXMfXXryFurXSINqAyfBfs9VNeY=;
        b=IufGx5hDVjQpsuC7f9QEfg0E29iDbW1lyK0ebR8QycU/KWRHf0XTnRAsIByd0jvGSc
         fgJFKw4oygr/mgm0m7EbxTC8L0IJCgk/blN2kG/HSh9xIdLORQgvXwYSGzthYJLGtELl
         0Y6TEmpV6EIy/ukzsHJLRf2g06TtXqp527Mpo5ZIB04/ZFHpOotH8OwzRtPO+3p9f7Gh
         ejBubR+y7bRUQ0tyCqYREo/MTWuxYEuKeK9o+i9su2EtFi21xzN3+xaJ/QL7GfnJl72A
         S5R/VD2adcmeKTOXfFebc3GUcK260A35tCqHdhuRMWttBMVerl2iA6Cc6yo1/Dp8o89B
         x/4w==
X-Received: by 10.140.43.230 with SMTP id e93mr52336107qga.35.1394624744970;
 Wed, 12 Mar 2014 04:45:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.24.81 with HTTP; Wed, 12 Mar 2014 04:45:24 -0700 (PDT)
In-Reply-To: <CAOiHx=mNtTv01CyjC=rXKzTeF79sbBqnZBQWbWXAkKnrGeZrng@mail.gmail.com>
References: <1393940084-29518-1-git-send-email-markos.chandras@imgtec.com>
 <CAP=VYLribDoh9LyQuNr-RxmRdaVxqNqzCCSAgMxKoZKWd2b1YA@mail.gmail.com> <CAOiHx=mNtTv01CyjC=rXKzTeF79sbBqnZBQWbWXAkKnrGeZrng@mail.gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 12 Mar 2014 12:45:24 +0100
Message-ID: <CAOiHx=kH+e6At0coBjC+-4gc-VHpXtrXc6Cki3Ga7x3b4AKJ7Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add support for the M5150 processor
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Mon, Mar 10, 2014 at 8:21 PM, Jonas Gorski <jogo@openwrt.org> wrote:
> On Mon, Mar 10, 2014 at 6:43 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
>> On Tue, Mar 4, 2014 at 8:34 AM, Markos Chandras
>> <markos.chandras@imgtec.com> wrote:
>>> Hi,
>>>
>>> This patchset adds support for the recently announced M5150 processor
>>> http://imgtec.com/mips/mips-series5-mclass-m51xx.asp?NewsID=804
>>
>> I'm going to skip the bisect, and make a guess that this patchset causes
>> the following build failures on all pre-existing mips boards:
>>
>> arch/mips/kernel/cpu-probe.c:856:7: error: 'PRID_IMP_M5150' undeclared
>> (first use in this function)
>> arch/mips/kernel/cpu-probe.c:857:16: error: 'CPU_M5150' undeclared
>> (first use in this function)
>> make[3]: *** [arch/mips/kernel/cpu-probe.o] Error 1
>>
>> See this link as one of the many linux-next mips failures:
>>
>> http://kisskb.ellerman.id.au/kisskb/buildresult/10701712/
>
>
> Looking at mips-next and patchwork, the problem isn't the patchset
> itself, but rather that only the third patch was applied.
>
> Ralf, I think you missed the following two patches :)
>
> http://patchwork.linux-mips.org/patch/6595/
> http://patchwork.linux-mips.org/patch/6596/

For me it now builds through, thank you!


Regards
Jonas
