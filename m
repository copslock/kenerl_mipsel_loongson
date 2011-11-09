Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 08:31:26 +0100 (CET)
Received: from t111.niisi.ras.ru ([193.232.173.111]:33011 "EHLO
        t111.niisi.ras.ru" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903541Ab1KIHbU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2011 08:31:20 +0100
Received: from aa19.niisi.msk.ru (aa19.niisi.msk.ru [172.16.0.19] (may be forged))
        by t111.niisi.ras.ru (8.13.8/8.13.8) with ESMTP id pA97VAIP018211
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 9 Nov 2011 11:31:10 +0400
Received: from [192.168.173.2] (aa248 [172.16.0.248])
        by aa19.niisi.msk.ru (8.13.8/8.13.8) with ESMTP id pA97V9XX025213;
        Wed, 9 Nov 2011 11:31:09 +0400
Message-ID: <4EBA2E65.3010009@niisi.msk.ru>
Date:   Wed, 09 Nov 2011 11:40:21 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Al Cooper <alcooperx@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Kernel hangs occasionally during boot.
References: <y> <1320764341-4275-1-git-send-email-alcooperx@gmail.com> <20111108175532.GA15493@linux-mips.org>
In-Reply-To: <20111108175532.GA15493@linux-mips.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Dr.Web (R) for Mail Servers on t111.niisi.ras.ru host
X-Antivirus-Code: 100000
X-archive-position: 31447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7498

On 08.11.2011 21:55, Ralf Baechle wrote:
> but we may need another hazard barrier to
> replace back_to_back_c0_hazard().
Urgently. We need some ticks to wait until counter state machine has 
been updated. The amount of ticks may occasionally be the same as in 
case of back_to_back_hazard for some cpus. It's completely different for 
others, I sure. Original compare_change_hazard waits up to 12 ticks for 
r4k. While I don't think this amount should depend on irq_disable_hazard 
as old code assumes, we may still need 12 or so ticks for old cpus.

> Author: Al Cooper <alcooperx@gmail.com> Tue Nov 8 09:59:01 2011 -0500
> Comitter: Ralf Baechle <ralf@linux-mips.org> Tue Nov 8 16:52:51 2011 +0000
> Commit: 9121470d99c029493bd55daa11607b398fe9aea3
> Gitweb: http://git.linux-mips.org/g/linux/9121470d
Could you fix those links, it's broken after you moved git repo in?

Regards,
Gleb.
