Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2011 07:26:08 +0200 (CEST)
Received: from linux-sh.org ([111.68.239.195]:59274 "EHLO linux-sh.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491012Ab1FBF0F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Jun 2011 07:26:05 +0200
Received: from linux-sh.org (localhost.localdomain [127.0.0.1])
        by linux-sh.org (8.14.4/8.14.4) with ESMTP id p525P1EJ027996;
        Thu, 2 Jun 2011 14:25:01 +0900
Received: (from pmundt@localhost)
        by linux-sh.org (8.14.4/8.14.4/Submit) id p525OqgF025867;
        Thu, 2 Jun 2011 14:24:52 +0900
X-Authentication-Warning: linux-sh.org: pmundt set sender to lethal@linux-sh.org using -f
Date:   Thu, 2 Jun 2011 14:24:52 +0900
From:   Paul Mundt <lethal@linux-sh.org>
To:     Wanlong Gao <wanlong.gao@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux@arm.linux.org.uk, hans-christian.egtvedt@atmel.com,
        vapier@gentoo.org, ralf@linux-mips.org, benh@kernel.crashing.org,
        paulus@samba.org, gxt@mprc.pku.edu.cn, david.woodhouse@intel.com,
        akpm@linux-foundation.org, u.kleine-koenig@pengutronix.de,
        mingo@elte.hu, rientjes@google.com, w.sang@pengutronix.de,
        sam@ravnborg.org, manuel.lauss@googlemail.com, anton@samba.org,
        arnd@arndb.de
Subject: Re: [PATCH] Fix build warning of the defconfigs
Message-ID: <20110602052452.GA6087@linux-sh.org>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
User-Agent: Mutt/1.4.1i
X-archive-position: 30189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1511

On Thu, Jun 02, 2011 at 12:29:23AM +0800, Wanlong Gao wrote:
> RTC_CLASS is changed to bool.
> So value 'm' is invalid.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>

>  arch/sh/configs/titan_defconfig            |    2 +-

Acked-by: Paul Mundt <lethal@linux-sh.org>
