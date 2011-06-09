Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2011 07:08:19 +0200 (CEST)
Received: from gate.crashing.org ([63.228.1.57]:56636 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490954Ab1FIFIP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jun 2011 07:08:15 +0200
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p5956Uw9022243;
        Thu, 9 Jun 2011 00:06:31 -0500
Subject: Re: [PATCH] Fix build warning of the defconfigs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Wanlong Gao <wanlong.gao@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux@arm.linux.org.uk, hans-christian.egtvedt@atmel.com,
        vapier@gentoo.org, ralf@linux-mips.org, paulus@samba.org,
        lethal@linux-sh.org, gxt@mprc.pku.edu.cn,
        david.woodhouse@intel.com, akpm@linux-foundation.org,
        u.kleine-koenig@pengutronix.de, mingo@elte.hu, rientjes@google.com,
        w.sang@pengutronix.de, sam@ravnborg.org,
        manuel.lauss@googlemail.com, anton@samba.org, arnd@arndb.de
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 09 Jun 2011 15:06:28 +1000
Message-ID: <1307595988.2874.266.camel@pasglop>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
X-archive-position: 30303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7541

On Thu, 2011-06-02 at 00:29 +0800, Wanlong Gao wrote:
> RTC_CLASS is changed to bool.
> So value 'm' is invalid.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
> ---

For powerpc:

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks !

Ben.
