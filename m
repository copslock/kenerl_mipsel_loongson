Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Apr 2017 00:36:45 +0200 (CEST)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:34137
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991726AbdDTWgi1F42w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Apr 2017 00:36:38 +0200
Received: by mail-io0-x244.google.com with SMTP id h41so21763877ioi.1;
        Thu, 20 Apr 2017 15:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f5ewO5iL1wo18DjupLzfHfeP3s12Wu0EL0sqYhxq1CA=;
        b=HF6PmlkK4otlayW2Dr+WYuDK2thwi9QUSRRTQGMEkIRg6Sv4WhJNdJCDpl5vZaRvAB
         5egWpzZuS6scE0ctLnvlxEZC2Wk9eFA9xB8ZGIcUwW+9x6GLRSGTXHzfEYMfBGKvJT1J
         +1rLFPBJwAm2mTsLWB6/E/SkPM4GUEdFsecHPSyBo6irLX4/Na6RKFZmpoKRudth/2hq
         dV6OzdrQQaJ2HDqJWkIBC+L00zKDHHymVREpmlyhd6fGqKU5SrYStJ5iJ3ItFRkCP0Dv
         csdqaiwEMsuTcautWT6XMHb5SM6dHw0BkQRDcLoSdTO136WSzS/TpTvqSi5cL81XA+WW
         zytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f5ewO5iL1wo18DjupLzfHfeP3s12Wu0EL0sqYhxq1CA=;
        b=llkIGVVdV3WWWCHZLfNPUiV8Mr3bglIt0YszRbqMx/vpot2uqo8SGnjcgBhAtUteod
         msYrO2EjR8/Kug+gk1WOLgfTBuAzmpL6cJb7YH2keF1dV/REB1sHYlht8rWbqy3BtZtR
         X2cNph3hgRGQjYkd772Bgz5DYA+0fkSnSaq3jfKK+1hfdKuRSnYk3UuOZ3ynfnNL9joK
         CpsQwIhboK4uwqtOPECRcesOPG8MBCwKsTor6mmA2XK82Hs1dQ6r9chQ5q9/ary4S/ff
         NxJU7h9uKBnapnpiscVluBCOsXeG1gEsag9kSaysP3RTH0mV4GivBfsEs4KwMlsmIBi+
         ggPQ==
X-Gm-Message-State: AN3rC/7JGTS7xrv/iSJLOSvoxG485PU3tHmYUM/Oh7B/uywcYnHk5uYh
        MaqDJIceiBI+Gg==
X-Received: by 10.99.104.9 with SMTP id d9mr9461914pgc.27.1492727792455;
        Thu, 20 Apr 2017 15:36:32 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:e924:9fc5:87d6:cbd5])
        by smtp.gmail.com with ESMTPSA id 3sm12190831pge.12.2017.04.20.15.36.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Apr 2017 15:36:31 -0700 (PDT)
Date:   Thu, 20 Apr 2017 15:36:29 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, john@phrozen.org,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 02/13] mtd: lantiq-flash: drop check of boot select
Message-ID: <20170420223629.GI20555@google.com>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-3-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417192942.32219-3-hauke@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Mon, Apr 17, 2017 at 09:29:31PM +0200, Hauke Mehrtens wrote:
> Do not check which flash type the SoC was booted from before
> using this driver. Assume that the device tree is correct and use this
> driver when it was added to device tree. This also removes a build
> dependency to the SoC code.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Presuming you get the platform details right (i.e., device tree), I'm
happy with this. It's not really this driver's job to check your boot
strappings.

Acked-by: Brian Norris <computersforpeace@gmail.com>
