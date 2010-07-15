Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jul 2010 23:17:15 +0200 (CEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47449 "EHLO
        smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492054Ab0GOVRI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jul 2010 23:17:08 +0200
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
        by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o6FLGsYR017228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 15 Jul 2010 14:16:55 -0700
Received: from akpm.mtv.corp.google.com (localhost [127.0.0.1])
        by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id o6FLGrZn019686;
        Thu, 15 Jul 2010 14:16:54 -0700
Date:   Thu, 15 Jul 2010 14:16:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Matt Fleming <matt@console-pimps.org>,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v6] MMC: Add JZ4740 mmc driver
Message-Id: <20100715141653.1c0b6a8d.akpm@linux-foundation.org>
In-Reply-To: <1279227964-17801-1-git-send-email-lars@metafoo.de>
References: <1278973245-25451-1-git-send-email-lars@metafoo.de>
        <1279227964-17801-1-git-send-email-lars@metafoo.de>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Thu, 15 Jul 2010 23:06:04 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> This patch adds support for the mmc controller on JZ4740 SoCs.
> 
>
> ...
>
> +		if (gpio_is_valid(host->pdata->gpio_power))
> +			gpio_set_value(host->pdata->gpio_power,
> +					!host->pdata->power_active_low);
>
> ...
>

Should this driver have a `depends on GPIOLIB' in Kconfig?
