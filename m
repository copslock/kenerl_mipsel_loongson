Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 00:54:00 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14043 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491811Ab0BAXx4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2010 00:53:56 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b6769990000>; Mon, 01 Feb 2010 15:54:01 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 1 Feb 2010 15:44:22 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 1 Feb 2010 15:44:21 -0800
Message-ID: <4B676755.10600@caviumnetworks.com>
Date:   Mon, 01 Feb 2010 15:44:21 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Guenter Roeck <guenter.roeck@ericsson.com>
CC:     linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH v3] Virtual memory size detection for 64 bit MIPS CPUs
References: <1265064686-31278-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1265064686-31278-1-git-send-email-guenter.roeck@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Feb 2010 23:44:21.0929 (UTC) FILETIME=[7A83B990:01CAA398]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Guenter Roeck wrote:
> Linux kernel 2.6.32 and later allocates memory from the top of virtual memory
> space.
> 
> This patch implements virtual memory size detection for 64 bit MIPS CPUs
> to avoid resulting crashes.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
[...]
>  
> +static inline void cpu_set_vmbits(struct cpuinfo_mips *c)
> +{
> +	if (cpu_has_64bits) {
> +		write_c0_entryhi(0xfffffffffffff000ULL);

macro indicated that we need to avoid hazards here on R4000.

Perhaps adding:

  	back_to_back_c0_hazard();

> +		c->vmbits = fls64(read_c0_entryhi() & 0x3ffffffffffff000ULL);
> +	} else
> +		c->vmbits = 32;
> +}
> +
