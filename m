Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2011 19:25:58 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:53001 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491876Ab1HLRZw convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Aug 2011 19:25:52 +0200
Received: by yxk8 with SMTP id 8so2263692yxk.36
        for <multiple recipients>; Fri, 12 Aug 2011 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=sFP4HYhmz4pRBgBG/elHwGglTUm0PZvQu5/7+HiCWXo=;
        b=EhZ4yIhPdq4MTJHM+4Uq50MQgNGAIDxsKYlYBNfp1huEaRn9jHTLzVvI34ewzx5u4f
         5VOEUgj26tYMRkVyRnBwFIFXHFrqt1Uz9RdqfEkME7Egbna2M5nc0p23XKJkgMbooIgA
         2WV0AnUNro4ky7PLtmmei9U7lgtq+aZLdwbfk=
Received: by 10.236.157.40 with SMTP id n28mr3865398yhk.47.1313169946115; Fri,
 12 Aug 2011 10:25:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.109.17 with HTTP; Fri, 12 Aug 2011 10:25:26 -0700 (PDT)
In-Reply-To: <20110812163325.GA13018@suse.de>
References: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
 <1313141985-5830-2-git-send-email-manuel.lauss@googlemail.com>
 <20110812160454.GA11898@suse.de> <CAOLZvyFNoxjkU9bcdRtQA9Ey2wnsEN0MbRL3vmNeYhJZHMWoVQ@mail.gmail.com>
 <20110812163325.GA13018@suse.de>
From:   Manuel Lauss <manuel.lauss@googlemail.com>
Date:   Fri, 12 Aug 2011 19:25:26 +0200
Message-ID: <CAOLZvyFh2oHzkbWRqDKhdyV4vg_vovk9nuOBcLLdrA71ZEAnAQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] MIPS: Alchemy: abstract USB block control register access
To:     Greg KH <gregkh@suse.de>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9579

On Fri, Aug 12, 2011 at 6:33 PM, Greg KH <gregkh@suse.de> wrote:
> On Fri, Aug 12, 2011 at 06:20:48PM +0200, Manuel Lauss wrote:
>> On Fri, Aug 12, 2011 at 6:04 PM, Greg KH <gregkh@suse.de> wrote:
>> > On Fri, Aug 12, 2011 at 11:39:38AM +0200, Manuel Lauss wrote:
>> >> Alchemy chips have one or more registers which control access
>> >> to the usb blocks as well as PHY configuration.  I don't want
>> >> the OHCI/EHCI glues to know about the different registers and bits;
>> >> new arch code hides the gory details of USB configuration from them.
>> >>
>> >> Cc: linux-usb@vger.kernel.org
>> >> Cc: Greg Kroah-Hartman <gregkh@suse.de>  (USB glue parts)
>> >> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>> >> ---
>> >> CC'ed Greg for an Ack on the USB glue parts.  I'd like this to go through the
>> >>  MIPS tree since other changes in it depend on it.
>> >
>> > Fine with me on the USB portions, you are just deleting code, which I
>> > like :)
>>
>> Thanks!
>>
>>
>> > But should the "common" USB code really live under arch/mips/alchemy/ ?
>> > The goal is to move driver code out of arch/ and into drivers/.  Why are
>> > you moving stuff backwards here?
>>
>> This is just chip-dependent code for usb block and phy management, which
>> varies wich chip subtype, the OHCI and EHCI controllers are identical on all
>> of them.  At the time moving the chip-depedent code to the other chip-dependent
>> code seemed like a good idea...
>
> But that's what drivers/* is, chip-dependent code.  Please move it there
> instead.
>
> Has the MIPS developers learned nothing from the recent ARM mess? :)

Personally I disagree with some of the results of the "ARM mess", but if that's
what it takes to get things moving forware, so be it.
Give me a few minutes to figure out what to do...

Thanks!
        Manuel
