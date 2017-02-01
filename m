Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2017 11:27:31 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:53974 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992028AbdBAK1U4Pnrc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2017 11:27:20 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 2C89D21CFF; Wed,  1 Feb 2017 11:27:14 +0100 (CET)
Received: from localhost (LFbn-1-6691-76.w90-120.abo.wanadoo.fr [90.120.129.76])
        by mail.free-electrons.com (Postfix) with ESMTPSA id E736C20C66;
        Wed,  1 Feb 2017 11:27:13 +0100 (CET)
Date:   Wed, 1 Feb 2017 11:27:14 +0100
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-mips@linux-mips.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        target-devel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 4.10-rc3 07/13] net: mvneta: fix build errors when
 linux/phy*.h is removed from net/dsa.h
Message-ID: <20170201112714.03fc236e@free-electrons.com>
In-Reply-To: <E1cYdxD-0000Wd-1D@rmk-PC.armlinux.org.uk>
References: <20170131191704.GA8281@n2100.armlinux.org.uk>
        <E1cYdxD-0000Wd-1D@rmk-PC.armlinux.org.uk>
Organization: Free Electrons
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
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

On Tue, 31 Jan 2017 19:18:59 +0000, Russell King wrote:
> drivers/net/ethernet/marvell/mvneta.c:2694:26: error: storage size of 'status' isn't known
> drivers/net/ethernet/marvell/mvneta.c:2695:26: error: storage size of 'changed' isn't known
> drivers/net/ethernet/marvell/mvneta.c:2695:9: error: variable 'changed' has initializer but incomplete type
> drivers/net/ethernet/marvell/mvneta.c:2709:2: error: implicit declaration of function 'fixed_phy_update_state' [-Werror=implicit-function-declaration]
> 
> Add linux/phy_fixed.h to mvneta.c
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
