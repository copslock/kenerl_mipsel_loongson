Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 17:02:08 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:38560 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991532AbdFEPBz2FpKM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 17:01:55 +0200
Received: from localhost (unknown [38.140.131.194])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 74A29136A5427;
        Mon,  5 Jun 2017 07:20:08 -0700 (PDT)
Date:   Mon, 05 Jun 2017 11:01:45 -0400 (EDT)
Message-Id: <20170605.110145.2053472151656679350.davem@davemloft.net>
To:     yuval.shaia@oracle.com
Cc:     klassert@mathematik.tu-chemnitz.de, pcnet32@frontier.com,
        hsweeten@visionengravers.com, jeffrey.t.kirsher@intel.com,
        cooldavid@cooldavid.org, mcuos.com@gmail.com, nic_swsd@realtek.com,
        ralf@linux-mips.org, romieu@fr.zoreil.com, nico@fluxnic.net,
        oneukum@suse.com, tremyfr@gmail.com, paul.gortmaker@windriver.com,
        jarod@redhat.com, green.hu@gmail.com, f.fainelli@gmail.com,
        edumazet@google.com, shchers@gmail.com, stephen.boyd@linaro.org,
        fgao@48lvckh6395k16k5.yundunddos.com, tklauser@distanz.ch,
        jay.vosburgh@canonical.com, robert.jarzmik@free.fr,
        jeremy.linton@arm.com, rmk+kernel@armlinux.org.uk,
        stephen@networkplumber.org, arnd@arndb.de, gerg@linux-m68k.org,
        allan@asix.com.tw, chris.roth@usask.ca, hayeswang@realtek.com,
        mario_limonciello@dell.com, netdev@vger.kernel.org,
        linux-parisc@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] net/{mii,smsc}: Make mii_ethtool_get_link_ksettings
 and smc_netdev_get_ecmd return void
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20170604172200.4177-1-yuval.shaia@oracle.com>
References: <20170604172200.4177-1-yuval.shaia@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 05 Jun 2017 07:20:11 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun,  4 Jun 2017 20:22:00 +0300

> Make return value void since functions never returns meaningfull value.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>

Applied to net-next.
