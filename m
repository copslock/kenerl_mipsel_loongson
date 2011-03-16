Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2011 17:49:14 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17294 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491109Ab1CPQtL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Mar 2011 17:49:11 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d80ea3a0000>; Wed, 16 Mar 2011 09:50:02 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 16 Mar 2011 09:49:06 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 16 Mar 2011 09:49:06 -0700
Message-ID: <4D80EA02.9030605@caviumnetworks.com>
Date:   Wed, 16 Mar 2011 09:49:06 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Jayachandran C <jayachandranc@netlogicmicro.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 3/7] Add XLR/XLS cache and TLB support
References: <cover.1300275485.git.jayachandranc@netlogicmicro.com> <cadf7ed67683e96d920fedc87d8fc5d6dbdccdc7.1300275485.git.jayachandranc@netlogicmicro.com>
In-Reply-To: <cadf7ed67683e96d920fedc87d8fc5d6dbdccdc7.1300275485.git.jayachandranc@netlogicmicro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Mar 2011 16:49:06.0635 (UTC) FILETIME=[106191B0:01CBE3FA]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/16/2011 04:57 AM, Jayachandran C wrote:
[...]
> diff --git a/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
> new file mode 100644
> index 0000000..7740401
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
> @@ -0,0 +1,9 @@
> +#ifndef __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H
> +#define __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H
> +
> +/*
> + * Most of the properties are in cpu->options
> + */
> +#define cpu_has_netlogic_cache	1
> +
> +#endif /* __ASM_MACH_NETLOGIC_CPU_FEATURE_OVERRIDES_H */

Although this will probably work, you will likely get better performance 
if you supply static default values for as many overrides as possible.

David Daney
