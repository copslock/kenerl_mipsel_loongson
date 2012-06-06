Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 10:42:39 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:37421 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903643Ab2FFImf convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Jun 2012 10:42:35 +0200
Received: by wgbdr1 with SMTP id dr1so5461947wgb.24
        for <multiple recipients>; Wed, 06 Jun 2012 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=RO2+4VCm8Jy9LlRVXIy1XN4+6oJISVASfEE8jxtx8u4=;
        b=NHJb8olNtT0G4MGQYu8ppEl7qArfsLSx4uxcCvlfP2oThBB45knpsD7EVckVksdIc9
         zCdMOXY28RmVf30fi3SFlbj2PByKo3FRtwtaRmthnFhza3wocs0CGAt7W9hrA/1oOHNq
         pFzvkNb/xkXFWaiPOEnMwLOoaO0+VvLe9KrJ+8LEhTQXy52oiNbYnEdFzmHKjiCRhpMr
         5T4dnC+urN9AZtnQcUT8ETDAinaCjTU24FNgd+PsIA4IonywbMvhYieHuP5NBvU3OQCq
         KYAGBVyKuykO2jbi9SXyuq24RoqPOmww6caXuhLDTAfes8x4Yb+1AgmOt/SrbpRgty+k
         MiXQ==
MIME-Version: 1.0
Received: by 10.216.218.138 with SMTP id k10mr16991750wep.222.1338972150164;
 Wed, 06 Jun 2012 01:42:30 -0700 (PDT)
Received: by 10.216.152.33 with HTTP; Wed, 6 Jun 2012 01:42:30 -0700 (PDT)
In-Reply-To: <1338931179-9611-24-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
        <1338931179-9611-24-git-send-email-sjhill@mips.com>
Date:   Wed, 6 Jun 2012 14:12:30 +0530
Message-ID: <CA+7sy7BO4wWogt9n=WUemjhBytJpv2CjTgAo0Cw+W9g2WkkWeA@mail.gmail.com>
Subject: Re: [PATCH 23/35] MIPS: Netlogic: Cleanup files effected by firmware changes.
From:   "Jayachandran C." <c.jayachandran@gmail.com>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: c.jayachandran@gmail.com
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

On Wed, Jun 6, 2012 at 2:49 AM, Steven J. Hill <sjhill@mips.com> wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> Make headers consistent across the files and make changes based on
> running the checkpatch script.
>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>  arch/mips/netlogic/xlr/setup.c |   35 +++++------------------------------
>  1 file changed, 5 insertions(+), 30 deletions(-)
>
> diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
> index 113a402..324c071 100644
> --- a/arch/mips/netlogic/xlr/setup.c
> +++ b/arch/mips/netlogic/xlr/setup.c
> @@ -1,37 +1,12 @@
>  /*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
>  * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
>  * reserved.
> - *
> - * This software is available to you under a choice of one of two
> - * licenses.  You may choose to be licensed under the terms of the GNU
> - * General Public License (GPL) Version 2, available from the file
> - * COPYING in the main directory of this source tree, or the NetLogic
> - * license below:
> - *
[....]
> - * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
>  */

Can you drop this? This patch changes the existing license on the file.

Thanks,
JC.
