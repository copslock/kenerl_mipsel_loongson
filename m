Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2015 18:39:58 +0100 (CET)
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34167 "EHLO
        mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006617AbbKRRj4xbVRA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2015 18:39:56 +0100
Received: by ykfs79 with SMTP id s79so77827054ykf.1;
        Wed, 18 Nov 2015 09:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vOscfTcnin0dw71O3HCsRlK7FaaxgVz6xAZ6SD49wt0=;
        b=yXdCi+ekaqj/2we2897dMbNbS2X0we4E3O5gvJEeHj+0TbdEreqYaOgfB1KrGRo64x
         tk1APOpVvsbfda0fJ+n6mfkAK0rPca8TELncbavMYE2+xG7RauMXIBR5n7R5K05YEggv
         S3CgvqJSBUEQGhYq/xejM9vUPQ9qqNzLqjILLJ20tpVFv4t28hw0hOJfBkDx6LsHUiLr
         H1LtFQir7jLygRgrs9pQjBlZyTupHITl/NnPyDqFofxJq5tBkaQUbfPLZ/Y8svILE4b0
         K9EDJF6LCToy1SH3aUPFHVCvwX5adtuBGAXgQmjIjiukVxgWS2s3AyP+JHyLtF2yGQca
         0MSw==
X-Received: by 10.129.40.147 with SMTP id o141mr42277748ywo.199.1447790821605;
        Tue, 17 Nov 2015 12:07:01 -0800 (PST)
Received: from mtj.duckdns.org ([2620:10d:c091:200::a:4bca])
        by smtp.gmail.com with ESMTPSA id v23sm15950749ywa.30.2015.11.17.12.06.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Nov 2015 12:07:00 -0800 (PST)
Date:   Tue, 17 Nov 2015 15:06:58 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org
Subject: Re: [v4 03/10] ata: ahci_brcmstb: add quirk for different phy
Message-ID: <20151117200658.GE22864@mtj.duckdns.org>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
 <1446213684-2625-4-git-send-email-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1446213684-2625-4-git-send-email-jaedon.shin@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
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

On Fri, Oct 30, 2015 at 11:01:17PM +0900, Jaedon Shin wrote:
> Add quirk for phy interface of MIPS-based chipsets. The ARM-based
> chipsets have four phy interface control registers and each port has two
> registers but the MIPS-based chipsets have three. There are no
> information and documentation.
> 
> The Broadcom strict-ahci based BSP of legacy version did not control
> these registers.
...
>  enum brcm_ahci_quirks {
>  	BRCM_AHCI_QUIRK_NONCQ		= BIT(0),
> +	BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE	= BIT(1),
>  };

I see.  There's another quirk flag which actually needs to be
persistent.  Hmm... I don't know.  Ah well, please disregard my
previous comment.

Thanks.

-- 
tejun
