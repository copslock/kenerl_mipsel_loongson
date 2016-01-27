Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 21:21:18 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35495 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011816AbcA0UVQTSGcA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 21:21:16 +0100
Received: by mail-pf0-f195.google.com with SMTP id 66so482508pfe.2;
        Wed, 27 Jan 2016 12:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TehY/gHT7oJ2FW144e6sKrtjo0PrBBw8K9jr56knWdQ=;
        b=psutqvE/ZLJOY0ACQZGh8PIgyFTMnZbpYWe5ZTt9MEo/lIbo3KKgjLJVZ9eKwr4FIi
         cmyPSfCdkkdBSl+gEyVtyNdnIBuak+i9/nG36IZyYT4PBZyZbX5xLSpyVCJswlTiN+lr
         21QJI02QqjXvMVQ0T82/LrEeIybp44ynOj+wxecSHfq9XUTtug3aheAYFwjZj4vRIF8Z
         f0kCvu+hpQ2RP3qIBu4vVYdEQ1vw9UtPcRtHFCN6FF8w9BKMHgmW7TU+fQey9Nggb3wb
         OlqqUshynjc8AjDly2F/2D8DhcRG+tWVR40lJR+I23q8KcK4gJIXFBYAEe0MC5U6Xf7w
         DEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TehY/gHT7oJ2FW144e6sKrtjo0PrBBw8K9jr56knWdQ=;
        b=Diy4pmujjyVmQ2Pe+N5jA/OsYp0USa2YzL9CFAZZk2V39zjOgj5tK8/kuYbJ7Ytcln
         HJZAwckI92QYK9HrCw1ifQi0+In2jhhAH+2sol4dblhD5qLn96mFtl3pDSJHOZd8cJBf
         F9ppZl6qjfEGXcB2wK4P624DoLpbN/UUIskshYIi25xrb2xrh5LCXtLUGEl9rwOvTKj7
         7ulYD4h2IMQkoPjfc4NKzzg/GiASqqt2x6gqN2fYf/YZwIKdwpAP5eIJHO4QBulg2h/h
         1le39xzC3bUxM8vH2bhM5lZgKO4EqjnarTxsfVDwvFnCblFpmTuBWqqJOd5Af7y7pSGR
         LWwA==
X-Gm-Message-State: AG10YOS3wTtXtv3IGi6Bjj/+KnketYhBpTjOegSja51BZApnRk3ltMP1psspz6crfzjbqg==
X-Received: by 10.98.14.80 with SMTP id w77mr45442959pfi.152.1453926070169;
        Wed, 27 Jan 2016 12:21:10 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:6149:7131:eca:637b])
        by smtp.gmail.com with ESMTPSA id ze5sm10999211pac.32.2016.01.27.12.21.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 12:21:09 -0800 (PST)
Date:   Wed, 27 Jan 2016 12:21:07 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, cernekee@gmail.com,
        jogo@openwrt.org, simon@fire.lp0.eu
Subject: Re: [PATCH 1/2] MIPS: BCM63xx: Enable partition parser in defconfig
Message-ID: <20160127202107.GA41831@google.com>
References: <1453925596-24661-1-git-send-email-f.fainelli@gmail.com>
 <1453925596-24661-2-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453925596-24661-2-git-send-email-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51487
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

On Wed, Jan 27, 2016 at 12:13:15PM -0800, Florian Fainelli wrote:
> Enable CONFIG_MTD_BCM63XX_PARTS in arch/mips/configs/bcm63xx_defconfig
> since this is a necessary option to parse the built-in flash partition
> table on BCM63xx SoCs.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Brian Norris <computersforpeace@gmail.com>
