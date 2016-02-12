Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Feb 2016 19:49:15 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36097 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011718AbcBLStNrsFrb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Feb 2016 19:49:13 +0100
Received: by mail-pa0-f66.google.com with SMTP id gc2so381904pab.3;
        Fri, 12 Feb 2016 10:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UbPq/MMeHw3EhQxIO2SxiNmsgCxm8wiBBX3obWMSryw=;
        b=h/V3zOmwO3G6lhJrGKITPWZnZ1rdFFXKTDf3M5dwTbMatuo2lqAlzEi9IYz/MzIGim
         e3ntUFJCsThzCf2P+sJwDuwWc/du1kqQfoSLMoLhqIYKOx2msIoNQoLPrVZiJW0UAdtW
         W9u6WKulTYiU1dFfB7/5SzwV7aiuR0XWzE1bJr0ycaEumXva0We+R20h28fBSSoibt6H
         lgwj7FDQ6XaYGlhdAhZ6h1x9RGE3LQ3ceqcMaIt8pgmTQvLgPhkUegSGwC2QpWej3MfH
         tl9SYfh8yv+lt6BMv38sjLOPFecqdvtPW7W7H/D+NAHgvoAbi/RDwc3kWzdn6xkxDyK3
         BifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=UbPq/MMeHw3EhQxIO2SxiNmsgCxm8wiBBX3obWMSryw=;
        b=HBvRQ5nfBHC3tbp+Wel3yQHHD1gAWKEXPc2NlbAJ8LSbMNSGV2f1LrCmHf5/+AtUNF
         yAmvqtwS6yE62Hk9PwwIRz42UitOCJnMPNdFL/ooEHzP4ir0r0QoMDUeMjBGUG1PHmIy
         uqzUA10FpSHWeA4VFXFc0ULRcTlG9xZMddOz2blvwYrDyIiZ0qX15fG3BxqvCYmEuzdh
         Ys2TLaViU0GcG5+xt05C6gcjUXGGxYcxInQ7G/v9SWdrUT47hQFFUtIMrKjtrsrM5l5Q
         dUZj2utJ43FiZzPtiBXvwT21SADhh9dbpSjG0d81G0LXbLyW1ij0WSGtgxiF9Ydjtv4o
         QEQg==
X-Gm-Message-State: AG10YOQ8MERcrhCqhH2Eew33lgBO812BaLn0YBzfT4AJEMFENZIC6ZoTRqkvcCMdQLG7Yw==
X-Received: by 10.66.235.129 with SMTP id um1mr4316876pac.17.1455302947769;
        Fri, 12 Feb 2016 10:49:07 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:7c71:7f64:5e00:7fed])
        by smtp.gmail.com with ESMTPSA id ss5sm21116846pab.15.2016.02.12.10.49.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Feb 2016 10:49:07 -0800 (PST)
Date:   Fri, 12 Feb 2016 10:49:05 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH linux-next v4 06/11] mtd: bcm63xxpart: Remove dependency
 on mach-bcm63xx
Message-ID: <20160212184905.GQ19540@google.com>
References: <566DF43B.5010400@simon.arlott.org.uk>
 <566DF5F6.6070901@simon.arlott.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566DF5F6.6070901@simon.arlott.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52027
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

On Sun, Dec 13, 2015 at 10:49:26PM +0000, Simon Arlott wrote:
> Read nvram directly from flash instead of using the in-memory copy that
> mach-bcm63xx has, to remove the dependency on mach-bcm63xx and allow the
> parser to work on bmips too.
> 
> Rename remaining BCM63XX defines to BCM963XX as these are properties of
> the flash layout on the board.
> 
> BCM963XX_DEFAULT_PSI_SIZE changes from SZ_64K to 64 because it will be
> multiplied by SZ_1K later on.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
> v4: New patch.

Pushed patches 6, 8, 9, and 10 to l2-mtd.git. I had comments on patch
11.

Thanks,
Brian
