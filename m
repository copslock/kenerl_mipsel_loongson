Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 18:08:29 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4776 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492506Ab0BARIZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 18:08:25 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b670a500000>; Mon, 01 Feb 2010 09:07:32 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 1 Feb 2010 09:07:20 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 1 Feb 2010 09:07:19 -0800
Message-ID: <4B670A45.3010105@caviumnetworks.com>
Date:   Mon, 01 Feb 2010 09:07:17 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Wu Zhangjin <wuzhangjin@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH -queue 1/3] MIPS: add a common mips_sched_clock()
References: <198fc72d92823547c9be132616fd2ebc2091ff39.1265022593.git.wuzhangjin@gmail.com>
In-Reply-To: <198fc72d92823547c9be132616fd2ebc2091ff39.1265022593.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Feb 2010 17:07:20.0007 (UTC) FILETIME=[038AE570:01CAA361]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin wrote:

> +		"dmultu\t%[cnt],%[mult]\n\t"
> +		"nor\t%[t1],$0,%[shift]\n\t"
> +		"mfhi\t%[t2]\n\t"
> +		"mflo\t%[t3]\n\t"
> +		"dsll\t%[t2],%[t2],1\n\t"
> +		"dsrlv\t%[rv],%[t3],%[shift]\n\t"
> +		"dsllv\t%[t1],%[t2],%[t1]\n\t"

This is unlikely to work in 32-bit kernels.

David Daney
