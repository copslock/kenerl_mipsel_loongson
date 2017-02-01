Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2017 10:55:48 +0100 (CET)
Received: from mo3.mail-out.ovh.net ([178.32.228.3]:53861 "EHLO
        mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992186AbdBAJzkwdZtp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2017 10:55:40 +0100
Received: from player690.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id CE95A9DA23
        for <linux-mips@linux-mips.org>; Wed,  1 Feb 2017 10:55:39 +0100 (CET)
Received: from linux-samsung.lan (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player690.ha.ovh.net (Postfix) with ESMTPSA id C936F540091;
        Wed,  1 Feb 2017 10:55:28 +0100 (CET)
Subject: Re: [PATCH 4.10-rc3 05/13] net: bgmac: fix build errors when
 linux/phy*.h is removed from net/dsa.h
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        linux-mips@linux-mips.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        target-devel@vger.kernel.org
References: <20170131191704.GA8281@n2100.armlinux.org.uk>
 <E1cYdx2-0000WP-Ot@rmk-PC.armlinux.org.uk>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Message-ID: <889087dc-aefe-4c09-45f1-a84d60b8869b@milecki.pl>
Date:   Wed, 1 Feb 2017 10:55:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <E1cYdx2-0000WP-Ot@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12725765175169879791
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelgedrieejgddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Return-Path: <rafal@milecki.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rafal@milecki.pl
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

On 01/31/2017 08:18 PM, Russell King wrote:
> drivers/net/ethernet/broadcom/bgmac.c:1015:17: error: dereferencing pointer to incomplete type 'struct mii_bus'
> drivers/net/ethernet/broadcom/bgmac.c:1185:2: error: implicit declaration of function 'phy_start' [-Werror=implicit-function-declaration]
> drivers/net/ethernet/broadcom/bgmac.c:1198:2: error: implicit declaration of function 'phy_stop' [-Werror=implicit-function-declaration]
> drivers/net/ethernet/broadcom/bgmac.c:1239:9: error: implicit declaration of function 'phy_mii_ioctl' [-Werror=implicit-function-declaration]
> drivers/net/ethernet/broadcom/bgmac.c:1389:28: error: 'phy_ethtool_get_link_ksettings' undeclared here (not in a function)
> drivers/net/ethernet/broadcom/bgmac.c:1390:28: error: 'phy_ethtool_set_link_ksettings' undeclared here (not in a function)
> drivers/net/ethernet/broadcom/bgmac.c:1403:13: error: dereferencing pointer to incomplete type 'struct phy_device'
> drivers/net/ethernet/broadcom/bgmac.c:1417:3: error: implicit declaration of function 'phy_print_status' [-Werror=implicit-function-declaration]
> drivers/net/ethernet/broadcom/bgmac.c:1424:26: error: storage size of 'fphy_status' isn't known
> drivers/net/ethernet/broadcom/bgmac.c:1424:9: error: variable 'fphy_status' has initializer but incomplete type
> drivers/net/ethernet/broadcom/bgmac.c:1425:11: warning: excess elements in struct initializer
> drivers/net/ethernet/broadcom/bgmac.c:1425:3: error: unknown field 'link' specified in initializer
> drivers/net/ethernet/broadcom/bgmac.c:1426:12: note: in expansion of macro 'SPEED_1000'
> drivers/net/ethernet/broadcom/bgmac.c:1426:3: error: unknown field 'speed' specified in initializer
> drivers/net/ethernet/broadcom/bgmac.c:1427:13: note: in expansion of macro 'DUPLEX_FULL'
> drivers/net/ethernet/broadcom/bgmac.c:1427:3: error: unknown field 'duplex' specified in initializer
> drivers/net/ethernet/broadcom/bgmac.c:1432:12: error: implicit declaration of function 'fixed_phy_register' [-Werror=implicit-function-declaration]
> drivers/net/ethernet/broadcom/bgmac.c:1432:31: error: 'PHY_POLL' undeclared (first use in this function)
> drivers/net/ethernet/broadcom/bgmac.c:1438:8: error: implicit declaration of function 'phy_connect_direct' [-Werror=implicit-function-declaration]
> drivers/net/ethernet/broadcom/bgmac.c:1439:6: error: 'PHY_INTERFACE_MODE_MII' undeclared (first use in this function)
> drivers/net/ethernet/broadcom/bgmac.c:1521:2: error: implicit declaration of function 'phy_disconnect' [-Werror=implicit-function-declaration]
> drivers/net/ethernet/broadcom/bgmac.c:1541:15: error: expected declaration specifiers or '...' before string constant
>
> Add linux/phy.h to bgmac.c
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Acked-by: Rafał Miłecki <rafal@milecki.pl>
