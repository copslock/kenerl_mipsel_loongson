Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 May 2009 12:17:59 +0100 (BST)
Received: from ey-out-1920.google.com ([74.125.78.147]:59800 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022593AbZEWLRl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 23 May 2009 12:17:41 +0100
Received: by ey-out-1920.google.com with SMTP id 13so540684eye.54
        for <linux-mips@linux-mips.org>; Sat, 23 May 2009 04:17:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/WUMM82n8d715lMCT6Z9HUu2Wvq4F6QxfxieFTDjg1k=;
        b=GnWW573FIzIj/5OdlWjs4fl/IqpQupwC0Nyo+eiWzGlYDv6CmzcIn/7fhbTaE9D1l/
         O+/JAZJ8btLArzFNhAuWwIi1xIZlls37Y/sqrOMguTu6Am+WJbcSKYCluRuG0uVlBICb
         bz4ebmJMxKGHctXf+QvAzvb6bXEJNoWKYR6qA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HKK1s1OFF8N5rkhXyDJ4MXvL93/YpZ8m2OJKGeH75uvuhvkY61qCAwEY9kXGfKmQD1
         RcP8CyUQAMssG4sIAXCaUl7WGmjnwAR74KSXT6sxupYZWFPPknHB3kwgDeLICQbMYaKq
         i+gswJr9jlquaOv2QCMQf97eCSE/mDZEaqjF0=
Received: by 10.211.168.5 with SMTP id v5mr1078939ebo.63.1243077460459;
        Sat, 23 May 2009 04:17:40 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 23sm2278151eya.9.2009.05.23.04.17.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 04:17:39 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH 2/4] Alchemy: remove unused au1000_gpio.h header
Date:	Sat, 23 May 2009 13:17:39 +0200
User-Agent: KMail/1.9.9
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
References: <1243023899-10343-1-git-send-email-mano@roarinelk.homelinux.net> <1243023899-10343-2-git-send-email-mano@roarinelk.homelinux.net>
In-Reply-To: <1243023899-10343-2-git-send-email-mano@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200905231317.39263.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Friday 22 May 2009 22:24:57 Manuel Lauss, vous avez écrit :
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

Acked-by: Florian Fainelli <florian@openwrt.org> 

> ---
>  arch/mips/include/asm/mach-au1x00/au1000_gpio.h |   56
> ----------------------- 1 files changed, 0 insertions(+), 56 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mach-au1x00/au1000_gpio.h
>
> diff --git a/arch/mips/include/asm/mach-au1x00/au1000_gpio.h
> b/arch/mips/include/asm/mach-au1x00/au1000_gpio.h deleted file mode 100644
> index d8c96fd..0000000
> --- a/arch/mips/include/asm/mach-au1x00/au1000_gpio.h
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -/*
> - * FILE NAME au1000_gpio.h
> - *
> - * BRIEF MODULE DESCRIPTION
> - *	API to Alchemy Au1xx0 GPIO device.
> - *
> - *  Author: MontaVista Software, Inc.  <source@mvista.com>
> - *          Steve Longerbeam
> - *
> - * Copyright 2001, 2008 MontaVista Software Inc.
> - *
> - *  This program is free software; you can redistribute  it and/or modify
> it - *  under  the terms of  the GNU General  Public License as published
> by the - *  Free Software Foundation;  either version 2 of the  License, or
> (at your - *  option) any later version.
> - *
> - *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> - *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES
> OF - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> DISCLAIMED.  IN - *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY  
> DIRECT, INDIRECT, - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> DAMAGES (INCLUDING, BUT - *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE
> GOODS  OR SERVICES; LOSS OF - *  USE, DATA,  OR PROFITS; OR  BUSINESS
> INTERRUPTION) HOWEVER CAUSED AND ON - *  ANY THEORY OF LIABILITY, WHETHER
> IN  CONTRACT, STRICT LIABILITY, OR TORT - *  (INCLUDING NEGLIGENCE OR
> OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF - *  THIS SOFTWARE, EVEN IF
> ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. - *
> - *  You should have received a copy of the  GNU General Public License
> along - *  with this program; if not, write  to the Free Software
> Foundation, Inc., - *  675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#ifndef __AU1000_GPIO_H
> -#define __AU1000_GPIO_H
> -
> -#include <linux/ioctl.h>
> -
> -#define AU1000GPIO_IOC_MAGIC 'A'
> -
> -#define AU1000GPIO_IN		_IOR(AU1000GPIO_IOC_MAGIC, 0, int)
> -#define AU1000GPIO_SET		_IOW(AU1000GPIO_IOC_MAGIC, 1, int)
> -#define AU1000GPIO_CLEAR	_IOW(AU1000GPIO_IOC_MAGIC, 2, int)
> -#define AU1000GPIO_OUT		_IOW(AU1000GPIO_IOC_MAGIC, 3, int)
> -#define AU1000GPIO_TRISTATE	_IOW(AU1000GPIO_IOC_MAGIC, 4, int)
> -#define AU1000GPIO_AVAIL_MASK	_IOR(AU1000GPIO_IOC_MAGIC, 5, int)
> -
> -#ifdef __KERNEL__
> -extern u32 get_au1000_avail_gpio_mask(void);
> -extern int au1000gpio_tristate(u32 data);
> -extern int au1000gpio_in(u32 *data);
> -extern int au1000gpio_set(u32 data);
> -extern int au1000gpio_clear(u32 data);
> -extern int au1000gpio_out(u32 data);
> -#endif
> -
> -#endif



-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
