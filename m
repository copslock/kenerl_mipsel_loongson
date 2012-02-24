Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 18:59:37 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:52406 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903759Ab2BXR7b convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Feb 2012 18:59:31 +0100
Received: by iaky10 with SMTP id y10so1315821iak.36
        for <linux-mips@linux-mips.org>; Fri, 24 Feb 2012 09:59:24 -0800 (PST)
Received-SPF: pass (google.com: domain of mirqus@gmail.com designates 10.50.193.195 as permitted sender) client-ip=10.50.193.195;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of mirqus@gmail.com designates 10.50.193.195 as permitted sender) smtp.mail=mirqus@gmail.com; dkim=pass header.i=mirqus@gmail.com
Received: from mr.google.com ([10.50.193.195])
        by 10.50.193.195 with SMTP id hq3mr4667020igc.18.1330106364453 (num_hops = 1);
        Fri, 24 Feb 2012 09:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HNn6H3hm4G/LuHJaxW51hiS54zqmUVFTWgoL8/Qwmp4=;
        b=uRweyO3pqeGxoxfdvseACLmdNBChiN19x/DDO3lfFzzkC4EHvlfgZClu3ED0MUHxSt
         7crUfxu+uCPklEWZyUG9PVSYoVFz+4VfaBNEvTnjnXQgxZ7lplyVpX11gTcRpx5wNKLh
         TWLgXo2nKR4va2ROXG7Wd2IGRwoVUEpPi/2uc=
Received: by 10.50.193.195 with SMTP id hq3mr3691367igc.18.1330106364352; Fri,
 24 Feb 2012 09:59:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.231.43.13 with HTTP; Fri, 24 Feb 2012 09:59:04 -0800 (PST)
In-Reply-To: <1330099282-4588-1-git-send-email-danny.kukawka@bisect.de>
References: <1330099282-4588-1-git-send-email-danny.kukawka@bisect.de>
From:   =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date:   Fri, 24 Feb 2012 18:59:04 +0100
Message-ID: <CAHXqBFK=u+MchBn=D31h6nhp-R9GTNbaC18QJA937zjXc60UQw@mail.gmail.com>
Subject: Re: [PATCH 00/12] Part 2: check given MAC address, if invalid return -EADDRNOTAVAIL
To:     Danny Kukawka <danny.kukawka@bisect.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
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
X-archive-position: 32551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mirqus@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

2012/2/24 Danny Kukawka <danny.kukawka@bisect.de>:
> Second Part of series patches to unifiy the return value of
> .ndo_set_mac_address if the given address isn't valid.
>
> These changes check if a given (MAC) address is valid in
> .ndo_set_mac_address, if invalid return -EADDRNOTAVAIL
> as eth_mac_addr() already does if is_valid_ether_addr() fails.

Why not just fix dev_set_mac_address() and make do_setlink() use that?
Checks are specific to address family, not device model I assume.

Best Regards,
Michał Mirosław
