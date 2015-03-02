Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Mar 2015 19:58:08 +0100 (CET)
Received: from mail-qa0-f48.google.com ([209.85.216.48]:60816 "EHLO
        mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007881AbbCBS6G5A3Si (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Mar 2015 19:58:06 +0100
Received: by mail-qa0-f48.google.com with SMTP id dc16so24361786qab.7
        for <linux-mips@linux-mips.org>; Mon, 02 Mar 2015 10:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wsNrzndLKpDjE1a3xa85+3AE3lfMR3teqTFBI5eLcnM=;
        b=JE/6ZxtjOPWQQRy//+PyL6/T01wcXm+X/PNzxejfG7dr6F5aSZ6/E1nbDZd+BkgJH1
         bx4a8ZghwOZ6SKKcAT+h53b9lZF6sA6xzNrmmx3lps5W3C0szXls7t4utRasM0qJRHC7
         92xSXLtPCnP8h07I9NF/QFzG3PI106S4kHyDpgGhW6XQbN2uKfiyUZAi4I/RYSXGyHP2
         BNKJxKYyabyTvZ5g2rXwf+0gQ+21GEHimw48UAZI9E8RuUv55FVbrZBST9xkRS9RpbL8
         noJ+lND/FtEJjFXLC/phee8k45gt5I/uzV35oyXmXMMPxQRmWaElpFEzHKNn86ijLP/O
         fYEA==
X-Received: by 10.140.44.134 with SMTP id g6mr50370447qga.85.1425322681595;
 Mon, 02 Mar 2015 10:58:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.43.10 with HTTP; Mon, 2 Mar 2015 10:57:41 -0800 (PST)
In-Reply-To: <54F4A1B6.8030701@hurleysoftware.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
 <1416872182-6440-4-git-send-email-cernekee@gmail.com> <54F4624D.6000909@hurleysoftware.com>
 <CAJiQ=7DQ6CRWddii_9HZqH0a_1ixos6FBQRzb+HM+YAh1jmkBA@mail.gmail.com>
 <54F48B03.5040205@hurleysoftware.com> <CAJiQ=7CKE5Nw=maewN_ChkySh1NReoUnddLO_ohOJQfwo_FXAg@mail.gmail.com>
 <54F4A1B6.8030701@hurleysoftware.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 2 Mar 2015 10:57:41 -0800
Message-ID: <CAJiQ=7CDAifvcMkrAsseXHHC_GGMJg-+UiWVY03JAzDqSFzi+g@mail.gmail.com>
Subject: Re: [PATCH V3 3/7] of: Document {little,big,native}-endian bindings
To:     Peter Hurley <peter@hurleysoftware.com>
Cc:     Rob Herring <robh@kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Mon, Mar 2, 2015 at 9:45 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> This doesn't change the behavior of pre-existing drivers that
>> implement the *-endian properties in a different way.  There are not
>> many of these drivers and they can be documented as special cases.
>
> Yeah, ok, as long as there's no expectation that existing drivers
> meet this criteria when they add big-endian support.

The intention is to make it easy for existing drivers with LE register
accesses (i.e. mostly drivers taken from an x86 + PCI environment) to
work on systems with native to BE register accesses.  8250 and USB are
the first two examples of this.

>>> It's exactly this kind of stuff that prompted Jonathan Corbet's article,
>>> "Device trees as ABI"  http://lwn.net/Articles/561462
>>>
>>> Why not leave the default unspecified?
>>
>> The document aims to provide a consistent way of handling DT
>> endianness properties across (compliant) drivers.  It is confusing if
>> one new driver defaults to little-endian, and another new driver
>> defaults to native-endian.
>
> Ok. How many 4.0 driver + DT submissions that are native-endian are
> declaring this binding?
>
>
>> And since most of the commonly used drivers already implement
>> little-endian MMIO accesses, that is the default.  My personal
>> preference would have been native-endian since that seems more common
>> on the hardware side, but defaulting to little-endian prevents
>> breaking the device tree "ABI" on existing systems.
>
> That was basically my point; there's no way to meet these goals
> for existing, native-endian drivers without breakage (just as there
> would have been no way if native-endian had been the default).

I am not aware of any cases where the new binding needs to be applied
to a driver that is currently native-endian.  Grepping through the
tree for __raw_readl, I see lots of SoC-specific drivers but not a lot
of generic drivers shared by different types of platforms.  Most of
the time we can assume that whoever wrote the driver for their SoC has
figured out the endian situation.  But obviously there could be
exceptions, e.g. new chips using a different endian mode with the same
hardware block.
