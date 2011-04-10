Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Apr 2011 20:13:57 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42186 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491154Ab1DJSNy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Apr 2011 20:13:54 +0200
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
        by metis.ext.pengutronix.de with esmtp (Exim 4.72)
        (envelope-from <ukl@pengutronix.de>)
        id 1Q8z85-0004cW-4K; Sun, 10 Apr 2011 20:12:57 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
        (envelope-from <ukl@pengutronix.de>)
        id 1Q8z7m-0002qv-8J; Sun, 10 Apr 2011 20:12:38 +0200
Date:   Sun, 10 Apr 2011 20:12:38 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     wanlong.gao@gmail.com
Cc:     linux@arm.linux.org.uk, hans-christian.egtvedt@atmel.com,
        ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org,
        david.woodhouse@intel.com, akpm@linux-foundation.org,
        mingo@elte.hu, rientjes@google.com, nicolas.ferre@atmel.com,
        eric@eukrea.com, tony@atomide.com, santosh.shilimkar@ti.com,
        khilman@deeprootsystems.com, ben-linux@fluff.org, sam@ravnborg.org,
        manuel.lauss@googlemail.com, galak@kernel.crashing.org,
        anton@samba.org, grant.likely@secretlab.ca, sfr@canb.auug.org.au,
        jwboyer@linux.vnet.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] fix build warnings on defconfigs
Message-ID: <20110410181238.GE18601@pengutronix.de>
References: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <ukl@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ukl@pengutronix.de
Precedence: bulk
X-list: linux-mips

On Sun, Apr 10, 2011 at 03:04:18AM +0800, wanlong.gao@gmail.com wrote:
> From: Wanlong Gao <wanlong.gao@gmail.com>
> 
> Change the BT_L2CAP and BT_SCO defconfigs from 'm' to 'y',
> since BT_L2CAP and BT_SCO had changed to bool configs.
Pointing out the commit that changed these two in the commit log would
be nice. Something like:

	The BT_L2CAP and BT_SCO configs are bool since

		6427451 (Bluetooth: Merge L2CAP and SCO modules into bluetooth.ko)

	. So change all defconfigs from =m to =y.

Other than that
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
