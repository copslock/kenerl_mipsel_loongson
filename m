Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Dec 2015 17:38:50 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:54020 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007756AbbL0QisFt30P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Dec 2015 17:38:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=z1tQcwHFc55a97CWWtwmWEIHHLuHm+qFIAjFK0IbX4g=; b=ZEHOxAlWsvSBarxgZTaa+vYu5R
        YxU6/+zE2n9A3LhDLDJXOBoRisW5twfrVGJxIgkBtWG4iJo+ysx15kzHd33DfwNxwpTfku2d5Npd7
        svDTCWsfV/Ofoz12EetPj8nz02LzoEtjYpxatjlKgEx1vwHtZjjV5bT8QA67msCSfdnA=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:44153 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86)
        (envelope-from <linux@roeck-us.net>)
        id 1aDELS-001dtm-DU; Sun, 27 Dec 2015 16:38:59 +0000
Date:   Sun, 27 Dec 2015 08:38:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, Michal Marek <mmarek@suse.cz>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix ld-version.sh to handle large 3rd version part
Message-ID: <20151227163839.GA13329@roeck-us.net>
References: <1451170072-22846-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451170072-22846-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Sat, Dec 26, 2015 at 10:47:52PM +0000, James Hogan wrote:
> The ld-version.sh script doesn't handle versions with large (>= 10) 3rd
> version components, because the 2nd component is only multiplied by 10
> times that of the 3rd component.
> 
> For example the following version string:
> GNU ld (Codescape GNU Tools 2015.06-05 for MIPS MTI Linux) 2.24.90
> 
> gives a bogus version number:
>  20000000
> + 2400000
> +  900000 = 23300000
> 
> Breakage, confusion and mole-whacking ensues.
> 
> Increase the multipliers of the first two version components by a factor
> of 10 to give space for a 3rd components of up to 99, and update the
> sole user of ld-ifversion (MIPS VDSO) accordingly.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Michal Marek <mmarek@suse.cz>
> Cc: Guenter Roeck <linux@roeck-us.net>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> Cc: linux-mips@linux-mips.org
> ---
> This is based on top of mips-for-linux-next with Guenter's patch "MIPS:
> VDSO: Fix build error with binutils 2.24 and earlier" applied first.
> 
> Ralf: Please consider applying to hopefully fix the VDSO build issue
> once and for all.
> 
> Andi/Michal: If this patch gets merged, I'm guessing the patch "Kbuild,
> lto: Add Link Time Optimization support v3" will need tweaking when it
> gets merged.
> ---
>  arch/mips/vdso/Makefile | 2 +-
>  scripts/ld-version.sh   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
> index 14568900fc1d..ee3617c0c5e2 100644
> --- a/arch/mips/vdso/Makefile
> +++ b/arch/mips/vdso/Makefile
> @@ -26,7 +26,7 @@ aflags-vdso := $(ccflags-vdso) \
>  # the comments on that file.
>  #
>  ifndef CONFIG_CPU_MIPSR6
> -  ifeq ($(call ld-ifversion, -lt, 22500000, y),y)
> +  ifeq ($(call ld-ifversion, -lt, 225000000, y),y)
>      $(warning MIPS VDSO requires binutils >= 2.25)
>      obj-vdso-y := $(filter-out gettimeofday.o, $(obj-vdso-y))
>      ccflags-vdso += -DDISABLE_MIPS_VDSO
> diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
> index 198580d245e0..0b67edc5bc6f 100755
> --- a/scripts/ld-version.sh
> +++ b/scripts/ld-version.sh
> @@ -3,6 +3,6 @@
>  	{
>  	gsub(".*)", "");
>  	split($1,a, ".");
> -	print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
> +	print a[1]*100000000 + a[2]*1000000 + a[3]*10000 + a[4]*100 + a[5];
>  	exit
>  	}
> -- 
> 2.4.10
> 
