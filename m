Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Apr 2012 21:32:16 +0200 (CEST)
Received: from shards.monkeyblade.net ([198.137.202.13]:55965 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903737Ab2DUTcM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Apr 2012 21:32:12 +0200
Received: from localhost (cpe-66-108-118-54.nyc.res.rr.com [66.108.118.54])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id q3LJW1QI024704
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Sat, 21 Apr 2012 12:32:02 -0700
Date:   Sat, 21 Apr 2012 15:32:01 -0400 (EDT)
Message-Id: <20120421.153201.2103447307695063734.davem@davemloft.net>
To:     ddaney.cavm@gmail.com
Cc:     grant.likely@secretlab.ca, rob.herring@calxeda.com,
        devicetree-discuss@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, galak@kernel.crashing.org,
        david.daney@cavium.com
Subject: Re: [PATCH v5 2/3] netdev/of/phy: Add MDIO bus multiplexer support.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1334791254-15987-3-git-send-email-ddaney.cavm@gmail.com>
References: <1334791254-15987-1-git-send-email-ddaney.cavm@gmail.com>
        <1334791254-15987-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: Mew version 6.5 on Emacs 24.0.95 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Sat, 21 Apr 2012 12:32:05 -0700 (PDT)
X-archive-position: 33000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <ddaney.cavm@gmail.com>
Date: Wed, 18 Apr 2012 16:20:53 -0700

> +config MDIO_BUS_MUX
> +	tristate
> +	help
> +	  This module provides a driver framework for MDIO bus
> +	  multiplexers which connect one of several child MDIO busses
> +	  to a parent bus.  Switching between child busses is done by
> +	  device specific drivers.
> +

This driver uses OF and OF_MDIO, and therefore need dependencies upon
them.  Otherwise it can be enabled in configurations which will result
in build failures.
