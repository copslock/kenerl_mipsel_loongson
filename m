Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 14:41:29 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:42939 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492343Ab0FAMl0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Jun 2010 14:41:26 +0200
Received: by pvb32 with SMTP id 32so315436pvb.36
        for <multiple recipients>; Tue, 01 Jun 2010 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=0dhJQ0YSJZUrzGK930jFriY0BmyXHCur8EFPHilL0kI=;
        b=Hud5kIHOgJZ/7SImi25O1nYriFmvhEmuslBaQDRLibZRqE+Tw3+wkB1NW2ktZc+SnO
         wC2eoOlNvZOQi4apSj/7IZhHeAjIjBBHSc5Tsufd7M8iek3eu+E9Tis7rUopZdJhJmWq
         YZB5hcxGm4HslOGLoytFL5Ja+72SHLgLKVn6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Nqoacu3v1c2uvCPpskq4lneIoUmsnzbZwTKu5vhMLd+8mx8AI+WXn4NcxsIvm9/5Yz
         cEy2snsZl6OwElnh9vXh9hCVCqaCtqwJvHVr8KxCirqbiZyz08FNruz5hYwOdHs4vLFL
         uFe7LCnr613eA/bWdgR1W0zS8zn91YKSYxiS0=
MIME-Version: 1.0
Received: by 10.142.10.39 with SMTP id 39mr4044802wfj.63.1275396078512; Tue, 
        01 Jun 2010 05:41:18 -0700 (PDT)
Received: by 10.142.179.7 with HTTP; Tue, 1 Jun 2010 05:41:18 -0700 (PDT)
In-Reply-To: <AANLkTikxHLWSoUFQItXnULP-pF1-us7FgAP_GkkoCMeO@mail.gmail.com>
References: <1275388144-5998-1-git-send-email-wuzhangjin@gmail.com>
        <1275388144-5998-2-git-send-email-wuzhangjin@gmail.com>
        <20100601105606.GD2519@chipmunk>
        <AANLkTikxHLWSoUFQItXnULP-pF1-us7FgAP_GkkoCMeO@mail.gmail.com>
Date:   Tue, 1 Jun 2010 20:41:18 +0800
Message-ID: <AANLkTila1Lb360v9XaeKJxBqcPR6wZ_kIbEm7k_23UFs@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Clean up the calculation of VMLINUZ_LOAD_ADDRESS
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Alexander Clouter <alex@digriz.org.uk>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 26960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 322

Hi,

[...]
>> I am also
>> not too confident 'unsigned long long' is a great idea...maybe 'u64' or
>> 'uint64_t' if you are relying on C99[1]?
>
> good idea, which c header file defines u64 and uint64_t?
>

Just found it in <stdint.h>

Regards,
Wu Zhangjin
