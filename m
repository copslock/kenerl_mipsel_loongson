Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Feb 2014 19:30:42 +0100 (CET)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:55475 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867078AbaBMSajcaaGV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Feb 2014 19:30:39 +0100
Received: by mail-ie0-f171.google.com with SMTP id as1so6741242iec.2
        for <multiple recipients>; Thu, 13 Feb 2014 10:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=e7uVs/L45fYRo+0PoWXQwj4nV5Y6DW1Uq94AM1Hk3jU=;
        b=Y47O+2QSiVUzEat+nO6c4bq00hnLevKFKC6Ak71ExsK1rjOV+jVwgakiZl7KEU2Y73
         6B+NRXQ76adtrzOyeDrJ7mDm4+MhRkpDacY0Yi2C6NEeL13nHKDzsJIYyRJzj3Z7olTC
         OXofuz3cqAAIC/X25H+WQCyUVvSOnLSNemyiFYmGv/gHLvmKBPCvzRjcORqEFOawUTfu
         RVHuzLJALEH8mmr3s9KmGwvbzUOpTOYnrj/v5CsC4ZUeMulQ/ILBy6qFsnprOaNigxYI
         B8NKoD2on3lEdOv+OnI1I0eHydesGorfTo1LUzsO1PoHEnfrzvsZg6ogsUPh6n4ywySD
         xmnA==
X-Received: by 10.50.43.170 with SMTP id x10mr4559112igl.20.1392316232980;
        Thu, 13 Feb 2014 10:30:32 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id dz8sm8992137igb.5.2014.02.13.10.30.31
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 13 Feb 2014 10:30:32 -0800 (PST)
Message-ID: <52FD0F46.6040503@gmail.com>
Date:   Thu, 13 Feb 2014 10:30:30 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org, linux-next@vger.kernel.org,
        linux-kernel@linux-mips.org
Subject: Re: [PATCH] samples/seccomp/Makefile: Do not build tests if cross-compiling
 for MIPS
References: <1392312460-24902-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1392312460-24902-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

Really I think we should add a Kconfig item for this and disable the 
whole directory for targets that do not support it.

David Daney


On 02/13/2014 09:27 AM, Markos Chandras wrote:
> The Makefile is designed to use the host toolchain so it may be
> unsafe to build the tests if the kernel has been configured and built
> for another architecture. This fixes a build problem when the kernel has
> been configured and built for the MIPS architecture but the host is
> not MIPS (cross-compiled). The MIPS syscalls are only defined
> if one of the following is true:
>
> 1) _MIPS_SIM == _MIPS_SIM_ABI64
> 2) _MIPS_SIM == _MIPS_SIM_ABI32
> 3) _MIPS_SIM == _MIPS_SIM_NABI32
>
> Of course, none of these make sense on a non-MIPS toolchain and the
> following build problem occurs when building on a non-MIPS host.
>
> linux/usr/include/linux/kexec.h:50:
> userspace cannot reference function or variable defined in the kernel
> samples/seccomp/bpf-direct.c: In function ‘emulator’:
> samples/seccomp/bpf-direct.c:76:17: error:
> ‘__NR_write’ undeclared (first use in this function)
>
> Cc: linux-next@vger.kernel.org
> Cc: linux-kernel@linux-mips.org
> Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> This problem is only reproducible on the linux-next tree at the moment
> ---
>   samples/seccomp/Makefile | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
> index 7203e66..f6bda1c 100644
> --- a/samples/seccomp/Makefile
> +++ b/samples/seccomp/Makefile
> @@ -17,9 +17,14 @@ HOSTCFLAGS_bpf-direct.o += -I$(objtree)/usr/include
>   HOSTCFLAGS_bpf-direct.o += -idirafter $(objtree)/include
>   bpf-direct-objs := bpf-direct.o
>   
> +# MIPS system calls are defined based on the -mabi that is passed
> +# to the toolchain which may or may not be a valid option
> +# for the host toolchain. So disable tests if target architecture
> +# is mips but the host isn't.
> +ifndef CONFIG_MIPS
>   # Try to match the kernel target.
> -ifndef CONFIG_64BIT
>   ifndef CROSS_COMPILE
> +ifndef CONFIG_64BIT
>   
>   # s390 has -m31 flag to build 31 bit binaries
>   ifndef CONFIG_S390
> @@ -40,3 +45,4 @@ endif
>   
>   # Tell kbuild to always build the programs
>   always := $(hostprogs-y)
> +endif
