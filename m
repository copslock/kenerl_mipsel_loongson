Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 01:27:13 +0100 (CET)
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34188 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014063AbbLQA1Lbot0E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 01:27:11 +0100
Received: by mail-wm0-f47.google.com with SMTP id l126so1717124wml.1
        for <linux-mips@linux-mips.org>; Wed, 16 Dec 2015 16:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=MxE0gswEj1rGyDU8eONVnOaTtBYfuAMcMoz/H80Rvl0=;
        b=kbJB2yH5mzbV0b3aGqAnbw+Ij6gGw7WDBGvwx1QM/P+ekQRhch5PnnJuN6g/lkoxjr
         xBAVafD4etpMFU1Wghu/HRbKiTfvfybsfOx3/7mk1fZ9A7Fs0fG0mtb3ajXCWZK0ivn3
         fJjzyWK/LfGO38SW0CkX+YZIzkDgcLEo+pbqjz8XYqEZGTBA1IaBAavtYVkPSt7KnUUf
         pSoi9KFL8ku5U5c4GafaH3R8X4ORaLjaF9pihGDhIc8Khaau41CcGiZ1XRqonXxCVsuL
         2H+Fv6B0U/9WI8jUArvDraMuZ16ZM//bUFHnD4MriY7BhHpmaVbtTdfYoWIpFTsPAZ6U
         mxTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=MxE0gswEj1rGyDU8eONVnOaTtBYfuAMcMoz/H80Rvl0=;
        b=IWqIZKPKNkxZ5vd7z2zE4hgIqg3/G0ftvH5suTLgaz2Ev79N6fHsWkLeXV/IJKYY6H
         YI9kfo9zRgwZdHc5oRPKUUI/7bMEJB9++C9KPYaA1Rpv5DIczTQeU4ViJUVqkqlDhufl
         Q4me104JdWBZaPLqcYoQCJQnGrnLd2O+8UmG5sD6RlNmdwVlGZnxDmlkL2q2IyaZzBdK
         p6v054WGPBkLZ+MNNPan8Aq3snvzHFP2YZkG0LNsXLesSKm0bP2iWGcFS/9tAw8j5kpw
         dPNJKUm0jBtANncEgpXVYBBl443aqS1DP9sw1KemyzxTnLaRO1HUvsZw8PCxQthaeNT8
         e40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-type;
        bh=MxE0gswEj1rGyDU8eONVnOaTtBYfuAMcMoz/H80Rvl0=;
        b=WVfkKC4npTclz+6FueBtQkPdflHg88dLQRl/ULMDIF70p8ow5qwwjzxouIqaYDSNFy
         ZKvPyJMb1jFTnp/oSv9qUjwy71zL8GlHitRdMGL5pFElXpc9GRFgWF3XNUl6957P2pZp
         qowCfw55y2GWTs8p7a2qhjj0w5CbmhIayp+V65sjMjhNI/Q1ET0YMqownGMUwlDnCmtp
         sO+Niz3hrJ7+L7kHQGZ77r+7EC8iFF1BaQkNl8Z0UV+Y6tG3V7nvzX0zTrdhafmw2oWa
         HnWbJqt+mkhKvvrYZecS4CrcgSZtm8/xg+PMzYsRhc8jVT0NcHX7PLUi1fRq+aKgzqtq
         S9rA==
X-Gm-Message-State: ALoCoQlTCb2a63hIpkgYrhI7+QlevKQlDQ2aXwm6im8SR0dZLaZHbj6ZoPU0Zcs6cJGEF3NLN2hbFsdvXClZWhEOnCI9Ofp2x4RPriVbymkaTdKH7kBZrP8=
X-Received: by 10.194.243.6 with SMTP id wu6mr52688985wjc.14.1450312026230;
 Wed, 16 Dec 2015 16:27:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.129.20 with HTTP; Wed, 16 Dec 2015 16:26:46 -0800 (PST)
In-Reply-To: <20151216.113814.2025166082777387327.davem@davemloft.net>
References: <1450127046-4573-1-git-send-email-ddecotig@gmail.com>
 <1450127046-4573-6-git-send-email-ddecotig@gmail.com> <20151216.113814.2025166082777387327.davem@davemloft.net>
From:   David Decotigny <ddecotig@gmail.com>
Date:   Wed, 16 Dec 2015 16:26:46 -0800
X-Google-Sender-Auth: GiWvHt8SvHElV3k6-nLouLPW5QY
Message-ID: <CAG88wWa85iPJMYQtE4o_Cx3+-A-m_+wqxf2PWYTcpOvB=8_d8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 05/19] net: ethtool: add new
 ETHTOOL_GSETTINGS/SSETTINGS API
To:     David Miller <davem@davemloft.net>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        linux-mips@linux-mips.org, fcoe-devel@open-fcoe.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@emulex.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Return-Path: <decot@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddecotig@gmail.com
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

Thanks David: you are right, we should copy back sizeof(struct
ethtool_settings) in that case and not sizeof(usettings). Sorry about
that, will fix for v6.

a few questions before sending update:
 - is this handshake reasonable? or should we have an ethtool cmd
dedicated to this kind of handshake, or should we hardcode bitmap
length once and for all (ie. 128 instead of 32 today)?
 - is it ok to have the u32[] api part of bitmap.h? I was assuming it
could be used for other ioctl/syscalls outside ethtool... but maybe
this is being too pretentious and we could keep this internal to
net/core?
 - struct inheritance is used to have the link mode bitmaps
piggybacked at end the public struct ethtool_settings. hence this
"parent" field. I'm not super proud of this, but I find relying on the
compiler more comfortable. could revise my position with a
constructor+accessors macros if you think it's preferred.


On Wed, Dec 16, 2015 at 8:38 AM, David Miller <davem@davemloft.net> wrote:
> From: David Decotigny <ddecotig@gmail.com>
> Date: Mon, 14 Dec 2015 13:03:52 -0800
>
>> +static int ethtool_get_ksettings(struct net_device *dev, void __user *useraddr)
>> +{
>  ...
>> +     if (__ETHTOOL_LINK_MODE_MASK_NU32
>> +         != ksettings.parent.link_mode_masks_nwords) {
>> +             /* wrong link mode nbits requested */
>> +             memset(&ksettings, 0, sizeof(ksettings));
>> +             /* keep cmd field reset to 0 */
>> +             /* send back number of words required as negative val */
>> +             compiletime_assert(__ETHTOOL_LINK_MODE_MASK_NU32 <= S8_MAX,
>> +                                "need too many bits for link modes!");
>> +             ksettings.parent.link_mode_masks_nwords
>> +                     = -((s8)__ETHTOOL_LINK_MODE_MASK_NU32);
>
> I'm trying to understand how this can work.
>
> Supposedly, the link_mode_masks_nwords field is there so that we can
> add new link modes yet still work with tools built against any
> particular link mode list in the UAPI header files.
>
> But here you're forcing the value of link_mode_masks_nwords and then
> copying that amount back to userspace.  If the user allocated less
> space than the the link mode list in the kernel supports, we will
> overwrite past the end of the user's usettings object.
>
> You cannot unconditionally copy sizeof(usettings) back to the user,
> as store_ksettings_for_user() will do.
>
> I think you have to truncate here, copying only the array elements the
> user's structure actually has space for.  That's the only way this can
> work.
