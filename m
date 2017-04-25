Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Apr 2017 18:31:56 +0200 (CEST)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:36066
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993930AbdDYQbtN0Jid (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Apr 2017 18:31:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Cx+hS6VeVgL7pwLKecCfAhzgGQls/lXlqWKpXcBAHX8=;
        b=XQEi0GQ8Xf6ghDIYaESLy+cuRb5vl6RwM605IbBlHunWi+vC4KXEed4Tg0TVUcFYQ7JdB4O+HFoHlxlyPs/a0CGnk/PTgshyz05sc0gKMJKLuILLNuZOqE9uGdYh/z8AOKRXvcRmr70sChz9Wlc4+mE5m+Wpvx55q8WTpLec7TM=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:57289)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@armlinux.org.uk>)
        id 1d33NP-0000yW-Gg; Tue, 25 Apr 2017 17:31:43 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1d33NK-0004Ks-QI; Tue, 25 Apr 2017 17:31:38 +0100
Date:   Tue, 25 Apr 2017 17:31:37 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix returns of some CLK API calls, if !CONFIG_HAVE_CLOCK
Message-ID: <20170425163137.GR17774@n2100.armlinux.org.uk>
References: <20170425125547.865FB508DA7@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425125547.865FB508DA7@solo.franken.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@armlinux.org.uk
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

On Tue, Apr 25, 2017 at 02:30:07PM +0200, Thomas Bogendoerfer wrote:
> If CONFIG_HAVE_CLOCK is not set, return values of clk_get(),
> devm_clk_get(), devm_get_clk_from_child(), clk_get_parent()
> and clk_get_sys() are wrong. According to spec these functions
> should either return a pointer to a struct clk or a valid IS_ERR
> condition. NULL is neither, so returning ERR_PTR(-ENODEV) makes
> more sense.

That's wrong.  When the clk API is disabled, the expected behaviour is
that drivers will not fail.  Returning ERR_PTR(-ENODEV) will cause them
to fail, so will break platforms.

NAK.

> Without this change serial console on SNI RM400 machines (MIPS arch)
> is broken, because sccnxp driver doesn't get a valid clock rate.

So the driver needs to depend on HAVE_CLOCK.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
