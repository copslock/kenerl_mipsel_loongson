Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2011 13:11:08 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:52968 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491188Ab1AYMLF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jan 2011 13:11:05 +0100
Received: by eyd9 with SMTP id 9so2335687eyd.36
        for <multiple recipients>; Tue, 25 Jan 2011 04:11:01 -0800 (PST)
Received: by 10.14.136.17 with SMTP id v17mr5889716eei.29.1295957460625;
        Tue, 25 Jan 2011 04:11:00 -0800 (PST)
Received: from [192.168.2.2] ([91.79.103.63])
        by mx.google.com with ESMTPS id u1sm11058636eeh.10.2011.01.25.04.10.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 04:10:59 -0800 (PST)
Message-ID: <4D3EBD8F.2060608@mvista.com>
Date:   Tue, 25 Jan 2011 15:09:51 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     "Anoop P.A" <anoop.pa@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] Cpu features overrides for msp platforms.
References: <1295943797-20467-1-git-send-email-anoop.pa@gmail.com>
In-Reply-To: <1295943797-20467-1-git-send-email-anoop.pa@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 25-01-2011 11:23, Anoop P.A wrote:

> From: Anoop P A<anoop.pa@gmail.com>


> Signed-off-by: Anoop P A<anoop.pa@gmail.com>
[...]

> diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/cpu-feature-overrides.h b/arch/mips/include/asm/pmc-sierra/msp71xx/cpu-feature-overrides.h
> new file mode 100644
> index 0000000..a80801b
> --- /dev/null
> +++ b/arch/mips/include/asm/pmc-sierra/msp71xx/cpu-feature-overrides.h
> @@ -0,0 +1,21 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2003, 04, 07 Ralf Baechle (ralf@linux-mips.org)

    If you're the author, how come it's Ralf's copyright here?

WBR, Sergei
