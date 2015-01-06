Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2015 21:07:23 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16074 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026946AbbAFUHVPClQc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jan 2015 21:07:21 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8717726387E3A;
        Tue,  6 Jan 2015 20:07:11 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 6 Jan
 2015 20:07:15 +0000
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 6 Jan 2015
 12:07:10 -0800
Message-ID: <54AC406D.4030106@imgtec.com>
Date:   Tue, 6 Jan 2015 12:07:09 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Tony Wu <tung7970@gmail.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "macro@linux-mips.org" <macro@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: Re: [PATCH] MIPS: 74K/1074K: Fix typo in erratum workaround.
References: <20150106183732-tung7970@googlemail.com>
In-Reply-To: <20150106183732-tung7970@googlemail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 01/06/2015 02:39 AM, Tony Wu wrote:
> In commit 9213ad (MIPS: 74K/1074K: Correct erratum workaround.),
> MIPS_CACHE_VTAG should go to icache.flags.
>
> Signed-off-by: Tony Wu <tung7970@gmail.com>
> Cc: Maciej W. Rozycki <macro@linux-mips.org>
> Cc: Steven J. Hill <Steven.Hill@imgtec.com>
> Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index dd261df..deebd0b 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -902,13 +902,13 @@ static inline void alias_74k_erratum(struct cpuinfo_mips *c)
>   	switch (imp) {
>   	case PRID_IMP_74K:
>   		if (rev <= PRID_REV_ENCODE_332(2, 4, 0))
> -			c->dcache.flags |= MIPS_CACHE_VTAG;
> +			c->icache.flags |= MIPS_CACHE_VTAG;
>   		if (rev == PRID_REV_ENCODE_332(2, 4, 0))
>   			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
>   		break;
>   	case PRID_IMP_1074K:
>   		if (rev <= PRID_REV_ENCODE_332(1, 1, 0)) {
> -			c->dcache.flags |= MIPS_CACHE_VTAG;
> +			c->icache.flags |= MIPS_CACHE_VTAG;
>   			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
>   		}
>   		break;
It is not a typo, it is a special case and an original patch should 
follow the patch

http://patchwork.linux-mips.org/patch/8459/

which has a use of 'cpu_has_vtag_dcache'

- Leonid.
