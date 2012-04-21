Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Apr 2012 01:03:52 +0200 (CEST)
Received: from shards.monkeyblade.net ([198.137.202.13]:56974 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903742Ab2DUXDr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Apr 2012 01:03:47 +0200
Received: from localhost (cpe-66-108-118-54.nyc.res.rr.com [66.108.118.54])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id q3LN3ZaD000580
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Sat, 21 Apr 2012 16:03:38 -0700
Date:   Sat, 21 Apr 2012 19:03:35 -0400 (EDT)
Message-Id: <20120421.190335.1197591560590885057.davem@davemloft.net>
To:     david.s.daney@gmail.com
Cc:     ddaney.cavm@gmail.com, grant.likely@secretlab.ca,
        rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, afleming@gmail.com,
        galak@kernel.crashing.org, david.daney@cavium.com
Subject: Re: [PATCH v5 2/3] netdev/of/phy: Add MDIO bus multiplexer support.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <4F9325DF.7020003@gmail.com>
References: <1334791254-15987-3-git-send-email-ddaney.cavm@gmail.com>
        <20120421.153201.2103447307695063734.davem@davemloft.net>
        <4F9325DF.7020003@gmail.com>
X-Mailer: Mew version 6.5 on Emacs 24.0.95 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Sat, 21 Apr 2012 16:03:40 -0700 (PDT)
X-archive-position: 33002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.s.daney@gmail.com>
Date: Sat, 21 Apr 2012 14:25:51 -0700

> If we were to specify the dependencies in both places, we gain nothing
> other than duplication of information.

Each Kconfig option enabling a module has to have appropriate
dependencies.
