Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 19:16:57 +0100 (CET)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:62676 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825756Ab2JaSQ46BJvr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2012 19:16:56 +0100
Received: by mail-pb0-f49.google.com with SMTP id xa7so1090014pbc.36
        for <linux-mips@linux-mips.org>; Wed, 31 Oct 2012 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=sNWWWo5j/3xoxGXpVGa0Vm9Mc/F6CSlF1Zz8utIWrdI=;
        b=YMw2Pezxb6QqEBtaESRtifsaVCZIDlvlXRlWoCIRkJqhoCLfSFRTZx81sB771w6RF/
         LuCB2N3bGwfnW4siTaSb0Dav9oHa4rR40y/W0RWY93M5eM1ny18jf/z7X/iUmY4KzUg1
         vgNookMb7VPVbc3OAMAlIzNUiDk9S/5MlKR4LKDAb4FwBCqlHdM/NqNskpQxYSFyqvu3
         H7DwruIisDrAQQevA7nJJYNT31yuFqS+/AKIZy5VgxvWv7RGxSvGozNxrZDmhFMVnSlq
         f+EZw8FDB9NQPdzFSiBMwUb1CBfiDav/ryKs7DbhzdpsHsOG2hAXizXn1xjRSc7NTOki
         KF8Q==
Received: by 10.66.90.33 with SMTP id bt1mr103587969pab.49.1351707410155;
        Wed, 31 Oct 2012 11:16:50 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id zv10sm2626916pbc.76.2012.10.31.11.16.28
        (version=SSLv3 cipher=OTHER);
        Wed, 31 Oct 2012 11:16:47 -0700 (PDT)
Message-ID: <50916AFB.1040903@gmail.com>
Date:   Wed, 31 Oct 2012 11:16:27 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 12/20] KVM/MIPS32: Routines to handle specific traps/exceptions
 while executing the guest.
References: <DD56E216-2017-45D0-9623-62E27F56CA58@kymasys.com>
In-Reply-To: <DD56E216-2017-45D0-9623-62E27F56CA58@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34835
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 10/31/2012 08:20 AM, Sanjay Lal wrote:
> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> ---
>   arch/mips/kvm/kvm_cb.c        |  16 ++
>   arch/mips/kvm/kvm_trap_emul.c | 446 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 462 insertions(+)
>   create mode 100644 arch/mips/kvm/kvm_cb.c
>   create mode 100644 arch/mips/kvm/kvm_trap_emul.c
>

At a minimum you should probably follow Documentation/CodingStyle

Running checkpatch.pl on all the patches and fixing obvious problems is 
always a good idea.


> diff --git a/arch/mips/kvm/kvm_cb.c b/arch/mips/kvm/kvm_cb.c
> new file mode 100644
> index 0000000..768198e
> --- /dev/null
> +++ b/arch/mips/kvm/kvm_cb.c
> @@ -0,0 +1,16 @@
> +/*
> +* This file is subject to the terms and conditions of the GNU General Public
> +* License.  See the file "COPYING" in the main directory of this archive
> +* for more details.
> +*
> +* PUT YOUR TITLE AND/OR INFORMATION FOR THE FILE HERE

That line can probably be safely removed.


> +*
> +* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
> +* Authors: Yann Le Du <ledu@kymasys.com>
> +*/
.
.
.

David Daney
