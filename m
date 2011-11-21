Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 12:53:58 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:33368 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903711Ab1KULxw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 12:53:52 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id D0D5523C0087;
        Mon, 21 Nov 2011 12:53:49 +0100 (CET)
Message-ID: <4ECA3BCD.3050407@openwrt.org>
Date:   Mon, 21 Nov 2011 12:53:49 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Rene Bolldorf <xsecute@googlemail.com>
Subject: Re: [PATCH v3 3/7] MIPS: ath79: make ath724x_pcibios_init visible
 for external code
References: <1321825151-16053-1-git-send-email-juhosg@openwrt.org> <1321825151-16053-4-git-send-email-juhosg@openwrt.org> <4ECA25CD.3050902@mvista.com>
In-Reply-To: <4ECA25CD.3050902@mvista.com>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17195

Hi Sergei,

>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-ath79/pci.h
>> @@ -0,0 +1,20 @@
>> +/*
>> + *  Atheros 724x PCI support
>> + *
>> + *  Copyright (C) 2011 René Bolldorf<xsecute@googlemail.com>
> 
>    No signoff from him? He seems to be the original author...

I have added him to CC, so he can ACK/NACK the patch. However I'm not aware of
any rule which states that each patch must be signed off by the original authors
of the modified code.

I have missed something?

-Gabor
