Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 May 2013 14:34:27 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:38430 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822517Ab3EJMeVbzYwu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 May 2013 14:34:21 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 10 May 2013 05:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,647,1363158000"; 
   d="scan'208";a="311269412"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2013 05:34:11 -0700
Received: from [10.237.72.153] (sauron.fi.intel.com [10.237.72.153])
        by linux.intel.com (Postfix) with ESMTP id 2CAF36A4087;
        Fri, 10 May 2013 05:33:49 -0700 (PDT)
Message-ID: <1368189407.26780.159.camel@sauron.fi.intel.com>
Subject: Re: [PATCH 2/3] MIPS: BCM63XX: export PSI size from nvram
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
Date:   Fri, 10 May 2013 15:36:47 +0300
In-Reply-To: <1364044070-10486-3-git-send-email-jogo@openwrt.org>
References: <1364044070-10486-1-git-send-email-jogo@openwrt.org>
         <1364044070-10486-3-git-send-email-jogo@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.6.4 (3.6.4-3.fc18) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <dedekind1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
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

On Sat, 2013-03-23 at 14:07 +0100, Jonas Gorski wrote:
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> ---
>  arch/mips/bcm63xx/nvram.c                          |   11 +++++++++++
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h |    2 ++
>  2 files changed, 13 insertions(+)

Acks from MIPS folks would be nice to have, but I pushed this patch to
the l2-mtd.git tree, thanks!

-- 
Best Regards,
Artem Bityutskiy
