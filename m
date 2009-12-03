Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2009 05:50:31 +0100 (CET)
Received: from mail-pz0-f203.google.com ([209.85.222.203]:58018 "EHLO
        mail-pz0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491950AbZLCEu2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2009 05:50:28 +0100
Received: by pzk41 with SMTP id 41so1498427pzk.0
        for <multiple recipients>; Wed, 02 Dec 2009 20:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=gKoLoWmBvtSdWNBcSFxsoYdDuRidrXIZXVQMJ5HQtIU=;
        b=luN3Um5vKQj8mBfigdFT++xURjeg0hCu/5/nC3O22bkTX6NhjURkZ35HEUi/93iD1U
         qd3s9kQa6O5a/9sLyiztY311CUpZu6txUjPX4sVKUhLCb5cvjH2sgRHHeokqOQnlaWBt
         CtNogha3dvjUmjzIReEd15mS/rZh68WYjZjWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=KLHT6fJfgFYNYg+h9RVE95EzDl4KDx5FZgkSxtsts9qOt787XsABg732aP2UX3QJii
         PZ6+KQoQMXVMZRGkBJet0x+bkPMsL85YOx2SKCOiIf/FCv4EfmjmgnY8Tr6qvgVvPAi0
         XouB/UNTjm0P+xOKHoV/dufQJnwHEWVCat2VA=
Received: by 10.114.10.4 with SMTP id 4mr1820951waj.105.1259815818374;
        Wed, 02 Dec 2009 20:50:18 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm1385355pzk.12.2009.12.02.20.50.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Dec 2009 20:50:17 -0800 (PST)
Subject: Re: [PATCH v0] Loongson2: CPUFreq: add support to load module
 automatically
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        cpufreq@vger.kernel.org
In-Reply-To: <8421507f5dfc1a70d1dba92ad7604a8bfaa5a447.1259805106.git.wuzhangjin@gmail.com>
References: <8421507f5dfc1a70d1dba92ad7604a8bfaa5a447.1259805106.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 03 Dec 2009 12:49:55 +0800
Message-ID: <1259815795.4474.34.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

[...]
> diff --git a/arch/mips/loongson/common/platform.c b/arch/mips/loongson/common/platform.c
> new file mode 100644
> index 0000000..fdb24fd
> --- /dev/null
> +++ b/arch/mips/loongson/common/platform.c
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright (C) 2009 Lemote Inc.
> + * Author: Wu Zhangjin, wuzj@lemote.com
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/bootinfo.h>

The above header file is not needed.

Regards,
	Wu Zhangjin
