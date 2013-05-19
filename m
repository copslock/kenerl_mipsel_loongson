Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 15:36:42 +0200 (CEST)
Received: from mail-la0-f44.google.com ([209.85.215.44]:50465 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835039Ab3ESNglgWufq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 May 2013 15:36:41 +0200
Received: by mail-la0-f44.google.com with SMTP id fr10so5662463lab.31
        for <linux-mips@linux-mips.org>; Sun, 19 May 2013 06:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=OVCfgfgHCtDKo7ddgl2lC4S+L33KG9nLU68D3yqnx2s=;
        b=Udo5LxZnO/fugu7XljenRe2ClgXgxCpNDLIUAXb9Ya7ibWv4e1opafoRsDuqcjuFdS
         TUx6ma9CWEsUr8g3gqgnzclT2rN2CM+LIlzCpPwDNBO5Am6taQZVbJwDrvGC462+hKi3
         Ldigx8f/70YdNnWDmh9hMjYfb8RhemI90PTPCOqaSmGXl0gUT9GLr0jant7bSPhMFndm
         837XPcb7jIaeu2mAJw/ZvNwjE4SrTtdX+ytzNN0q3sVwTCkO4rv2S/yTJ116O0oJdGzb
         mZh0Vxaji0Hd8w7U9U0iGP9nShsB8SLuXvUSWkA51/xU6B3aFubR6vcOXj0RIw3Hg2kO
         xv5Q==
X-Received: by 10.152.116.113 with SMTP id jv17mr26649010lab.35.1368970595656;
        Sun, 19 May 2013 06:36:35 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-148-14.pppoe.mtu-net.ru. [91.76.148.14])
        by mx.google.com with ESMTPSA id d3sm8072722lbe.13.2013.05.19.06.36.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 06:36:34 -0700 (PDT)
Message-ID: <5198D561.9080508@cogentembedded.com>
Date:   Sun, 19 May 2013 17:36:33 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 05/18] KVM/MIPS32-VZ: VZ-ASE assembler wrapper functions
 to set GuestIDs
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <1368942460-15577-6-git-send-email-sanjayl@kymasys.com>
In-Reply-To: <1368942460-15577-6-git-send-email-sanjayl@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkFx79HkxpfabUFka2o+0S8+ghF/4pIQJJ27TcE3b/0OXqRDmAU8Pv9F8VxOUc7vEvPQkMw
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 19-05-2013 9:47, Sanjay Lal wrote:

> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> ---
>   arch/mips/kvm/kvm_vz_locore.S | 74 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 74 insertions(+)
>   create mode 100644 arch/mips/kvm/kvm_vz_locore.S

> diff --git a/arch/mips/kvm/kvm_vz_locore.S b/arch/mips/kvm/kvm_vz_locore.S
> new file mode 100644
> index 0000000..6d037d7
> --- /dev/null
> +++ b/arch/mips/kvm/kvm_vz_locore.S
> @@ -0,0 +1,74 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * KVM/MIPS: Assembler support for hardware virtualization extensions
> + *
> + * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
> + * Authors: Yann Le Du <ledu@kymasys.com>
> + */
> +
> +#include <asm/asm.h>
> +#include <asm/asmmacro.h>
> +#include <asm/regdef.h>
> +#include <asm/mipsregs.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/mipsvzregs.h>
> +
> +#define MIPSX(name)	mips32_ ## name
> +
> +/*
> + * This routine sets GuestCtl1.RID to GUESTCTL1_VZ_ROOT_GUESTID
> + * Inputs: none
> + */
> +LEAF(MIPSX(ClearGuestRID))
> +	.set	push
> +	.set	mips32r2
> +	.set	noreorder
> +	mfc0	t0, CP0_GUESTCTL1
> +	addiu	t1, zero, GUESTCTL1_VZ_ROOT_GUESTID
> +	ins	t0, t1, GUESTCTL1_RID_SHIFT, GUESTCTL1_RID_WIDTH
> +	mtc0	t0, CP0_GUESTCTL1 # Set GuestCtl1.RID = GUESTCTL1_VZ_ROOT_GUESTID
> +	ehb
> +	j	ra

    Not jr?

> +	nop					# BD Slot

    Instruction in the delay slot is usually indented by extra space.

> +	.set    pop
> +END(MIPSX(ClearGuestRID))
> +
> +
> +/*
> + * This routine sets GuestCtl1.RID to a new value
> + * Inputs: a0 = new GuestRID value (right aligned)
> + */
> +LEAF(MIPSX(SetGuestRID))
> +	.set	push
> +	.set	mips32r2
> +	.set	noreorder
> +	mfc0	t0, CP0_GUESTCTL1
> +	ins 	t0, a0, GUESTCTL1_RID_SHIFT, GUESTCTL1_RID_WIDTH
> +	mtc0	t0, CP0_GUESTCTL1		# Set GuestCtl1.RID
> +	ehb
> +	j	ra
> +	nop					# BD Slot

    Same here...

> +	.set	pop
> +END(MIPSX(SetGuestRID))
> +
> +
> +	/*
> +	 * This routine sets GuestCtl1.RID to GuestCtl1.ID
> +	 * Inputs: none
> +	 */
> +LEAF(MIPSX(SetGuestRIDtoGuestID))
> +	.set	push
> +	.set	mips32r2
> +	.set	noreorder
> +	mfc0	t0, CP0_GUESTCTL1		# Get current GuestID
> +	ext 	t1, t0, GUESTCTL1_ID_SHIFT, GUESTCTL1_ID_WIDTH
> +	ins 	t0, t1, GUESTCTL1_RID_SHIFT, GUESTCTL1_RID_WIDTH
> +	mtc0	t0, CP0_GUESTCTL1		# Set GuestCtl1.RID = GuestCtl1.ID
> +	ehb
> +	j	ra
> +	nop 					# BD Slot

    ... and here.

> +	.set	pop
> +END(MIPSX(SetGuestRIDtoGuestID))

WBR, Sergei
