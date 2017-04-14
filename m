Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Apr 2017 01:45:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47186 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993543AbdDNXpms8p0O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Apr 2017 01:45:42 +0200
Date:   Sat, 15 Apr 2017 00:45:42 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 4.4 27/32] MIPS: Force o32 fp64 support on 32bit MIPS64r6
 kernels
In-Reply-To: <20170410163843.079809660@linuxfoundation.org>
Message-ID: <alpine.LFD.2.20.1704150040420.29296@eddie.linux-mips.org>
References: <20170410163839.055472822@linuxfoundation.org> <20170410163843.079809660@linuxfoundation.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Mon, 10 Apr 2017, Greg Kroah-Hartman wrote:

> Force o32 fp64 support in this case by also selecting
> MIPS_O32_FP64_SUPPORT from CPU_MIPS64_R6 if 32BIT.
[...]
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1412,7 +1412,7 @@ config CPU_MIPS32_R6
>  	select CPU_SUPPORTS_MSA
>  	select GENERIC_CSUM
>  	select HAVE_KVM
> -	select MIPS_O32_FP64_SUPPORT
> +	select MIPS_O32_FP64_SUPPORT if 32BIT
>  	help
>  	  Choose this option to build a kernel for release 6 or later of the
>  	  MIPS32 architecture.  New MIPS processors, starting with the Warrior

 Has the patch been misapplied?  Its description refers to CPU_MIPS64_R6, 
however the hunk heading in the diff itself indicates CPU_MIPS32_R6.

  Maciej
