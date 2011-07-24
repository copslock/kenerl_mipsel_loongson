Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Jul 2011 17:49:18 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:41225 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491000Ab1GXPtM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 24 Jul 2011 17:49:12 +0200
Message-ID: <4E2C3F43.60700@openwrt.org>
Date:   Sun, 24 Jul 2011 17:50:27 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     ralf@linux-mips.org
CC:     Wanlong Gao <wanlong.gao@gmail.com>, linux-mips@linux-mips.org,
        Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] mips:lantiq:remove the dup include file
References: <1311479980-6756-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1311479980-6756-1-git-send-email-gaowanlong@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 30706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17158

On 24/07/11 05:59, Wanlong Gao wrote:
> linux/leds.h
> linux/reboot.h
> had been included twice in devices.c
>
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  arch/mips/lantiq/devices.c      |    2 --
>  arch/mips/lantiq/xway/devices.c |    2 --
>  2 files changed, 0 insertions(+), 4 deletions(-)

Acked-by: John Crispin <blogic@openwrt.org>
