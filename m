Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2011 11:05:23 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:35323 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490980Ab1AFKFU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Jan 2011 11:05:20 +0100
Message-ID: <4D25941E.80702@openwrt.org>
Date:   Thu, 06 Jan 2011 11:06:22 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     David Woodhouse <dwmw2@infradead.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 07/10] MIPS: lantiq: add NOR flash CFI address swizzle
References: <1294257379-417-1-git-send-email-blogic@openwrt.org> <1294257379-417-8-git-send-email-blogic@openwrt.org>
In-Reply-To: <1294257379-417-8-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

On 05/01/11 20:56, John Crispin wrote:
>  
>  	adr += chip->start;
> +#ifdef CONFIG_MTD_CFI_CMD_SWIZZLE
> +	adr ^= 2;
> +#endif
>  
>  	mutex_lock(&chip->mutex);
>  	ret = get_chip(map, chip, adr, FL_WRITING);
>   

Hi,

What this patch essentially does is to make sure to pass a addr with the
^=2 hack already applied, so that the complex map ends up with an un
swizzled addr as it applies the hack internally again.

I think it would be cleanest to extend the read/write callbacks of
struct map_info; with a flag indicating whether we are doing a CMD or
DATA action. as the 2 following macros are used anyway, it should not be
too hard to implement this.

#define map_read(map, ofs) (map)->read(map, ofs)
#define map_write(map, datum, ofs) (map)->write(map, datum, ofs)

I am not sure however if this is the correct fix.

Thanks,
John
