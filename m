Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2009 17:56:34 +0100 (CET)
Received: from mail-fx0-f211.google.com ([209.85.220.211]:59477 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494041AbZKSQ42 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2009 17:56:28 +0100
Received: by fxm3 with SMTP id 3so2612798fxm.24
        for <linux-mips@linux-mips.org>; Thu, 19 Nov 2009 08:56:21 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=DSBFvjnllgoZvzVHvNUOaWMW1T02H3KNvI3Vn9iDvac=;
        b=tQcH/DYqL5F7uk/L3an8hsa/uCK09RVM0eqspN0ZVwokvBz6MUnpYxbkP++zYISZHy
         QG1FujTdK9W7MO7wwuYiikXsku/l64bPfZS8jp/tKWpdmggUDavV/yRHwq1x0v4h/co4
         cOsl6RpxcMGFBKaBrKNa+GjAIXpeuEQ+ujdD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=q9VuUnynO6t/kJZX94OrrV3ODIvklkOC3wbzo2/lkG/9KxT7DOFyn5enDdd1fkHPOs
         ZjaXh6rHnNKci+KEs/L22evfLqWFvor/zKTp820399cZRB/jGQtaj+/b5AnZSzTQIFNq
         VB2HmCYZWG5Mts0/sQHTFgb2B2KkF4RUiwcmI=
MIME-Version: 1.0
Received: by 10.223.21.3 with SMTP id h3mr37214fab.39.1258649781762; Thu, 19 
	Nov 2009 08:56:21 -0800 (PST)
In-Reply-To: <20091119164009.GA15038@deprecation.cyrius.com>
References: <20091119164009.GA15038@deprecation.cyrius.com>
Date:	Thu, 19 Nov 2009 18:56:21 +0200
Message-ID: <90edad820911190856m62275563yf610c4a7dcdd1f67@mail.gmail.com>
Subject: Re: Disable EARLY_PRINTK on IP22 to make the system boot
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Nov 19, 2009 at 6:40 PM, Martin Michlmayr <tbm@cyrius.com> wrote:
> Some Debian users have reported that the kernel hangs early
> during boot on some IP22 systems.  Thomas Bogendoerfer found
> that this is due to a "bad interaction between CONFIG_EARLY_PRINTK
> and overwritten prom memory during early boot".  Since there's
> no fix yet, disable CONFIG_EARLY_PRINTK for now.

Never experienced anything like that, although I'm quite extensively
using IP22 with recent kernels. Any details on the hangs?

Thanks,
Dmitri

>
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 1aad0d9..42e1ac1 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -358,7 +358,9 @@ config SGI_IP22
>        select SWAP_IO_SPACE
>        select SYS_HAS_CPU_R4X00
>        select SYS_HAS_CPU_R5000
> -       select SYS_HAS_EARLY_PRINTK
> +# Disable EARLY_PRINTK for now since it leads to overwritten prom memory
> +# during early boot on some machines.
> +#      select SYS_HAS_EARLY_PRINTK
>        select SYS_SUPPORTS_32BIT_KERNEL
>        select SYS_SUPPORTS_64BIT_KERNEL
>        select SYS_SUPPORTS_BIG_ENDIAN
>
> --
> Martin Michlmayr
> http://www.cyrius.com/
>
>
