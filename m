Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 08:57:42 +0100 (CET)
Received: from kirsty.vergenet.net ([202.4.237.240]:52760 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991976AbcLIH5cf64F8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Dec 2016 08:57:32 +0100
Received: from penelope.kanocho.kobe.vergenet.net (unknown [217.111.208.18])
        by kirsty.vergenet.net (Postfix) with ESMTPSA id 792BA25B853;
        Fri,  9 Dec 2016 18:57:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1481270247; bh=IQ1PGdGXc6BQKdPwBwAQ/9HaKEc9s0qmf+JQ5/PX7C4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkYUJl+vjQXdMovebXAN9iXhVz9/e+QCJ3CtSsroSsq4/H8eLsfa+AK73NOk/OBYP
         eM/lz54R11yylOTBXZ1l2Mz5LDSS1Hw/lk8svi7IZPutB3KOoqDnpesMEm6sE0Vi9i
         1JcahC5+s47RaVrDA8/nnw1pXxtFAbq8Ab1hB3FY=
Received: by penelope.kanocho.kobe.vergenet.net (Postfix, from userid 7100)
        id 4DF4260623; Fri,  9 Dec 2016 08:57:23 +0100 (CET)
Date:   Fri, 9 Dec 2016 08:57:23 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     kexec@lists.infradead.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 0/6] Kexec fixes and updates for MIPS platforms
Message-ID: <20161209075723.GA30610@verge.net.au>
References: <1480672151-18503-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1480672151-18503-1-git-send-email-marcin.nowakowski@imgtec.com>
Organisation: Horms Solutions BV
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
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

On Fri, Dec 02, 2016 at 10:49:05AM +0100, Marcin Nowakowski wrote:
> This patch series tries to bring the support for MIPS up to date and make it more
> generic (fix little-endian support, simplify code for 32/64 bit handling), as well
> as to clean up some existing incorrect code (patches 1-4).
> 
> Patches 5 & 6 add new functionality - passing external DTBs and initrd, especially
> the DTB support is required for platforms that use a recently introduced generic
> kernel infrastructure.
> 
> Note that patch 5 (and 6, as it depends on patch 5) require changes in the kernel
> that are currently pending review:
> https://patchwork.linux-mips.org/patch/14615/
> 
> Core dump support is currently broken on all MIPS kernels and is also pending
> review:
> https://patchwork.linux-mips.org/patch/14587/
> https://patchwork.linux-mips.org/patch/14586/
> 
> Patches 1-4 can be safely added without waiting for kernel patches to be merged,
> but patches 5-6 should be held until the kernel patches are accepted in case changes
> are requested.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org

Thanks, applied.
