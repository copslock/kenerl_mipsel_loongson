Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 21:54:35 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52311 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993177AbdB1Uy3ObKyN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2017 21:54:29 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id E79DA12A12CD2;
        Tue, 28 Feb 2017 20:54:18 +0000 (GMT)
Received: from [10.20.78.26] (10.20.78.26) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 28 Feb 2017
 20:54:22 +0000
Date:   Tue, 28 Feb 2017 20:54:09 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 1/4] MIPS: Handle non word sized instructions when
 examining frame
In-Reply-To: <1488296279-23057-2-git-send-email-matt.redfearn@imgtec.com>
Message-ID: <alpine.DEB.2.00.1702282050410.26999@tp.orcam.me.uk>
References: <1488296279-23057-1-git-send-email-matt.redfearn@imgtec.com> <1488296279-23057-2-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.26]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56934
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

> Since the instruction modifying the stack pointer is usually the first
> in the function, that one is ususally handled correctly. But the

 s/ususally/usually/

> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index 803e255b6fc3..5b1e932ae973 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -347,6 +347,7 @@ static int get_frame_info(struct mips_frame_info *info)
>  	union mips_instruction insn, *ip, *ip_end;
>  	const unsigned int max_insns = 128;
>  	unsigned int i;
> +	unsigned int last_insn_size = 0;

 Please keep declarations in the reverse Christmas tree order, i.e. swap 
the last two.

  Maciej
