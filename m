Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 13:18:47 +0200 (CEST)
Received: from mail-pb0-f41.google.com ([209.85.160.41]:38932 "EHLO
        mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824769Ab3F0LSpzgZpX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Jun 2013 13:18:45 +0200
Received: by mail-pb0-f41.google.com with SMTP id rp16so787040pbb.14
        for <multiple recipients>; Thu, 27 Jun 2013 04:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=pIna/cN1rVdHdQkjBVSCchzVSSaBAPtBzVyvvrn9/gk=;
        b=AiwlEA1OxkyMmM4g+dOXytH/2aNcuNXq4lkm0Q+lYLUNJWxtAZ25M41JVdHrGVjL0L
         1xql1h698oadROeEw4jsH34+irw+H/3OR7YOxUewltcjAHpFtcRU8GfdQ34WUhWIkyxk
         1K4ShxUobN1Jbdi2Pz98ngLNhnfIvyS4/3zSovI5x8SIqu3o/WmcwMiFGRs1HYYJVX4y
         7nR29zGKY+BTsLEXM6XE7E+LZc0nm94SayGBVcOy3UtRuP+nG3rqsue8VUrmwlh/uc46
         COTVqgNSDlhlCmZmPks8UZZkqvAZUEQEmWlueqSnz/1wj3kKPSojLd0kZSjtI1olul0n
         W6bQ==
X-Received: by 10.68.213.231 with SMTP id nv7mr5527297pbc.70.1372331919280;
 Thu, 27 Jun 2013 04:18:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.69.17.33 with HTTP; Thu, 27 Jun 2013 04:17:59 -0700 (PDT)
In-Reply-To: <20130627111116.GT7171@linux-mips.org>
References: <1372329915-17944-1-git-send-email-florian@openwrt.org> <20130627111116.GT7171@linux-mips.org>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Thu, 27 Jun 2013 12:17:59 +0100
X-Google-Sender-Auth: 5fqnNLbGS7wDR98xu-MhdZHoS3c
Message-ID: <CAGVrzcYc39L0EfjyzLqJbFkqcGUVSGwQ=fMdwx1pE_mq5QzrOQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BMIPS: fix warnings for non BMIPS43xx builds
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>, jogo@openwrt.org,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

2013/6/27 Ralf Baechle <ralf@linux-mips.org>:
> On Thu, Jun 27, 2013 at 11:45:15AM +0100, Florian Fainelli wrote:
>
>> Commit dccfb4c4 ("MIPS: BMIPS: support booting from physical CPU other
>> than 0") introduces the following warning when building for non
>> BMIPS43xx builds:
>>
>> arch/mips/kernel/smp-bmips.c:150:6: error: unused variable 'tpid'
>> [-Werror=unused-variable]
>>
>> Fix this by getting rid of this variable and directly using
>> cpu_logical_map(cpu).
>
> Sounds like the previous patch wasn't really tested - or somebody shot
> himself into the foot by removing the -Werror.

There is nothing in tree using BMIPS3300 or BMIPS5000 which are the
only two other possibilities where this warning could have been
caught.

>
> Anyway, folded in.

Thanks
--
Florian
