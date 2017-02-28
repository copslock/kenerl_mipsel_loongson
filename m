Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 23:04:39 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64025 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993177AbdB1WEcFmHmJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2017 23:04:32 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id AA8E76BA6C8F3;
        Tue, 28 Feb 2017 22:04:20 +0000 (GMT)
Received: from [10.20.78.26] (10.20.78.26) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 28 Feb 2017
 22:04:23 +0000
Date:   Tue, 28 Feb 2017 22:04:10 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 2/4] MIPS: microMIPS: Fix decoding of addiusp
 instruction
In-Reply-To: <1488296279-23057-3-git-send-email-matt.redfearn@imgtec.com>
Message-ID: <alpine.DEB.2.00.1702282153030.26999@tp.orcam.me.uk>
References: <1488296279-23057-1-git-send-email-matt.redfearn@imgtec.com> <1488296279-23057-3-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.26]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Tue, 28 Feb 2017, Matt Redfearn wrote:

> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index 5b1e932ae973..6ba5b775579c 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -386,8 +386,9 @@ static int get_frame_info(struct mips_frame_info *info)
>  
>  					if (ip->halfword[0] & mm_addiusp_func)
>  					{
> -						tmp = (((ip->halfword[0] >> 1) & 0x1ff) << 2);
> -						info->frame_size = -(signed short)(tmp | ((tmp & 0x100) ? 0xfe00 : 0));
> +						tmp = (ip->halfword[0] >> 1) & 0x1ff;
> +						tmp = tmp | ((tmp & 0x100) ? 0xfe00 : 0);
> +						info->frame_size = -(signed short)(tmp << 2);

 Ugh, this is unreadable -- can you please figure out a way to fit it in 
79 columns?  Perhaps by factoring this piece out?

 Also this:

	tmp = (ip->halfword[0] >> 1) & 0x1ff;
	tmp = tmp | ((tmp & 0x100) ? 0xfe00 : 0);

will likely result in better code without the conditional, e.g.:

	tmp = (((ip->halfword[0] >> 1) & 0x1ff) ^ 0x100) - 0x100;

(the usual way to sign-extend).

  Maciej
