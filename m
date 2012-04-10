Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2012 03:20:48 +0200 (CEST)
Received: from relmlor1.renesas.com ([210.160.252.171]:41667 "EHLO
        relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903693Ab2DJBUm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Apr 2012 03:20:42 +0200
Received: from relmlir2.idc.renesas.com ([10.200.68.152])
 by relmlor1.idc.renesas.com ( SJSMS)
 with ESMTP id <0M2800JUSP0QJH20@relmlor1.idc.renesas.com>; Tue,
 10 Apr 2012 10:19:38 +0900 (JST)
Received: from relmlac3.idc.renesas.com ([10.200.69.23])
 by relmlir2.idc.renesas.com ( SJSMS)
 with ESMTP id <0M28006KVP0Q2K30@relmlir2.idc.renesas.com>; Tue,
 10 Apr 2012 10:19:38 +0900 (JST)
Received: by relmlac3.idc.renesas.com (Postfix, from userid 0)
        id 88E071809F; Tue, 10 Apr 2012 10:19:38 +0900 (JST)
Received: from relmlac3.idc.renesas.com (localhost [127.0.0.1])
        by relmlac3.idc.renesas.com (Postfix) with ESMTP id 786DE1809E; Tue,
 10 Apr 2012 10:19:38 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]  by
 relmlac3.idc.renesas.com with ESMTP id LAC24845; Tue,
 10 Apr 2012 10:19:38 +0900
X-IronPort-AV: E=Sophos;i="4.75,396,1330873200";   d="scan'208";a="76461628"
Received: from unknown (HELO [10.161.69.127]) ([10.161.69.127])
 by relmlii2.idc.renesas.com with ESMTP; Tue, 10 Apr 2012 10:19:36 +0900
Message-id: <4F838AA9.9000202@renesas.com>
Date:   Tue, 10 Apr 2012 10:19:37 +0900
From:   Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120312
 Thunderbird/11.0
MIME-version: 1.0
To:     sjhill@mips.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 02/10] MIPS: Changes to configuration files for SEAD-3
 platform.
References: <1333817315-30091-1-git-send-email-sjhill@mips.com>
 <1333817315-30091-3-git-send-email-sjhill@mips.com>
In-reply-to: <1333817315-30091-3-git-send-email-sjhill@mips.com>
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-archive-position: 32915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi.px@renesas.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 4/8/2012 1:48 AM, Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
> 
> Change MIPS configuration files to add the SEAD-3. Also add
> new default configuration file for a SEAD-3 kernel.
> 
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>  arch/mips/Kbuild.platforms        |    1 +
>  arch/mips/Kconfig                 |   33 +-
>  arch/mips/configs/sead3_defconfig | 1757 +++++++++++++++++++++++++++++++++++++

Why not using 'make savedefconfig'?

>  3 files changed, 1788 insertions(+), 3 deletions(-)
>  create mode 100644 arch/mips/configs/sead3_defconfig
