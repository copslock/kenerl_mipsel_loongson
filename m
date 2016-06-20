Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2016 11:32:46 +0200 (CEST)
Received: from caladan.dune.hu ([78.24.191.180]:60034 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27043125AbcFTJco1CtST (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Jun 2016 11:32:44 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 061ADB92317;
        Mon, 20 Jun 2016 11:32:44 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-vk0-f41.google.com (mail-vk0-f41.google.com [209.85.213.41])
        by arrakis.dune.hu (Postfix) with ESMTPSA id A9D8FB922D4;
        Mon, 20 Jun 2016 11:32:11 +0200 (CEST)
Received: by mail-vk0-f41.google.com with SMTP id d185so188451358vkg.0;
        Mon, 20 Jun 2016 02:32:11 -0700 (PDT)
X-Gm-Message-State: ALyK8tIPksEx73qplgJyE/50XJBfErp4Q4liAkeFRZjeHEHucESujZUpzClvnX02bpdZa4Ol2qEHKbwFV6pA2g==
X-Received: by 10.159.36.42 with SMTP id 39mr6139437uaq.110.1466415130600;
 Mon, 20 Jun 2016 02:32:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.2.141 with HTTP; Mon, 20 Jun 2016 02:31:51 -0700 (PDT)
In-Reply-To: <1466182596.5921.5.camel@chimera>
References: <1466165260-6897-1-git-send-email-jogo@openwrt.org>
 <1466165260-6897-3-git-send-email-jogo@openwrt.org> <1466182596.5921.5.camel@chimera>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Mon, 20 Jun 2016 11:31:51 +0200
X-Gmail-Original-Message-ID: <CAOiHx==e_qFDVHR+ScXZDfLGwD2ehxheRO+8qTmeZh1QJ-pUwA@mail.gmail.com>
Message-ID: <CAOiHx==e_qFDVHR+ScXZDfLGwD2ehxheRO+8qTmeZh1QJ-pUwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: store the appended dtb address in a variable
To:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Alban Bedel <albeu@free.fr>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54124
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

Hi Daniel,

On 17 June 2016 at 18:56, Daniel Gimpelevich
<daniel@gimpelevich.san-francisco.ca.us> wrote:
> On Fri, 2016-06-17 at 14:07 +0200, Jonas Gorski wrote:
>> +++ b/arch/mips/pic32/pic32mzda/init.c
>> @@ -33,8 +33,8 @@ static ulong get_fdtaddr(void)
>>  {
>>         ulong ftaddr = 0;
>>
>> -       if ((fw_arg0 == -2) && fw_arg1 && !fw_arg2 && !fw_arg3)
>> -               return (ulong)fw_arg1;
>> +       if (fw_passed_dtb && !fw_arg2 && !fw_arg3)
>> +               return (ulong)fw_passed_dtb;
>
> This part potentially violates the UHI spec. If fw_passed_dtb is valid
> but fw_arg0 > 0, fw_arg2 may still be a valid envp. Comparing otherwise
> undefined values to zero is also incorrect.

That was true before and is still true after my changes, so nothing
added by me. This would be something for the pic32 maintainers (or
users) to comment on/fix.


Jonas
