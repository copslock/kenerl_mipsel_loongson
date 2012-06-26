Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 16:32:01 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:60354 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903842Ab2FZObx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 16:31:53 +0200
Received: by eaaf11 with SMTP id f11so1728825eaa.36
        for <multiple recipients>; Tue, 26 Jun 2012 07:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=TZRAMJQuV2Xhzb7HntpvQgNpdSjjNZEk8/QHyaTdbEc=;
        b=osLK9O/A8OfFLYko+ZKKtKfWW8qITtRm/kyqpWGurlJ0k7CivGC59gRUSxJd7fpOE3
         sO9vnHUJiSFWdKOOKIdNa2JQgXAKwqw39MTXUicOpyFYbJDEMQtFb5jv4SfbvMOnfGCy
         mkki7T/t1sFI3F7yfovrQmaoN2X5pT0T6g8BwX5j4YHxPtY3Wjyzf5Wu9omUt7u+MDrL
         lJuOmw7SVkMzySP//A6O+iEW56+o2D7Q+iSIH2h7sgm9U8X1SWYOU3H/MfdMVdex2wQW
         37RS6W7vbD51sfJ0wVjAs81EcBwyLCc5ZxVZmmKTfKsfVAS+LwOKIYfG0omCi7phrSXU
         QVOA==
Received: by 10.14.96.73 with SMTP id q49mr3265414eef.76.1340721108032;
        Tue, 26 Jun 2012 07:31:48 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id u44sm6008128eeb.7.2012.06.26.07.31.42
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jun 2012 07:31:44 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: Re: [PATCH 05/33] MIPS: AR7: Cleanup files effected by firmware changes.
Date:   Tue, 26 Jun 2012 16:29:08 +0200
Message-ID: <2501952.67ymQ30y5z@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.3 (Linux/3.2.0-24-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <1340685708-14408-6-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com> <1340685708-14408-6-git-send-email-sjhill@mips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 33844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

On Monday 25 June 2012 23:41:20 Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
> 
> Make headers consistent across the files and make changes based on
> running the checkpatch script.
> 
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>  arch/mips/ar7/memory.c   |   18 ++++------------
>  arch/mips/ar7/platform.c |   53 
++++++++++++++++++----------------------------
[snip]
>   */
>  #include <linux/bootmem.h>
>  #include <linux/init.h>
> diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
> index 284b86a..921e42c 100644
> --- a/arch/mips/ar7/platform.c
> +++ b/arch/mips/ar7/platform.c
> @@ -1,22 +1,12 @@
>  /*
> + * This file is subject to the terms and conditions of the GNU General 
Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
>   * Copyright (C) 2006,2007 Felix Fietkau <nbd@openwrt.org>
>   * Copyright (C) 2006,2007 Eugene Konev <ejka@openwrt.org>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  
USA
> + * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.

You are adding MTI's Copyright back here, which I assume is a left-over from 
your first submission.
--
Florian
