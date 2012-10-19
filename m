Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2012 09:04:26 +0200 (CEST)
Received: from mail-ea0-f177.google.com ([209.85.215.177]:65270 "EHLO
        mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823121Ab2JSHEZkVl03 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Oct 2012 09:04:25 +0200
Received: by mail-ea0-f177.google.com with SMTP id n13so39561eaa.36
        for <linux-mips@linux-mips.org>; Fri, 19 Oct 2012 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=z9IYakRRuaFD7C90rUVp7JLEdzYtCqYxlGvAWd8/cZk=;
        b=oA9o1jQgEt4eButXQGpoR8a1WGgmRCclEanLv7BkHVcv0+Z8ziVkCU/QyWPX89l5Cn
         4q5hSbiFs/Dd0wTaQVd61LpK76MrZGFiLMgvXHxBAOt/lRVHnM5VEqAxZWtj6MESVBBv
         w/elzVRle9aBoySI97wuUpHpqS/1bjouont1eOVd3QgKSkzgKFRImDrDZHyfcuxuSSu8
         UBNjT7eIElZ0NbaGLdUttlZ54iWx9fGMV4emuiikVIi/h4oUG0UzpXVge0xau31neKOp
         KylhtR6EqcgE6EvSUPVRObmFLEFixCHqLa1yJQ6kP7Ti6J/VOQgTF9J8sm2NMkgANplW
         dX4w==
Received: by 10.14.214.2 with SMTP id b2mr383585eep.32.1350630260149;
        Fri, 19 Oct 2012 00:04:20 -0700 (PDT)
Received: from [172.28.91.53] ([172.28.91.53])
        by mx.google.com with ESMTPS id i1sm1090085eeo.8.2012.10.19.00.04.16
        (version=SSLv3 cipher=OTHER);
        Fri, 19 Oct 2012 00:04:19 -0700 (PDT)
Subject: Re: [PATCH net-next 00/21] treewide: Use consistent api style for
 address testing
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     davinci-linux-open-source@linux.davincidsp.com,
        linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
        linuxppc-dev@lists.ozlabs.org, e1000-devel@lists.sourceforge.net,
        cbe-oss-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
        wimax@linuxwimax.org, linux-wireless@vger.kernel.org,
        ath9k-devel@lists.ath9k.org, b43-dev@lists.infradead.org,
        users@rt2x00.serialmonkey.com, devicetree-discuss@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, devel@open-fcoe.org,
        linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org,
        b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux-foundation.org,
        netfilter-devel@vger.kernel.org, netfilter@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        dev@openvswitch.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        brcm80211-dev-list@broadcom.com, devel@driverdev.osuosl.org
In-Reply-To: <cover.1350618006.git.joe@perches.com>
References: <cover.1350618006.git.joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 19 Oct 2012 09:04:14 +0200
Message-ID: <1350630254.2293.183.camel@edumazet-glaptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-archive-position: 34727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric.dumazet@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 2012-10-18 at 20:55 -0700, Joe Perches wrote:
> ethernet, ipv4, and ipv6 address testing uses 3 different api naming styles.
> 
> ethernet uses:	is_<foo>_ether_addr
> ipv4 uses:	ipv4_is_<foo>
> ipv6 uses:	ipv6_addr_<foo>
> 
> Standardize on the ipv6 style of <prefix>_addr_<type> to reduce
> the number of styles to remember.
> 
> The new consistent styles are:
> 
> eth_addr_<foo>(const u8 *)
> ipv4_addr_<foo>(__be32)
> ipv6_addr_<foo>(const struct in6_addr *)
> 
> Add temporary backward compatibility #defines for the old names too.
> 
> Joe Perches (21):
>   etherdevice: Rename is_<foo>_ether_addr tests to eth_addr_<foo>
>   net: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   arch: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   wireless: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   drivers: net: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   staging: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   infiniband: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   scsi: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   of: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   s390: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   usb: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   uwb: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   Documentation: networking: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   llc_if.h: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   in.h: Rename ipv4_is_<foo> functions to ipv4_addr_<foo>
>   net: Convert ipv4_is_<foo> uses to ipv4_addr_<foo>
>   infiniband: Convert ipv4_is_<foo> uses to ipv4_addr_<foo>
>   ath6kl: Convert ipv4_is_<foo> uses to ipv4_addr_<foo>
>   parisc: Convert ipv4_is_<foo> uses to ipv4_addr_<foo>
>   lockd: Convert ipv4_is_<foo> uses to ipv4_addr_<foo>
>   sctp: Convert ipv4_is_<foo> uses to ipv4_addr_<foo>

Yes they are some names discrepancies, thats a big deal.

And we have alloc_skb() / kfree_skb() / skb_clone() 

Why not skb_alloc() / skb_free() / skb_clone() ?

Some people actually know current code by name of functions, they dont
want to change their mind and having to grep include files and git log
to learn the new names of an old function, especially when traveling and
using a laptop.

Sure, when we want to use eth_random_addr(), a grep into include files
to check if its still the right name (old one was random_ether_addr())
is OK because we dont use this one often.

If you think about it, eth_random_addr() was not the perfect name.

Think about all the documentation you can find outside of kernel tree,
RFC and things like that, copy/pasting some linux kernel code.

This kind of changes make our life more difficult, when we have to
backport patches or rebase code, or even perform some searches to find
prior issues/discussions.

Life of a kernel developer is not only dealing with latest Linus (or
-next) tree, and using automatic 'tools'.

Thats a real pain for me at least.
