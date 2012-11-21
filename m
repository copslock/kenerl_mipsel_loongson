Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2012 12:59:30 +0100 (CET)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54381 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825938Ab2KUL73Ox9Z9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2012 12:59:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=QtOP6C5Lem/9LYbOFMrA1BbsHozcUumVSvL7IgO4BEY=;
        b=jYnWOwt6nelzgXUvbvlooSrDMYIhdAoqdBPj1GlD309Pt/cV+d2/y+DHib9stvkm5ao84fEOzL+TVufJi6SrT6NdfLHBjPBoR6cx+SQjEnb7FxZk8clGGgbvprFsc8vc3HH7TG+6VVQyAMQy4c9BqqZPEJCSWS6ZBGlufsoVTIg=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:50185)
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.76)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1Tb8uA-0003hd-Ox; Wed, 21 Nov 2012 11:55:47 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1Tb8u8-0004wd-Iy; Wed, 21 Nov 2012 11:55:44 +0000
Date:   Wed, 21 Nov 2012 11:55:44 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Bill Pemberton <wfp5p@virginia.edu>
Cc:     gregkh@linuxfoundation.org,
        Steffen Klassert <klassert@mathematik.tu-chemnitz.de>,
        David Dillow <dave@thedillows.org>,
        Kristoffer Glembo <kristoffer@gaisler.com>,
        Jes Sorensen <jes@trained-monkey.org>,
        Don Fry <pcnet32@frontier.com>,
        Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        Grant Grundler <grundler@parisc-linux.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Vitaly Bordug <vbordug@ru.mvista.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
        Francois Romieu <romieu@fr.zoreil.com>,
        Sorbica Shieh <sorbica@icplus.com.tw>,
        Guo-Fu Tseng <cooldavid@cooldavid.org>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <shemminger@vyatta.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Florian Fainelli <florian@openwrt.org>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Daniele Venzano <venza@brownhat.org>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Samuel Chessman <chessman@tux.org>,
        Geoff Levand <geoff@infradead.org>,
        Roger Luethi <rl@hellgate.ch>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        John Linn <John.Linn@xilinx.com>,
        Krzysztof Halasa <khc@pm.waw.pl>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-acenic@sunsite.dk,
        linuxppc-dev@lists.ozlabs.org, e1000-devel@lists.sourceforge.net,
        linux-mips@linux-mips.org, cbe-oss-dev@lists.ozlabs.org
Subject: Re: [PATCH 198/493] ethernet: remove use of __devinit
Message-ID: <20121121115544.GG3290@n2100.arm.linux.org.uk>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu> <1353349642-3677-198-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1353349642-3677-198-git-send-email-wfp5p@virginia.edu>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-archive-position: 35072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
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

On Mon, Nov 19, 2012 at 01:22:27PM -0500, Bill Pemberton wrote:
>  drivers/net/ethernet/8390/etherh.c                 |  4 +-
>  drivers/net/ethernet/amd/am79c961a.c               |  2 +-
>  drivers/net/ethernet/i825xx/ether1.c               |  8 +-
>  drivers/net/ethernet/seeq/ether3.c                 | 10 +--

For these four,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
