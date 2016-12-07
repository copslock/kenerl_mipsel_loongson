Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2016 19:47:31 +0100 (CET)
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33568 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993398AbcLGSrWyWcfI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2016 19:47:22 +0100
Received: by mail-qk0-f193.google.com with SMTP id x190so49575357qkb.0
        for <linux-mips@linux-mips.org>; Wed, 07 Dec 2016 10:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3+ywN81BCEBTKTPAlnu7N371EgHwfemmN2OglaIVC+4=;
        b=wvBjfBSTBtY8+IXjqYnz2LFSF0Uk/3LF6GYpMuv+0TX2ojAHSx53CvhKRyYLZJWea+
         EI2dtwpUFOIII1udY//X3I0FaRaoxrc92qHOW6EHY3wcSenIX4XR1tOdEj64tMEpDHWB
         U/DrTMOiW+8mSLSiSCrnE+TOhxsBowRKskmh0tyta0niiGCW8p4pQCsikWfnMn4NVA9a
         5Weo7Z1nrapXQ6WPwMqIxulxn+ZXXOTO2UdEQDtO4nXo6h2uYVEjtwXp/yYnlL/Rkq9o
         EkYxBo/P8c0OANgPY/QJqQYe7s5EgxR6b1heUW7a/dYiR1TtR3NPy3gOAlaTSjOtCLL6
         DjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3+ywN81BCEBTKTPAlnu7N371EgHwfemmN2OglaIVC+4=;
        b=ZM0LdvDLIuCR8h+k/68SE58hCuWfvYwHI76ll31saJEFkeUIp2bIWkNvp+1iLqVptI
         bEpZ8Ecl6AiTpnJtC3DZFTNY9BDCsMtEUqDGsviNoLhxRV/o7X8k9dnA4LclcC6rgIoW
         dT19ewDVbOGyoCxQQHD46N+SAXO0LShyirV8LctsYINgc8nPveujBHZQlPNZMb2wakY3
         sj4E1uQWKt66V+laOM3TCLk7btAblfZaczTByVP9XJhEj6+yqGtQVSkFkh8JnBbNoZg8
         t9LpvytYr5CHcbRaqq/+eZrHQS6KsTxGTWaYVvuuvGpVJopVysaQwOOMY1/WH4uG1GtI
         2bCg==
X-Gm-Message-State: AKaTC03n4cpEolYYebeotvYu72LfU0SAbj58bnbkKfbI8IWklyd+Eu1/SQh77wfBRR4sb4mUl87fiNbPrtR58Q==
X-Received: by 10.55.72.86 with SMTP id v83mr60130462qka.262.1481136437117;
 Wed, 07 Dec 2016 10:47:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.152.197 with HTTP; Wed, 7 Dec 2016 10:47:16 -0800 (PST)
In-Reply-To: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
References: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
From:   Dave Taht <dave.taht@gmail.com>
Date:   Wed, 7 Dec 2016 10:47:16 -0800
Message-ID: <CAA93jw7hcmkcyD=t4VRrQFfHk+n+EkSVgY6KFDq0_-DGpMADYw@mail.gmail.com>
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Netdev <netdev@vger.kernel.org>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <dave.taht@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave.taht@gmail.com
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

The openwrt tree has long contained a set of patches that correct for
unaligned issues throughout the linux network stack.

https://git.lede-project.org/?p=openwrt/source.git;a=blob;f=target/linux/ar71xx/patches-4.4/910-unaligned_access_hacks.patch;h=b4b749e4b9c02a74a9f712a2740d63e554de5c64;hb=ee53a240ac902dc83209008a2671e7fdcf55957a

unaligned access traps in the packet processing path on certain versions of
the mips architecture is horrifically bad. I had kind of hoped these
patches in some form would have made it upstream by now. (or the
arches that have the issue retired, I think it's mostly just mips24k)
