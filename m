Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 07:01:25 +0100 (CET)
Received: from mail-wm0-f46.google.com ([74.125.82.46]:32976 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006154AbbLBGBXiqZV9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 07:01:23 +0100
Received: by wmec201 with SMTP id c201so237168255wme.0
        for <linux-mips@linux-mips.org>; Tue, 01 Dec 2015 22:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mlFtA25vCUgmhV/MvJMT84SvMXx/cJEb+kZGw5AgbHw=;
        b=Oly6od64owCaZZ70zmnwMniHhM/9lXo1dZK+W9B6KfZdqzNMML5aqTaHxjHu6dF0ar
         UnzOT4HrtRUOZa2fGieNXkzRyDcVFm2RduFKwyzTnK62tbhsyiQRJAo8NiIlBwFwPxcb
         7+eiT3aI76KEAK2qabwZewikzV9lXCuGIlj64J0l7WBvGV09J+z0pxDNjCA7uI7qgtCl
         ql4I3Z+EUt4b1C5kxeKLlJ6zzsIrFG1FIea2NqEytnLaFYZCKOldgDaB0vjIZilxTEz9
         CpQ8EBJhz14UNa/pUhANTx/NxE9ncIA5fqUOK01+1h2leOWIhvcEJRf2Oy81FjzwnvKS
         jhHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mlFtA25vCUgmhV/MvJMT84SvMXx/cJEb+kZGw5AgbHw=;
        b=YSBuJs8lYfn53D/dn7g4zG6ysq6oHgLc66HpC/bfRsTDEDu+8ligKhigXjYU3Uq9FA
         x0vRq0E9fYDk1ecF+bjeuD6p1sLewYbFDZeooldJwbCSgKjCtCEBGCDyepJjeyP1T7PW
         PjJioOqUjw8zgA6mw+/ouPQuX9rHCR7ojoW0BZQvs+V/FHIHcQONGkCwgfxfMBQsvzRj
         DlzbBK9OBBO2Ym+jCQHfLOuTKs6MZ7pXbPgWQPvd1qTBPzdiwT6HRVILP/epKOkUbmGH
         HWdBl5SYdZ/iEGZWS5h5KI4qdLdByf4ytdvWjDnG/wVWbCmS4KGPYYxOSePSoVTkAKih
         4b0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-type;
        bh=mlFtA25vCUgmhV/MvJMT84SvMXx/cJEb+kZGw5AgbHw=;
        b=W7NluXtzuF3fbgj9ndiVMX6E6K4YM8XoA5r7h5cjfxgF64wS6PS1K3UFcR4Fu9cElE
         XEbAG4UG1m634Q7reIYPjPAy/p7WOul3B3PYtyWT0VMDUpG8sLtklulwsBUXdozTqyxR
         mjxOZogapkm7bU6iw+oFLchIHnduo61xECrJONYD/9IqyWlxOWd0wzLzRPRiVvhQaFWj
         4FpSt6N3VGBowMsmT+k15ol2yA/Q0keyy5J9gj5xrcQJdJBBjerKekFNHyJumU3Hl2lP
         zR4JOh+m1IwQv1mPg5KlrF1H/7r17WqENz4+PJ6nIFnBDO7dppAdNc2hTbDo0Bjp/3/V
         rN1w==
X-Gm-Message-State: ALoCoQk/G+qZBgHmoP4YUA2QrxGR5Q7bsIRV8e/njNnIZHz3RJhMPEzEOcIflLqk9enA49+Xs+nw
X-Received: by 10.194.133.233 with SMTP id pf9mr2034666wjb.71.1449036077731;
 Tue, 01 Dec 2015 22:01:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.31.135 with HTTP; Tue, 1 Dec 2015 22:00:58 -0800 (PST)
In-Reply-To: <20151201.221356.2176806670215219133.davem@davemloft.net>
References: <1448921155-24764-1-git-send-email-ddecotig@gmail.com>
 <1448921155-24764-4-git-send-email-ddecotig@gmail.com> <20151201.221356.2176806670215219133.davem@davemloft.net>
From:   David Decotigny <ddecotig@gmail.com>
Date:   Tue, 1 Dec 2015 22:00:58 -0800
X-Google-Sender-Auth: zjLG18HoZ7GeyNPQrX5_Ds8cRXI
Message-ID: <CAG88wWbW=yxO0mzauJauEd3W-SuPq3eNGRE+Xe6ATcLKhrPq3A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/17] net: ethtool: add new
 ETHTOOL_GSETTINGS/SSETTINGS API
To:     David Miller <davem@davemloft.net>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Amir Vadai <amirv@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        linux-mips@linux-mips.org, fcoe-devel@open-fcoe.org,
        Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@emulex.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Eyal Perry <eyalpe@mellanox.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        robert.w.love@intel.com,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval.Mintz@qlogic.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <decot@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50269
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

Hello,

There is a set of conversion routines ulong[]<->u32[] to address this
32/64-bit compat issue. Using a u32-based bitmap would require drivers
to handle the u32 bitmaps themselves, this might be confusing,
considering there is a standard bitmap api; and might be error-prone
as well. Plus there is %*pb[l] format that's very helpful for
debugging. That's why I preferred to handle the relative complexity of
u32 bitmaps with the CPP conditionals in the non-driver code that
handles the user/kernel interactions, and drivers can use the standard
bitmap api transparently.

I was currently moving/rewriting the u32/ulong conversion code to
bitmap.{c,h} as Ben Hutchings was suggesting, which should hopefully
make the code more digestible; and could possibly be used for other
user/kernel interfaces. How about I send an updated version with this
solution, and if it's still not right, I'll revisit with either u32[]
everywhere or fixed-size bitmap instead of variable-size as here? Or
maybe another option would be to implement a new u32[]
bitmap_u32.{c,h} api, possibly using a set of macro tricks to share
code with bitmap.{c,h}?

On Tue, Dec 1, 2015 at 7:13 PM, David Miller <davem@davemloft.net> wrote:
> From: David Decotigny <ddecotig@gmail.com>
> Date: Mon, 30 Nov 2015 14:05:41 -0800
>
>> This patch defines a new ETHTOOL_GSETTINGS/SSETTINGS API, handled by
>> the new get_ksettings/set_ksettings callbacks. This API provides
>> support for most legacy ethtool_cmd fields, adds support for larger
>> link mode masks (up to 4064 bits, variable length), and removes
>> ethtool_cmd deprecated fields (transceiver/maxrxpkt/maxtxpkt).
>
> Please do not define the mask using a non-fixed type.  I know it makes
> it easier to use the various bitmap helper routines if you use 'long',
> but here it is clearly superior to use "u32" for the bitmap type and
> do the bit operations by hand if necessary.
>
> Otherwise you have to have all of this ulong size CPP conditional code
> which is incredibly ugly.
>
> Furthermore you have to use fixed sized types anyways so that we don't
> need compat code to deal with 32-bit userspace applications making
> these ethtool calls into a 64-bit kernel.
>
> THanks.
