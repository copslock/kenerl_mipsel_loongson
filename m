Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Aug 2013 10:44:05 +0200 (CEST)
Received: from mail-wi0-f174.google.com ([209.85.212.174]:50594 "EHLO
        mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822956Ab3HPIn75LSjq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Aug 2013 10:43:59 +0200
Received: by mail-wi0-f174.google.com with SMTP id j17so554294wiw.13
        for <multiple recipients>; Fri, 16 Aug 2013 01:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=E0lTJxS6Pkw48db6Zur8pEr/HGxJFHAorO9/ks+rz8k=;
        b=HXPZt0vAcyOykoD25RVq6EY7Mp5h2Q56jz4YNqcehwwURDcAHuobcbuCJVaCpAAzzJ
         +2JKyJmM076kUlARJHCQWutSBXokE73wYdP+7L5PDBzNQxGAKB9lTqa/doJ6WxBpun8L
         ZFxtdSBaoDnGCnb1P2q5gBjco/VAPKppkuzDIECzNRRXrVhoRHO7eGD/8XqMSNQOJdeU
         3UmnM4QdRcMm+HoPMUmw7BB0rcsiJryjkLzxt0Q7X5x7cweSB3C6/+/dHHp/xqdzODqA
         1JhrkZNr1dsikwPf1RoIZwnvsgSgQuvgBUhZEcjpGNwiH1mWhPEN8a1HIwwArsUHtZEY
         9eaA==
MIME-Version: 1.0
X-Received: by 10.180.85.133 with SMTP id h5mr4471678wiz.1.1376642632286; Fri,
 16 Aug 2013 01:43:52 -0700 (PDT)
Received: by 10.180.163.168 with HTTP; Fri, 16 Aug 2013 01:43:52 -0700 (PDT)
In-Reply-To: <20120815104812.GB4035@linux-mips.org>
References: <1344971541-22465-1-git-send-email-juhosg@openwrt.org>
        <20120815104812.GB4035@linux-mips.org>
Date:   Fri, 16 Aug 2013 10:43:52 +0200
Message-ID: <CAGXE3d8Povc1aLh6EAwrkBmvvceES+w9Ztbk20bHU7tN=43NUw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ath79: don't hardcode the unavailability of the DSP ASE
From:   Helmut Schaa <helmut.schaa@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <helmut.schaa@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: helmut.schaa@googlemail.com
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

Hi Ralf,

On Wed, Aug 15, 2012 at 12:48 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Aug 14, 2012 at 09:12:21PM +0200, Gabor Juhos wrote:
>
>> The ath79 platform code allows to run a single kernel image
>> on various SoCs which are based on the 24Kc and 74Kc cores.
>> The current code explicitely disables the DSP ASE, but that
>> is available in the 74Kc core.
>>
>> Remove the override in order to let the kernel to detect the
>> availability of the DSP ASE at runtime.
>>
>> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
>>
>> ---
>> This is a replacement of the 'MIPS: ath79: don't override CPU ASE features'
>> patch: https://patchwork.linux-mips.org/patch/4169/
>>
>> I don't think that the issue is critical enough to include that in
>> the stable trees.
>
> But it's also trivial.  Anyway, the effect of this "bug" is that the DSP
> ASE is not available and apparently this has not yet shown up on anybody's
> radar.
>
> Anyway, applied!  Thanks!

This change somehow didn't make it into the offical kernel releases due to
"MIPS: Hardwire detection of DSP ASE Rev 2 for systems, as required."
which basically reverted this change again.

Was this intentional?

Just noticed while booting 3.10 on a AR9344 SoC ...

Thanks,
Helmut
