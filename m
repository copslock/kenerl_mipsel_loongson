Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Feb 2012 11:13:30 +0100 (CET)
Received: from mail-we0-f177.google.com ([74.125.82.177]:50779 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903679Ab2BYKN1 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 25 Feb 2012 11:13:27 +0100
Received: by wera10 with SMTP id a10so2461953wer.36
        for <linux-mips@linux-mips.org>; Sat, 25 Feb 2012 02:13:21 -0800 (PST)
Received-SPF: pass (google.com: domain of geert.uytterhoeven@gmail.com designates 10.180.89.71 as permitted sender) client-ip=10.180.89.71;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 10.180.89.71 as permitted sender) smtp.mail=geert.uytterhoeven@gmail.com; dkim=pass header.i=geert.uytterhoeven@gmail.com
Received: from mr.google.com ([10.180.89.71])
        by 10.180.89.71 with SMTP id bm7mr2946384wib.20.1330164801499 (num_hops = 1);
        Sat, 25 Feb 2012 02:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FTo18kF83qd2ZDn8e2WM7/LVC5vCM7flxBkElmQKbL8=;
        b=Djb2cvWHDr0mB1R9I+E5VZYKvIB1jhAn+WYu1c3XJDMw1IizIe7b4ll5OhMRby8JUU
         RqKUYTXnDaqc6RjUbI1of85kTEaojeRmtzlASrjpv/8Oq+VEGxg20av4A+Dm+POK4yiH
         y/ZAd5eHhD/tB5D1BE88VS3R7aFvoe99lMeN8=
MIME-Version: 1.0
Received: by 10.180.89.71 with SMTP id bm7mr2305867wib.20.1330164801383; Sat,
 25 Feb 2012 02:13:21 -0800 (PST)
Received: by 10.223.94.66 with HTTP; Sat, 25 Feb 2012 02:13:21 -0800 (PST)
In-Reply-To: <CAHXqBFK=u+MchBn=D31h6nhp-R9GTNbaC18QJA937zjXc60UQw@mail.gmail.com>
References: <1330099282-4588-1-git-send-email-danny.kukawka@bisect.de>
        <CAHXqBFK=u+MchBn=D31h6nhp-R9GTNbaC18QJA937zjXc60UQw@mail.gmail.com>
Date:   Sat, 25 Feb 2012 11:13:21 +0100
X-Google-Sender-Auth: 83VwX2zntM4V_D5Pq08rAC93pKU
Message-ID: <CAMuHMdVZ8eVdRLtsq23XCLtA4wU7cTc-mLebAQ4QzO=gkuNMWQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] Part 2: check given MAC address, if invalid return -EADDRNOTAVAIL
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>
Cc:     Danny Kukawka <danny.kukawka@bisect.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        Guo-Fu Tseng <cooldavid@cooldavid.org>,
        Petko Manolov <petkan@users.sourceforge.net>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "John W. Linville" <linville@tuxdriver.com>, linux390@de.ibm.com,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Danny Kukawka <dkukawka@suse.de>,
        Stephen Hemminger <shemminger@vyatta.com>,
        Joe Perches <joe@perches.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jiri Pirko <jpirko@redhat.com>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 32552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

2012/2/24 Michał Mirosław <mirqus@gmail.com>:
> 2012/2/24 Danny Kukawka <danny.kukawka@bisect.de>:
>> Second Part of series patches to unifiy the return value of
>> .ndo_set_mac_address if the given address isn't valid.
>>
>> These changes check if a given (MAC) address is valid in
>> .ndo_set_mac_address, if invalid return -EADDRNOTAVAIL
>> as eth_mac_addr() already does if is_valid_ether_addr() fails.
>
> Why not just fix dev_set_mac_address() and make do_setlink() use that?

BTW, it's also called from dev_set_mac_address().

> Checks are specific to address family, not device model I assume.

Indeed, why can't this be done in one single place, instead of sprinkling these
checks over all drivers, missing all out-of-tree (note: I don't care) and all
soon-to-be-submitted drivers?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
