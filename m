Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2012 12:26:18 +0100 (CET)
Received: from mga03.intel.com ([143.182.124.21]:32397 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903567Ab2CIL0K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Mar 2012 12:26:10 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 09 Mar 2012 03:26:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; 
   d="scan'208";a="116785661"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
  by azsmga001.ch.intel.com with ESMTP; 09 Mar 2012 03:26:02 -0800
Received: from [10.237.72.167] (sauron.fi.intel.com [10.237.72.167])
        by linux.intel.com (Postfix) with ESMTP id C4EA72C8001;
        Fri,  9 Mar 2012 03:25:58 -0800 (PST)
Message-ID: <1331292517.29445.6.camel@sauron.fi.intel.com>
Subject: Re: [PATCH V2 1/3] MTD: MIPS: lantiq: use module_platform_driver
 inside lantiq map driver
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org
Date:   Fri, 09 Mar 2012 13:28:37 +0200
In-Reply-To: <1330013024-13622-1-git-send-email-blogic@openwrt.org>
References: <1330013024-13622-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3 (3.2.3-1.fc16) 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-archive-position: 32623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 2012-02-23 at 17:03 +0100, John Crispin wrote:
> Reduce boilerplate code by converting driver to module_platform_driver.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-mtd@lists.infradead.org

This is not an independent patch - do you want to merge it via the mips
tree?

-- 
Best Regards,
Artem Bityutskiy
