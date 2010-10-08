Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 17:55:12 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:47664 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491201Ab0JHPzI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 17:55:08 +0200
Received: by pvc21 with SMTP id 21so38212pvc.36
        for <multiple recipients>; Fri, 08 Oct 2010 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=tQyFO5tPAK7BGqmJUjGw9zzu4pmjW9Nezhk1Ib1Z1pU=;
        b=xms+spi+fCeQlgcCTWTLJKdiRlm7+OSBNdwqGmYgZg6lYhVImq/cTP0eUTN19wOg5u
         XFlYdTG0Y+UEXMhOGA60X/Sbdqf9TXWpxLwnWvOovui+XJ1Ic8MpGRq1lmPh31B3jEPn
         iHs3CbEsUn3pnyFfYkULZaxzwQE9CiZ6t1lHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=I7kuJXUjnh5rthuJcw+ecoYCrI4c2EZqi3+rXLM3nT6ajGIdXv7lfV3Sn4FLjUqmwn
         dS4W894EiEdrqxGpLyo5+fyk4e4fHmHsNOVhZWLwQdYle/zj8jBbm6CQearwfzNV95j/
         WBI0JOJUQRS0AkT5Siajd23pShXqr3niW7cso=
MIME-Version: 1.0
Received: by 10.142.232.18 with SMTP id e18mr2139169wfh.388.1286553301912;
 Fri, 08 Oct 2010 08:55:01 -0700 (PDT)
Received: by 10.231.59.77 with HTTP; Fri, 8 Oct 2010 08:55:01 -0700 (PDT)
In-Reply-To: <20101008155319.GC12107@linux-mips.org>
References: <AANLkTikXySeekzpYeGf6wuH5NTMxLCK_oirvBcDu4h63@mail.gmail.com>
        <20101008155319.GC12107@linux-mips.org>
Date:   Fri, 8 Oct 2010 17:55:01 +0200
Message-ID: <AANLkTimYGDoRovYgbReeBihD2nfYFHE_CmwJjv2_=s7v@mail.gmail.com>
Subject: Re: siginfo difference MIPS and other arches
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Fri, Oct 8, 2010 at 5:53 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Oct 08, 2010 at 04:16:33PM +0200, Manuel Lauss wrote:
>
>> current -git build breaks because of upstream commit
>> a337fdac7a5622d1e6547f4b476c14dfe5a2c892, which introduced
>> an unconditional check for siginfo_._sifields._sifault._si_addr_lsb field.
>>
>> Is there a reason why MIPS doesn't use the default siginfo_t structure
>> as other architectures do?
>
> History - the MIPS structure is identical to IRIX.

Does anyone still run IRIX binaries on current linux?
(and Isn't IRIX dead anyway? :)  )

Manuel
