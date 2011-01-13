Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jan 2011 13:47:52 +0100 (CET)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:63909 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492632Ab1AMMrt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jan 2011 13:47:49 +0100
Received: by gwj20 with SMTP id 20so679542gwj.36
        for <multiple recipients>; Thu, 13 Jan 2011 04:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RXZJuMfdD8EkWwPl1PVMWK1bQxAyMuZ9Kfkdz0/hTyc=;
        b=NU9aP++D8dokvwZnGN3Ln05WXGfL8db0gYJMSBdwkueFek3YvutdIc41EL5lv80bN2
         VSxnPNBfyIj+CmJdhVJrM78Qh0LCGAR7DeUgd+9jAh+TR9XysT+31m7tdNUwS8iOCZcG
         p7h0X0OUavVTMzioocosIo6FOHrXaVkNdXo9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ffWSbxuDMx332otJsVRI2ZTbqxaMBnWWDlO4G+XCGPAru3zDJxTfRSUsCz3oRPr1NJ
         9ao+zywaO9NNGiUW3hmhFRRDF5i4ZBZZ/LLP5zLFrTUiT+81rv8MNY7p6WCxzfRlnH4V
         SKo7HkCVFlC6MgRL+XDshs8waIYaaO9jRYGgw=
MIME-Version: 1.0
Received: by 10.151.7.19 with SMTP id k19mr3707064ybi.279.1294922860991; Thu,
 13 Jan 2011 04:47:40 -0800 (PST)
Received: by 10.150.186.12 with HTTP; Thu, 13 Jan 2011 04:47:40 -0800 (PST)
In-Reply-To: <4D2EDE92.40203@openwrt.org>
References: <1294257379-417-1-git-send-email-blogic@openwrt.org>
        <1294257379-417-2-git-send-email-blogic@openwrt.org>
        <AANLkTinBovWsPak3cCNRMigC8mxUwEik2oB3kSsw-YQL@mail.gmail.com>
        <4D2EDE92.40203@openwrt.org>
Date:   Thu, 13 Jan 2011 13:47:40 +0100
Message-ID: <AANLkTingxSonua3v+9rqCJeuV-TjiMBX_BfxxHYOcBoe@mail.gmail.com>
Subject: Re: [PATCH 01/10] MIPS: lantiq: add initial support for Lantiq SoCs
From:   Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <daniel.schwierzeck@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.schwierzeck@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi John,

2011/1/13 John Crispin <blogic@openwrt.org>:
>
>>> +
>>> +/* all access to the ebu must be locked */
>>> +DEFINE_SPINLOCK(ebu_lock);
>>> +EXPORT_SYMBOL_GPL(ebu_lock);
>>>
>> This lock is only needed if you want to use software arbitration.
>> Normally the EBU does hardware arbitration and can be accessed safely
>> without lock.
>>
>>
> openwrt borks up on mini_fo init when this lock is not in-place. we saw
> a lot of issues in the past which lead to this lock being added. i will
> retry it with out the lock to verify
>
Ok I never tried mini_fo bit it's working fine with squashfs. Maybe
it's a problem with your EBU setup. We always reset
the EBU_ADDR_SEL0 and EBU_CON_0 registers in U-Boot's lowlevel_init.S.
The values are EBU_ADDR_SEL0 = 0x10000021
and EBU_CON_0 = 0x8001F7FF.
My suggestion is to wrap the locking mechanism into separate inline
functions and define them only if really needed and enabled in kernel
config.

Daniel
