Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 18:53:04 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:48431 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860088AbaG3QxB6xJGD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Jul 2014 18:53:01 +0200
Received: from watt.rr44.fr ([82.228.202.134] helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1XCX7d-0005I3-AS; Wed, 30 Jul 2014 18:53:01 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1XCX7c-0002gs-4E; Wed, 30 Jul 2014 18:53:00 +0200
Date:   Wed, 30 Jul 2014 18:53:00 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Rob Kendrick <rob.kendrick@codethink.co.uk>
Cc:     linux-mips@linux-mips.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 1/1] MIPS: math-emu: cp1emu: Fix typo when returning to
 register file
Message-ID: <20140730165300.GB4848@ohm.rr44.fr>
References: <20140723124154.GA8378@humdrum>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20140723124154.GA8378@humdrum>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Wed, Jul 23, 2014 at 01:41:58PM +0100, Rob Kendrick wrote:
> The commit 08a07904e182895e1205f399465a3d622c0115b8 (v3.16-rc1)
> entitled "MIPS: math-emu: Remove most ifdefery":
> 
> switched from build time to runtime detection for the CPU ISA level.
> 
> However, along the way, a typo was introduced in the code path
> to return the value to the register file. Previously, the
> MIPSInst_FD macro was used but the above commit switched to
> MIPSInst_RT leading to regressions.
> 
> Link: http://www.linux-mips.org/archives/linux-mips/2014-07/msg00484.html
> Reported-by: Rob Kendrick <rob.kendrick@codethink.co.uk>
> Reviewed-by: Paul Burton <paul.burton@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Signed-off-by: Rob Kendrick <rob.kendrick@codethink.co.uk>
> ---
>  arch/mips/math-emu/cp1emu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
> index 736c17a..bf0fc6b 100644
> --- a/arch/mips/math-emu/cp1emu.c
> +++ b/arch/mips/math-emu/cp1emu.c
> @@ -1827,7 +1827,7 @@ dcopuop:
>  	case -1:
>  
>  		if (cpu_has_mips_4_5_r)
> -			cbit = fpucondbit[MIPSInst_RT(ir) >> 2];
> +			cbit = fpucondbit[MIPSInst_FD(ir) >> 2];
>  		else
>  			cbit = FPU_CSR_COND;
>  		if (rv.w)

Looking at commit 8a07904e, the typo looks obvious. Moreover I have
tested that using QEMU, and I can confirm the issue. I can also confirm
the patch fixes the issue.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
