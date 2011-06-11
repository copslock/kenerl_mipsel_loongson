Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 01:03:59 +0200 (CEST)
Received: from shards.monkeyblade.net ([198.137.202.13]:37522 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491800Ab1FKXDy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 01:03:54 +0200
Received: from localhost (74-93-104-100-Washington.hfc.comcastbusiness.net [74.93.104.100])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p5BN1JtK025681
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 11 Jun 2011 16:01:19 -0700
Date:   Sat, 11 Jun 2011 16:01:19 -0700 (PDT)
Message-Id: <20110611.160119.176399204911265689.davem@davemloft.net>
To:     ralf@linux-mips.org
Cc:     jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org,
        avorontsov@mvista.com, cmetcalf@tilera.com, ccross@android.com,
        eric.y.miao@gmail.com, konkers@android.com, gxt@mprc.pku.edu.cn,
        hpa@zytor.com, kaloz@openwrt.org, mingo@redhat.com,
        ink@jurassic.park.msu.ru, khc@pm.waw.pl, kernel@wantstofly.org,
        mattst88@gmail.com, nico@fluxnic.net, olof@lixom.net,
        lethal@linux-sh.org, rth@twiddle.net, linux@arm.linux.org.uk,
        tglx@linutronix.de, akpm@linux-foundation.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] PCI: Make the struct pci_dev * argument of
 pci_fixup_irqs const.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20110610143021.GA26043@linux-mips.org>
References: <20110610143021.GA26043@linux-mips.org>
X-Mailer: Mew version 6.3 on Emacs 23.2 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Sat, 11 Jun 2011 16:01:25 -0700 (PDT)
X-archive-position: 30339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9936

From: Ralf Baechle <ralf@linux-mips.org>
Date: Fri, 10 Jun 2011 15:30:21 +0100

> Aside of the usual motivation for constification,  this function has a
> history of being abused a hook for interrupt and other fixups so I turned
> this function const ages ago in the MIPS code but it should be done
> treewide.
> 
> Due to function pointer passing in varous places a few other functions
> had to be constified as well.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: David S. Miller <davem@davemloft.net>
