Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 11:21:06 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:37090 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903711Ab1KUKU5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 11:20:57 +0100
Received: by bkat2 with SMTP id t2so8397055bka.36
        for <multiple recipients>; Mon, 21 Nov 2011 02:20:52 -0800 (PST)
Received: by 10.205.132.16 with SMTP id hs16mr13626247bkc.7.1321870851661;
        Mon, 21 Nov 2011 02:20:51 -0800 (PST)
Received: from [192.168.2.2] (ppp85-141-190-27.pppoe.mtu-net.ru. [85.141.190.27])
        by mx.google.com with ESMTPS id dq2sm6861286bkb.11.2011.11.21.02.20.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 02:20:50 -0800 (PST)
Message-ID: <4ECA25CD.3050902@mvista.com>
Date:   Mon, 21 Nov 2011 14:19:57 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Rene Bolldorf <xsecute@googlemail.com>
Subject: Re: [PATCH v3 3/7] MIPS: ath79: make ath724x_pcibios_init visible
 for external code
References: <1321825151-16053-1-git-send-email-juhosg@openwrt.org> <1321825151-16053-4-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1321825151-16053-4-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 31852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17094

Hello.

On 21-11-2011 1:39, Gabor Juhos wrote:

> Signed-off-by: Gabor Juhos<juhosg@openwrt.org>
> ---
> v3: - no changes
> v2: - fix a typo in my e-mail address
[...]

> diff --git a/arch/mips/include/asm/mach-ath79/pci.h b/arch/mips/include/asm/mach-ath79/pci.h
> new file mode 100644
> index 0000000..7ef8a49
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-ath79/pci.h
> @@ -0,0 +1,20 @@
> +/*
> + *  Atheros 724x PCI support
> + *
> + *  Copyright (C) 2011 René Bolldorf<xsecute@googlemail.com>

    No signoff from him? He seems to be the original author...

WBR, Sergei
