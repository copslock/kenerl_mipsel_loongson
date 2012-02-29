Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Feb 2012 08:04:32 +0100 (CET)
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:53567 "EHLO
        wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903555Ab2B2HEZ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Feb 2012 08:04:25 +0100
Received: from nrbg-4d077c62.pool.mediaways.net ([77.7.124.98] helo=hp-compaq-2710p-wlan.fritz.box); authenticated
        by wp188.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        id 1S2dZn-0003ie-JD; Wed, 29 Feb 2012 08:03:51 +0100
From:   Danny Kukawka <danny.kukawka@bisect.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/12] Part 2: check given MAC address, if invalid return -EADDRNOTAVAIL
Date:   Wed, 29 Feb 2012 08:02:49 +0100
User-Agent: KMail/1.9.10
Cc:     =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirqus@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        "Guo-Fu Tseng" <cooldavid@cooldavid.org>,
        Petko Manolov <petkan@users.sourceforge.net>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "John W. Linville" <linville@tuxdriver.com>, linux390@de.ibm.com,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Stephen Hemminger <shemminger@vyatta.com>,
        Joe Perches <joe@perches.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jiri Pirko <jpirko@redhat.com>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-mips@linux-mips.org
References: <1330099282-4588-1-git-send-email-danny.kukawka@bisect.de> <CAHXqBFK=u+MchBn=D31h6nhp-R9GTNbaC18QJA937zjXc60UQw@mail.gmail.com> <CAMuHMdVZ8eVdRLtsq23XCLtA4wU7cTc-mLebAQ4QzO=gkuNMWQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVZ8eVdRLtsq23XCLtA4wU7cTc-mLebAQ4QzO=gkuNMWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <201202290802.52234.danny.kukawka@bisect.de>
X-bounce-key: webpack.hosteurope.de;danny.kukawka@bisect.de;1330499065;d1620e5d;
X-archive-position: 32577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danny.kukawka@bisect.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Samstag, 25. Februar 2012, Geert Uytterhoeven wrote:
> 2012/2/24 Michał Mirosław <mirqus@gmail.com>:
> > 2012/2/24 Danny Kukawka <danny.kukawka@bisect.de>:
> >> Second Part of series patches to unifiy the return value of
> >> .ndo_set_mac_address if the given address isn't valid.
> >>
> >> These changes check if a given (MAC) address is valid in
> >> .ndo_set_mac_address, if invalid return -EADDRNOTAVAIL
> >> as eth_mac_addr() already does if is_valid_ether_addr() fails.
> >
> > Why not just fix dev_set_mac_address() and make do_setlink() use that?
>
> BTW, it's also called from dev_set_mac_address().
>
> > Checks are specific to address family, not device model I assume.
>
> Indeed, why can't this be done in one single place, instead of sprinkling
> these checks over all drivers, missing all out-of-tree (note: I don't care)
> and all soon-to-be-submitted drivers?

Since the .ndo_set_mac_address functions are used by some drivers internally 
too, you may get some new checks on other places. But I'll take a look at it.

Danny
