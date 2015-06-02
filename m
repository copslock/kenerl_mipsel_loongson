Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 22:36:28 +0200 (CEST)
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:50275 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026897AbbFBUgZKstq6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 22:36:25 +0200
Received: from resomta-ch2-14v.sys.comcast.net ([69.252.207.110])
        by resqmta-ch2-08v.sys.comcast.net with comcast
        id bYbj1q0062PT3Qt01YcJmC; Tue, 02 Jun 2015 20:36:18 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-14v.sys.comcast.net with comcast
        id bYcH1q00k42s2jH01YcJvQ; Tue, 02 Jun 2015 20:36:18 +0000
Message-ID: <556E13BB.3070708@gentoo.org>
Date:   Tue, 02 Jun 2015 16:36:11 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Avoid an FPE exception in FCSR mask probing
References: <alpine.LFD.2.11.1506021739230.6751@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1506021739230.6751@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1433277378;
        bh=PYvqfiWnqE+jJajLGTdup2T1hssQDtMIq014IiJCcQQ=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=f2/xlKBz2yq3aHdBcRyqlIB7CJZaUm+GXAOnuuf3/Zi58HEG94emW5HJ1HIdxCBUi
         42TzEwL7c0T75wR64eLq56AdWYFcmlEROBJzGE5GIFtFF1Z5+Zsft4LlMSJ6isduhX
         ku8wtFuoS73dPX05ZdqTNTrJshQt28nKMl05U6iaWARMD/06hXVcvwjuNWMwUUYeq+
         lfdLHilDRtWpGyKQnvD3B8l/ub3nJyagDNLqGUTd2fFzDPwZ5QEhF8CPWE5pGn7OG+
         G0Qfr3KxxJEw2OQuPVd+4JGi8WV6y2KTY8PWl5AWeXF4X9UlHROTZb8d3D+BEVTrLO
         5/oauvK98ORJg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 06/02/2015 12:50, Maciej W. Rozycki wrote:
> Use the default FCSR value in mask probing, avoiding an FPE exception 
> where reset has left any exception enable and their corresponding cause 
> bits set and the register is then rewritten with these bits active.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> linux-mips-fcsr-mask-fix.diff
> Index: linux-org-test/arch/mips/kernel/cpu-probe.c
> ===================================================================
> --- linux-org-test.orig/arch/mips/kernel/cpu-probe.c	2015-06-01 00:43:32.000000000 +0100
> +++ linux-org-test/arch/mips/kernel/cpu-probe.c	2015-06-02 12:14:10.088786000 +0100
> @@ -74,13 +74,12 @@ static inline void cpu_set_fpu_fcsr_mask
>  {
>  	unsigned long sr, mask, fcsr, fcsr0, fcsr1;
>  
> +	fcsr = c->fpu_csr31;
>  	mask = FPU_CSR_ALL_X | FPU_CSR_ALL_E | FPU_CSR_ALL_S | FPU_CSR_RM;
>  
>  	sr = read_c0_status();
>  	__enable_fpu(FPU_AS_IS);
>  
> -	fcsr = read_32bit_cp1_register(CP1_STATUS);
> -
>  	fcsr0 = fcsr & mask;
>  	write_32bit_cp1_register(CP1_STATUS, fcsr0);
>  	fcsr0 = read_32bit_cp1_register(CP1_STATUS);
> 

Tested-by: Joshua Kinard <kumba@gentoo.org>
