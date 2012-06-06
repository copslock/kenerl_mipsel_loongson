Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 13:30:39 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:48857 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903701Ab2FFLaZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2012 13:30:25 +0200
Received: by lbbgg6 with SMTP id gg6so5595463lbb.36
        for <linux-mips@linux-mips.org>; Wed, 06 Jun 2012 04:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=hjMUFcH82isCIfSMV0byNX+bLNYsf/wry2UDjS/Je/k=;
        b=a7Ke3Sc9RMBDbPE8fgqG1xj6jHhbLVDgb2t9W/86sidx0kcQdVoEVUbkK7R0YSPRdl
         5xsjVUeCBhiqhNZFk0K4WnSoU7L7ARNZ+mMcrVaCDxaN//r6MZJVJMgwK/MyqEBiJzUm
         4ZEWCfrw48fAjf2Xnz7HDqA0/Dfd152vBPIaqsUl/uEd4hfzDrgM6szeN0AMdm3NRtST
         eguG8bO9tZhdAeCtCW26iuWXPtgWxCzBVU8YJl8X1ZYhQQ/v08lZNlGFlSuvt+UVGnMj
         BFpkqZoB0saE0vxS6zkV1X20jS1S/x5sK2HUryH1hY1N/NBI+T0xVuvEy6rfip73BEjo
         tqXg==
Received: by 10.112.36.195 with SMTP id s3mr9698482lbj.42.1338982218500;
        Wed, 06 Jun 2012 04:30:18 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-86-181.pppoe.mtu-net.ru. [91.79.86.181])
        by mx.google.com with ESMTPS id hm7sm2401053lab.12.2012.06.06.04.30.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 04:30:16 -0700 (PDT)
Message-ID: <4FCF3F2B.1090908@mvista.com>
Date:   Wed, 06 Jun 2012 15:29:47 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 11/35] MIPS: Emma: Cleanup files effected by firmware
 changes.
References: <1338931179-9611-1-git-send-email-sjhill@mips.com> <1338931179-9611-12-git-send-email-sjhill@mips.com>
In-Reply-To: <1338931179-9611-12-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlOzZrthcueGV/rh1nU+qxbg7i0n0dS/GHug63LC1izag6/l5+PeKhWiIVFBiUA0C0Dgl/x
X-archive-position: 33566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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

Hello.

On 06-06-2012 1:19, Steven J. Hill wrote:

> From: "Steven J. Hill"<sjhill@mips.com>

> Make headers consistent across the files and make changes based on
> running the checkpatch script.

    I don't see any checkpatch.pl-related changes.

> Signed-off-by: Steven J. Hill<sjhill@mips.com>
> ---
>   arch/mips/emma/common/prom.c |   25 ++++++++-----------------
>   1 file changed, 8 insertions(+), 17 deletions(-)

> diff --git a/arch/mips/emma/common/prom.c b/arch/mips/emma/common/prom.c
> index 5228584..9a70c4e 100644
> --- a/arch/mips/emma/common/prom.c
> +++ b/arch/mips/emma/common/prom.c
> @@ -1,23 +1,14 @@
>   /*
> - *  Copyright (C) NEC Electronics Corporation 2004-2006
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
>    *
> - *  This file is based on the arch/mips/ddb5xxx/common/prom.c
> + * This is based on the arch/mips/ddb5xxx/common/prom.c file.
> + * GPR board platform device registration (Au1550)
>    *
> - *	Copyright 2001 MontaVista Software Inc.
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + * Copyright 2001 MontaVista Software Inc.
> + * Copyright (C) NEC Electronics Corporation 2004-2006
> + * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.

    Reshuffling the header again hardly qualifies for adding a copyright.

WBR, Sergei
