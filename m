Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2017 06:34:34 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:54710 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991976AbdBAFe1Rk657 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2017 06:34:27 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 90FE2609FB; Wed,  1 Feb 2017 05:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1485927265;
        bh=F3Nc6h0hce7z8qtZJME+lv5njButKawToi5yn7X5tKQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bXh5eZl3T+2ZA2SR6eDLuY4mt3FgSCd4gsNHbgvYYBcbZ3Mu4DgzKBFr0WqTtJKe6
         9OtMKObA2fsk5eEQhb4PWDYTBNZ+OBZyh6M5OL5hFcgqDlv/WPq4UmuVOoGUfcy2h8
         +maadTOw7K05z/TfmBtrAgU6vMUH+jCCYmoWl1Ss=
Received: from x230.qca.qualcomm.com (a88-115-187-87.elisa-laajakaista.fi [88.115.187.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB837609C6;
        Wed,  1 Feb 2017 05:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1485927264;
        bh=F3Nc6h0hce7z8qtZJME+lv5njButKawToi5yn7X5tKQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Lh0lEr/nOh9C53+2OYyhO2P8N2YylgA2JND/WcU08q5EcqFlkUiLq/R1297RiVhO6
         HuutpNRReTJH3lv/kDl976C50TZ+190aaz7VZKz6wijfTxHzQnhL9KjpUvjDFfM3iS
         6IVB4MEImWEGEqfJLfqXIHylwV9UkZ5wWcMYIswk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB837609C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-mips@linux-mips.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        target-devel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: Re: [PATCH 4.10-rc3 12/13] net: ath5k: fix build errors when linux/phy*.h is removed from net/dsa.h
References: <20170131191704.GA8281@n2100.armlinux.org.uk>
        <E1cYdxc-0000XC-N6@rmk-PC.armlinux.org.uk>
Date:   Wed, 01 Feb 2017 07:34:19 +0200
In-Reply-To: <E1cYdxc-0000XC-N6@rmk-PC.armlinux.org.uk> (Russell King's
        message of "Tue, 31 Jan 2017 19:19:24 +0000")
Message-ID: <87r33ibhk4.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kvalo@codeaurora.org
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

Russell King <rmk+kernel@armlinux.org.uk> writes:

> Fix these errors reported by the 0-day builder by replacing the
> linux/export.h include with linux/module.h.
>
> In file included from include/linux/platform_device.h:14:0,
>                  from drivers/net/wireless/ath/ath5k/ahb.c:20:
> include/linux/device.h:1463:1: warning: data definition has no type or storage class
>  module_init(__driver##_init); \
>  ^
> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
>   module_driver(__platform_driver, platform_driver_register, \
>   ^~~~~~~~~~~~~
> drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
>  module_platform_driver(ath_ahb_driver);
>  ^~~~~~~~~~~~~~~~~~~~~~
> include/linux/device.h:1463:1: error: type defaults to 'int' in declaration of 'module_init' [-Werror=implicit-int]
>  module_init(__driver##_init); \
>  ^
> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
>   module_driver(__platform_driver, platform_driver_register, \
>   ^~~~~~~~~~~~~
> drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
>  module_platform_driver(ath_ahb_driver);
>  ^~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath5k/ahb.c:233:1: warning: parameter names (without types) in function declaration
> In file included from include/linux/platform_device.h:14:0,
>                  from drivers/net/wireless/ath/ath5k/ahb.c:20:
> include/linux/device.h:1468:1: warning: data definition has no type or storage class
>  module_exit(__driver##_exit);
>  ^
> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
>   module_driver(__platform_driver, platform_driver_register, \
>   ^~~~~~~~~~~~~
> drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
>  module_platform_driver(ath_ahb_driver);
>  ^~~~~~~~~~~~~~~~~~~~~~
> include/linux/device.h:1468:1: error: type defaults to 'int' in declaration of 'module_exit' [-Werror=implicit-int]
>  module_exit(__driver##_exit);
>  ^
> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
>   module_driver(__platform_driver, platform_driver_register, \
>   ^~~~~~~~~~~~~
> drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
>  module_platform_driver(ath_ahb_driver);
>  ^~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath5k/ahb.c:233:1: warning: parameter names (without types) in function declaration
> In file included from include/linux/platform_device.h:14:0,
>                  from drivers/net/wireless/ath/ath5k/ahb.c:20:
> drivers/net/wireless/ath/ath5k/ahb.c:233:24: warning: 'ath_ahb_driver_exit' defined but not used [-Wunused-function]
>  module_platform_driver(ath_ahb_driver);
>                         ^
> include/linux/device.h:1464:20: note: in definition of macro 'module_driver'
>  static void __exit __driver##_exit(void) \
>                     ^~~~~~~~
> drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
>  module_platform_driver(ath_ahb_driver);
>  ^~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath5k/ahb.c:233:24: warning: 'ath_ahb_driver_init' defined but not used [-Wunused-function]
>  module_platform_driver(ath_ahb_driver);
>                         ^
> include/linux/device.h:1459:19: note: in definition of macro 'module_driver'
>  static int __init __driver##_init(void) \
>                    ^~~~~~~~
> drivers/net/wireless/ath/ath5k/ahb.c:233:1: note: in expansion of macro 'module_platform_driver'
>  module_platform_driver(ath_ahb_driver);
>  ^~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Looks good to me:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

I assume Dave will take this so I'll drop the patch from my queue.

-- 
Kalle Valo
