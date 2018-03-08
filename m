Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2018 09:42:43 +0100 (CET)
Received: from conssluserg-04.nifty.com ([210.131.2.83]:59528 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991172AbeCHImfGWLg8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Mar 2018 09:42:35 +0100
Received: from mail-vk0-f41.google.com (mail-vk0-f41.google.com [209.85.213.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w288g29E024606;
        Thu, 8 Mar 2018 17:42:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w288g29E024606
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1520498523;
        bh=8XC/oa4ahu/SxhlGmCIQpAgN80k28zywuO13LW7HfRY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eRsif4Q52+bIxJy6ExP7ffSfeflmxNscLKtuLohj1LUAqBn5cVvTxE9Pc1qsO7hoP
         yCTDgao5shOL2LBPF10oyNQYKB9zPhEWRJUF+fS44uH838dczzHqTS6mgcNvzv6ljW
         qF8fp52mB/zKo29BmZiezbL8hNM9VeayUyOW8O9JA6tDOdCR6dGijyck1cyHM1V1g8
         rfEX1rQdIAgSlRVZNk018PZ1/L4WMBquJAS4og1+ipPaCqoK98EUX752wggEf1jVTe
         zjSkhg4GkuO12A3N6ySgIvbyWy6PRJ4ttFicQ9z9jyeWRBNSxVwxp5v+qe+/EiwnAz
         rspJpCNm7s1Fw==
X-Nifty-SrcIP: [209.85.213.41]
Received: by mail-vk0-f41.google.com with SMTP id b65so3134367vka.2;
        Thu, 08 Mar 2018 00:42:03 -0800 (PST)
X-Gm-Message-State: APf1xPDbPsCZGorQ1c0sAX3ABl32bRm7IoZmBSIGcXBdz1zYRiepg8d8
        O0XJI6+aH4zGL8/a3PiGpNE4f3stbTqnO+1q+9I=
X-Google-Smtp-Source: AG47ELtr9BOsSz7eb14vj3ida0YEcxAyiyjo8dq3AbXvYuU07PFMQ0576eyDGtAQtfQjnrvoCt+CSPeWIf16bl7IRog=
X-Received: by 10.31.237.68 with SMTP id l65mr17853571vkh.11.1520498522197;
 Thu, 08 Mar 2018 00:42:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.138 with HTTP; Thu, 8 Mar 2018 00:41:21 -0800 (PST)
In-Reply-To: <20180308070948.GA5187@saruman>
References: <20180307140633.26182-1-jhogan@kernel.org> <7ecea7ca-2931-16bc-a110-1ecdaf17f0f2@gmail.com>
 <20180307202511.GT4197@saruman> <a6c448df-c026-dafe-6d34-801f69ca64fe@gmail.com>
 <20180308070948.GA5187@saruman>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 8 Mar 2018 17:41:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfTxxb0_RNEPvBzuEqP_g-cajZGpaGSuMJBUwDW66yww@mail.gmail.com>
Message-ID: <CAK7LNARfTxxb0_RNEPvBzuEqP_g-cajZGpaGSuMJBUwDW66yww@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Handle builtin dtb files containing hyphens
To:     James Hogan <jhogan@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62854
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

2018-03-08 16:09 GMT+09:00 James Hogan <jhogan@kernel.org>:
> On Wed, Mar 07, 2018 at 03:19:11PM -0800, Frank Rowand wrote:
>> On 03/07/18 12:25, James Hogan wrote:
>> > On Wed, Mar 07, 2018 at 12:11:41PM -0800, Frank Rowand wrote:
>> >> On 03/07/18 06:06, James Hogan wrote:
>> >>> Quite a lot of dts files have hyphens, but its only a problem on MIPS
>> >>> where such files can be built into the kernel. For example when
>> >>> CONFIG_DT_NETGEAR_CVG834G=y, or on BMIPS kernels when the dtbs target is
>> >>> used (in the latter case it admitedly shouldn't really build all the
>> >>> dtb.o files, but thats a separate issue).
>
>> > I'll keep the paragraph about MIPS and the example configuration though,
>> > as I think its important information to reproduce the problem, and to
>> > justify why it wouldn't be appropriate to just rename the files (which
>> > was my first reaction).
>>
>> Other than the part that says "its only a problem on MIPS".  That is
>> pedantically correct because no other architecture (that I am aware
>> of, not that I searched) currently has a devicetree source file name
>> with a hyphen in it, where that file is compiled into the kernel as
>> an asm file.  But it is potentially a problem on any architecture
>> to it is misleading to label it as MIPS only.
>
> Okay I'll reword to make it clearer and do a v2.
>
> Thanks
> James


The code looks good.
If you send v2, I can shortly apply it to the fixes branch.

If possible, I want to send a PR this weekend.



-- 
Best Regards
Masahiro Yamada
