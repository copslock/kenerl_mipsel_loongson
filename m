Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2016 12:03:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43144 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028544AbcEMKDbO3wkP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2016 12:03:31 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 5786E1F535BB0;
        Fri, 13 May 2016 11:03:22 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 13 May 2016 11:03:25 +0100
Received: from [192.168.154.116] (192.168.154.116) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 13 May
 2016 11:03:25 +0100
Subject: Re: [PATCH] MIPS: Descend into arch/mips/boot/tools while cleaning
To:     Florian Fainelli <f.fainelli@gmail.com>,
        <linux-mips@linux-mips.org>
References: <20160512072127.GQ16402@linux-mips.org>
 <1463097704-23755-1-git-send-email-f.fainelli@gmail.com>
CC:     <ralf@linux-mips.org>, <macro@imgtec.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <5735A66C.4030706@imgtec.com>
Date:   Fri, 13 May 2016 11:03:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1463097704-23755-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

And this one.

Acked-by: Matt Redfearn <matt.redfearn@imgtec.com>

On 13/05/16 01:01, Florian Fainelli wrote:
> arch/mips/boot/tools/relocs was not being cleaned since we did not wire
> this directory into the archclean target, fix that.
>
> Fixes: 5f552da15721 ("MIPS: tools: Add relocs tool")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   arch/mips/Makefile | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 8388ef6a0044..c0b002a09bef 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -404,6 +404,7 @@ endif
>   archclean:
>   	$(Q)$(MAKE) $(clean)=arch/mips/boot
>   	$(Q)$(MAKE) $(clean)=arch/mips/boot/compressed
> +	$(Q)$(MAKE) $(clean)=arch/mips/boot/tools
>   	$(Q)$(MAKE) $(clean)=arch/mips/lasat
>   
>   define archhelp
