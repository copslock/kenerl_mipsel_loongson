Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2011 18:21:21 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:42897 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491876Ab1HLQVO convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Aug 2011 18:21:14 +0200
Received: by gwb1 with SMTP id 1so2231920gwb.36
        for <multiple recipients>; Fri, 12 Aug 2011 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=sM9LQNH3ENom3o/OGrsoRWzsC2yBXdzkcWyAdAB6Irw=;
        b=sv8oKsAzuqM/eL+IWD1K/MIPGWd3S4Cq7QKD8Pp1jZ8zOxmIOuibGe4E9ufinJxr0C
         kzUN6TkpD/0XOIEzTxpquvm6w3r0xgylMV9IH8Rb5Bm9/KeHWQH66irjegndEvIxC7Je
         mweBV8awrV6tOXTTU1Ip6UnfRd/pdKcfr0NEI=
Received: by 10.236.157.40 with SMTP id n28mr3621689yhk.47.1313166068297; Fri,
 12 Aug 2011 09:21:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.109.17 with HTTP; Fri, 12 Aug 2011 09:20:48 -0700 (PDT)
In-Reply-To: <20110812160454.GA11898@suse.de>
References: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
 <1313141985-5830-2-git-send-email-manuel.lauss@googlemail.com> <20110812160454.GA11898@suse.de>
From:   Manuel Lauss <manuel.lauss@googlemail.com>
Date:   Fri, 12 Aug 2011 18:20:48 +0200
Message-ID: <CAOLZvyFNoxjkU9bcdRtQA9Ey2wnsEN0MbRL3vmNeYhJZHMWoVQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] MIPS: Alchemy: abstract USB block control register access
To:     Greg KH <gregkh@suse.de>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9511

On Fri, Aug 12, 2011 at 6:04 PM, Greg KH <gregkh@suse.de> wrote:
> On Fri, Aug 12, 2011 at 11:39:38AM +0200, Manuel Lauss wrote:
>> Alchemy chips have one or more registers which control access
>> to the usb blocks as well as PHY configuration.  I don't want
>> the OHCI/EHCI glues to know about the different registers and bits;
>> new arch code hides the gory details of USB configuration from them.
>>
>> Cc: linux-usb@vger.kernel.org
>> Cc: Greg Kroah-Hartman <gregkh@suse.de>  (USB glue parts)
>> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>> ---
>> CC'ed Greg for an Ack on the USB glue parts.  I'd like this to go through the
>>  MIPS tree since other changes in it depend on it.
>
> Fine with me on the USB portions, you are just deleting code, which I
> like :)

Thanks!


> But should the "common" USB code really live under arch/mips/alchemy/ ?
> The goal is to move driver code out of arch/ and into drivers/.  Why are
> you moving stuff backwards here?

This is just chip-dependent code for usb block and phy management, which
varies wich chip subtype, the OHCI and EHCI controllers are identical on all
of them.  At the time moving the chip-depedent code to the other chip-dependent
code seemed like a good idea...


Manuel
