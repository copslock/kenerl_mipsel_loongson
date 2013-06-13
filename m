Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jun 2013 18:41:36 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:54225 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817030Ab3FMQleyS6dF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jun 2013 18:41:34 +0200
Received: by mail-pa0-f45.google.com with SMTP id bi5so8247919pad.18
        for <multiple recipients>; Thu, 13 Jun 2013 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qVdQd5l7s17yw9HbGBtWn57VO2SXKCT4Eyqb/DPNDXo=;
        b=g/oUZCGNqPrBqifwmh2dIK6ltADyBkq7o1zm0wGPFR/D4gUGKlrXmYTlvWL0Dg7ED3
         p24/3XldaWmdw13aqXnP9jsDyMYhO7764OTQxC5Q8it9HRdx2ijhZKPXxH+++4e6+5N2
         qvjKsDOl/ESp1oKgREBjn37a9RuoCIeQhY0hVSHWDumDYI1+dW2loNYZ2fiLHTXtTTt/
         spd+4KoSCqX/k7RdYSqmrBL3IAzXY+9JrJE23AcfzOQuoaG8ZGQ6r5eLtocpSZext5jL
         76dJBCxzS7mNE9EGcMnMgNCYDH01NW+RfnbmfNdFDtNV6FpalcD4Jbk9dtnsZXZsqI+V
         Gv3w==
X-Received: by 10.68.196.196 with SMTP id io4mr1613788pbc.166.1371141687819;
        Thu, 13 Jun 2013 09:41:27 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id pq5sm20049835pbc.7.2013.06.13.09.41.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 09:41:26 -0700 (PDT)
Message-ID: <51B9F634.30506@gmail.com>
Date:   Thu, 13 Jun 2013 09:41:24 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        USB list <linux-usb@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Kconfig: Select USB_EHCI_HCD if USB_SUPPORt is
 enabled
References: <1371138134-21216-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1371138134-21216-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36857
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

On 06/13/2013 08:42 AM, Markos Chandras wrote:
> Commit 94d83649e1c2f25c87dc4ead9c2ab073305
> "USB: remove USB_EHCI_BIG_ENDIAN_{DESC,MMIO} depends on architecture symbol"
>
> caused the following regression in cavium_octeon_defconfig:
>
> warning: (MIPS_SEAD3 && PMC_MSP && CPU_CAVIUM_OCTEON) selects
> USB_EHCI_BIG_ENDIAN_MMIO which has unmet direct dependencies
> (USB_SUPPORT && USB && USB_EHCI_HCD)
>
> We fix this problem by selecting the USB_EHCI_HCD missing dependency
> if USB_SUPPORT is enabled.
>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>

NAK.  This is incorrect.

It is completely backwards and forces us to have EHCI unconditionally.

The proper fix is to move USB_EHCI_BIG_ENDIAN_MMIO (and similar other 
Kconifg variables) out of the conditional section and make them 
universally visible/usable.

David Daney


> ---
> This patch is for the upstream-sfr/mips-for-linux-next
> ---
>   arch/mips/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 87ddac9..a058ba8 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1411,6 +1411,7 @@ config CPU_CAVIUM_OCTEON
>   	select CPU_SUPPORTS_HUGEPAGES
>   	select LIBFDT
>   	select USE_OF
> +	select USB_EHCI_HCD if USB_SUPPORT
>   	select USB_EHCI_BIG_ENDIAN_MMIO
>   	help
>   	  The Cavium Octeon processor is a highly integrated chip containing
>
