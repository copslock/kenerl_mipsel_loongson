Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2011 16:43:25 +0200 (CEST)
Received: from shards.monkeyblade.net ([198.137.202.13]:57738 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491170Ab1HKOnS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Aug 2011 16:43:18 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p7BEgtaP006759
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 11 Aug 2011 07:42:56 -0700
Date:   Thu, 11 Aug 2011 07:42:55 -0700 (PDT)
Message-Id: <20110811.074255.1123597785105932021.davem@davemloft.net>
To:     ralf@linux-mips.org
Cc:     pcnet32@frontier.com, netdev@vger.kernel.org,
        tsbogend@alpha.franken.de, linux-mips@linux-mips.org
Subject: Re: [PATCH] PCnet: Fix section mismatch
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20110810152346.GA6092@linux-mips.org>
References: <20110810152346.GA6092@linux-mips.org>
X-Mailer: Mew version 6.3 on Emacs 23.2 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Thu, 11 Aug 2011 07:42:56 -0700 (PDT)
X-archive-position: 30853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8519

From: Ralf Baechle <ralf@linux-mips.org>
Date: Wed, 10 Aug 2011 16:23:46 +0100

> Building MIPS mtx1_defconfig results in:
> 
>   MODPOST 735 modules
> WARNING: drivers/net/pcnet32.o(.devinit.text+0x11ec): Section mismatch in reference from the function pcnet32_probe_vlbus.constprop.22() to the variable .init.data:pcnet32_portlist
> The function __devinit pcnet32_probe_vlbus.constprop.22() references
> a variable __initdata pcnet32_portlist.
> If pcnet32_portlist is only used by pcnet32_probe_vlbus.constprop.22 then
> annotate pcnet32_portlist with a matching annotation.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Applied, thanks Ralf.
