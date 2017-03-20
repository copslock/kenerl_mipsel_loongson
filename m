Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2017 11:42:55 +0100 (CET)
Received: from mail-ot0-x244.google.com ([IPv6:2607:f8b0:4003:c0f::244]:34204
        "EHLO mail-ot0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993873AbdCTKmtA6Lpl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Mar 2017 11:42:49 +0100
Received: by mail-ot0-x244.google.com with SMTP id x37so18789785ota.1;
        Mon, 20 Mar 2017 03:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eEWplzz35GyjVDpVuYCkajz1OJjc811aV7mAQGgl21c=;
        b=VNMF45//1eYXgvdwYpT5EQ42MKf4ajGrRVXGgiHwtvkmNEGUIEZRFBFoOLD4waomf7
         uQDhHCc9otQ92wuOKM3k87Yx3mNVnRysMxkVil+KXEIfNrFpCOjpmNUoJQKVrL+Tr1dn
         SYQr9CYzDpGoJyS/ta8UmDryQ2Lh1KZzVGrVFziuXCAmEpQ5A/EvZP4378Q/PQpS/M0r
         odDBzarZyX7wXTiKuPrNmb5nkgJ1oshIrC7hF3euEIuzLFLfHIDQD1xrSfa/6+aHDn3K
         jguUMcL3nc9ommKLwvNcqh3A1nrhRhHAgeh2zlnWc7qdxYi73Nz6Q/LBi+rUBoV+g6iv
         Bveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=eEWplzz35GyjVDpVuYCkajz1OJjc811aV7mAQGgl21c=;
        b=Y38IVvls9UZ5hjblTv56x4xpgjrdtTBqm14QMrIhUeVVaqa3sG4O6OoWqd4JhbZ3oM
         3uSOl8h9F1b4pT0RUVIFu9Pr9qMtSkDTznhchqfbLyaImdPSEKsUpOM4mc/NQJV74AQI
         pLHNGUZiU7l8oR/Wpg3miSmsIk5Al1O7JYMkRsw2F+gW4pz45YAnB8HT/5szlvI031pG
         bP0ilmRxLVkhz7JHh0dHkO42tiGOymFaA2MPgterpJFNX6UxIf/1tzPgBoB5FcO2wgah
         C5MDOEMj+d4sXWeEJArTrY53PEyKSgZ8h7xiDn2cXI/xI+E0KIx3HzPQXCivkq2Zu8kV
         DhMw==
X-Gm-Message-State: AFeK/H3wYheukazBkqkNx/YvmjDldIBvGEg66sXMGdhPIIqg/nYp5MLitbzS/qSzuRgqQKAx6vUSYEUsY3wjew==
X-Received: by 10.157.37.203 with SMTP id q69mr14442702ota.255.1490006560045;
 Mon, 20 Mar 2017 03:42:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.5.145 with HTTP; Mon, 20 Mar 2017 03:42:39 -0700 (PDT)
In-Reply-To: <20170320103052.GB3047@kroah.com>
References: <20170316142906.685052998@linuxfoundation.org> <20170316142906.994447562@linuxfoundation.org>
 <1489939516.2852.71.camel@decadent.org.uk> <20170320103052.GB3047@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Mar 2017 11:42:39 +0100
X-Google-Sender-Auth: brZKeQu-shVSrEd1H-FzwzxdLgI
Message-ID: <CAK8P3a2Ud6iVEumhSzBpWwKN5SiuYOGSBT1ZAD=UiC8RNTv=SA@mail.gmail.com>
Subject: Re: [PATCH 4.4 04/35] MIPS: Update defconfigs for NF_CT_PROTO_DCCP/UDPLITE
 change
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Mon, Mar 20, 2017 at 11:30 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sun, Mar 19, 2017 at 04:05:16PM +0000, Ben Hutchings wrote:
>> On Thu, 2017-03-16 at 23:29 +0900, Greg Kroah-Hartman wrote:
>> > 4.4-stable review patch.  If anyone has any objections, please let me know.
>> >
>> > ------------------
>> >
>> > From: Arnd Bergmann <arnd@arndb.de>
>> >
>> > commit 9ddc16ad8e0bc7742fc96d5aaabc5b8698512cd1 upstream.
>> >
>> > In linux-4.10-rc, NF_CT_PROTO_UDPLITE and NF_CT_PROTO_DCCP are bool
>> > symbols instead of tristate, and kernelci.org reports a bunch of
>> > warnings for this, like:
>> >
>> > arch/mips/configs/malta_kvm_guest_defconfig:63:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE
>> > arch/mips/configs/malta_defconfig:62:warning: symbol value 'm' invalid for NF_CT_PROTO_DCCP
>> > arch/mips/configs/malta_defconfig:63:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE
>> > arch/mips/configs/ip22_defconfig:70:warning: symbol value 'm' invalid for NF_CT_PROTO_DCCP
>> > arch/mips/configs/ip22_defconfig:71:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE
>> >
>> > This changes all the MIPS defconfigs with these symbols to have them
>> > built-in.
>> >
>> > Fixes: 9b91c96c5d1f ("netfilter: conntrack: built-in support for UDPlite")
>> > Fixes: c51d39010a1b ("netfilter: conntrack: built-in support for DCCP")
>> [...]
>>
>> I don't think this was needed for 4.4 or 4.9, as those symbols were
>> still tristate type.
>
> I don't know, Arnd was the one that reported it to me.
>
> Arnd?

I thought I had only reported it for the v4.10-stable tree. I was a bit vague
about which of the ones I reported were needed on older trees as well,
but the changelog text is fairly specific.

      Arnd
