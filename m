Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 21:23:12 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35838 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011828AbcA0UXKWXr9Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 21:23:10 +0100
Received: by mail-pf0-f196.google.com with SMTP id 66so484260pfe.2;
        Wed, 27 Jan 2016 12:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pJhMe33GXhtp0BHZkCje8E/hZbB+bSc7fZHJyMAixb4=;
        b=xb0+LutqdfyLueMGFDkJUMBATGI+QogDrVxb6NZG8Yt7EYEhIMH3NLJqo72sc4LRqm
         rqbmC3sz++hNFIKUImcFawG41RQgbOTKEKiasMtlIJ+jOWuVCcUYLdJIwk/+Aj6v2MCH
         B2bH1lC1QjbpYVJVnLPWAk30pKj0U7hnMQfe8CgLORlmPAXdn3c4zEzK+KH3Gaof/cPt
         Av9S0FgJmugc8mz8CgUfagQkjIWlCBys93cuRu4/3DRrOhJ1Hk1iXwV1EwrGtTHS0N32
         GvQztKq9B/M7axqT9PTy53e4zKe0AwE0maw1ILaFV2yebp9+xaJqnjpjN4I/71Nzvq+7
         e+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=pJhMe33GXhtp0BHZkCje8E/hZbB+bSc7fZHJyMAixb4=;
        b=NIImpsINVdBQfs4XgT6kFQ9q8KEPcVIiPxK0txvltXf3VyA2i3w8AJlC0V5cNgLxMQ
         gIVxfwzEr10ut/v/a7H+FINpQvF8s3j4/rEXk3bW2cXJumBIJreZVmIn8MI9ObEDVZ8L
         HwVZ3CyE0NG+CBUQQ5oJKecxG28SAM3C9jkp4zZ7yfGFxRmQ69qklDqpkOplSZiZKM7h
         zqtzHWuEFWLSfK5CsuQMJn8/AGAA2Vkgv8xhfh6TrlCGv+9gaFVCcVUAxjCb0lYtbV2n
         MUj0bohGkntPwsE9dfVTh906iPKUQuYjp+xOzKRm9rtF8t/3M0is8wzEt/fSxf8MiWmo
         LdLg==
X-Gm-Message-State: AG10YOQI0n87m8bSWNeuOsE0LPxB7dQ6vFTshsDYW6KBldOuOLbkJruaEBikh81Mv0Uu7g==
X-Received: by 10.98.93.195 with SMTP id n64mr45584145pfj.67.1453926184650;
        Wed, 27 Jan 2016 12:23:04 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:6149:7131:eca:637b])
        by smtp.gmail.com with ESMTPSA id cq4sm10976169pad.28.2016.01.27.12.23.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 12:23:04 -0800 (PST)
Date:   Wed, 27 Jan 2016 12:23:02 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, cernekee@gmail.com,
        jogo@openwrt.org, simon@fire.lp0.eu
Subject: Re: [PATCH 2/2] MIPS: BMIPS: Enable partition parser in defconfig
Message-ID: <20160127202302.GB41831@google.com>
References: <1453925596-24661-1-git-send-email-f.fainelli@gmail.com>
 <1453925596-24661-3-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453925596-24661-3-git-send-email-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51488
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

On Wed, Jan 27, 2016 at 12:13:16PM -0800, Florian Fainelli wrote:
> Enable CONFIG_MTD_BCM63XX_PARTS in arch/mips/configs/bmips_be_defconfig
> since this is a necessary option to parse the built-in flash partition
> table on BMIPS big-endian SoCs (Cable Modem and DSL).
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/configs/bmips_be_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/configs/bmips_be_defconfig b/arch/mips/configs/bmips_be_defconfig
> index 24dcb90b0f64..acf7785c4cdb 100644
> --- a/arch/mips/configs/bmips_be_defconfig
> +++ b/arch/mips/configs/bmips_be_defconfig
> @@ -36,6 +36,7 @@ CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_PRINTK_TIME=y
>  CONFIG_BRCMSTB_GISB_ARB=y
>  CONFIG_MTD=y
> +CONFIG_MTD_BCM63XX_PARTS=y

^^ This doens't help, AFAICT, because this config doesn't have
CONFIG_BCM63XX yet, which CONFIG_MTD_BCM63XX_PARTS depends on.

Or, is that part of what this series will help with: removing the
dependency on CONFIG_BCM63XX?

http://lists.infradead.org/pipermail/linux-mtd/2015-December/064380.html

Brian

>  CONFIG_MTD_CFI=y
>  CONFIG_MTD_CFI_INTELEXT=y
>  CONFIG_MTD_CFI_AMDSTD=y
> -- 
> 2.1.0
> 
