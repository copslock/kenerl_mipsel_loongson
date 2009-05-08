Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2009 16:25:50 +0100 (BST)
Received: from mail-gx0-f157.google.com ([209.85.217.157]:59349 "EHLO
	mail-gx0-f157.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025089AbZEHPZm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 May 2009 16:25:42 +0100
Received: by gxk1 with SMTP id 1so2961057gxk.0
        for <multiple recipients>; Fri, 08 May 2009 08:25:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=z6TKZXLUyq4/TiNJZ2FAR/LbDB6fBlnyY9zUj0CULFA=;
        b=b2SdgFiWabKwMAHwMiJ5PHXZtE01n07drWNW6EoMcX/1AYOhFBgFOCV8X1N2IsIxf9
         b1SE6k7dre0Ra26pdtZud1hehliEpK/vKIR6VC1HQpN0CnVDi9xErpxnKZTPGcQ7Mz8q
         HmUmc4oAa0LPf+0177DNwchnRP4eIBqmMZghA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=iCotSVbxQS1L9nDEFlFze6v0QTv4ALBwHZCjw3s0BN5yIINnasW9jzYcWQp9sqSDRr
         oXX3lRMM6vwLvh1zOZSlh+zCOBqSLRu4L+6ZZfRYdWC6ziZPoCi8mpiMBcpqD0daqBL+
         NDea65HgzZo7uJaWVswtMaibLUZQDhsLj8tYI=
MIME-Version: 1.0
Received: by 10.90.104.15 with SMTP id b15mr3184953agc.101.1241796335893; Fri, 
	08 May 2009 08:25:35 -0700 (PDT)
In-Reply-To: <20090504225719.GA22417@cuplxvomd02.corp.sa.net>
References: <20090504225719.GA22417@cuplxvomd02.corp.sa.net>
Date:	Fri, 8 May 2009 11:25:35 -0400
X-Google-Sender-Auth: 7beae1d52377b4fc
Message-ID: <7d1d9c250905080825n62f46b2bk254a736d3bce2ec6@mail.gmail.com>
Subject: Re: [PATCH 2/3] mips:powertv: Make kernel command line size 
	configurable (resend)
From:	Paul Gortmaker <paul.gortmaker@windriver.com>
To:	David VomLehn <dvomlehn@cisco.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <paul.gortmaker@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips

On Mon, May 4, 2009 at 6:57 PM, David VomLehn <dvomlehn@cisco.com> wrote:
> Most platforms can get by perfectly well with the default command line size,
> but some platforms need more. This patch allows the command line size to
> be configured for those platforms that need it. The default remains 256
> characters.

The one thing I see when I look at this patch, is that it lands in the
arch/mips/Kconfig -- but is there really anything fundamentally
architecture specific about the allowed length of the kernel command
line?.  It probably belongs somewhere alongside the setting for
LOG_BUF_LEN or similar (and then add the other respective changes
to make all arch actually respect the setting.)

Paul.

>
> Signed-off-by: David VomLehn <dvomlehn@cisco.com>
> ---
>  arch/mips/Kconfig             |    7 +++++++
>  arch/mips/include/asm/setup.h |    2 +-
>  2 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 998e5db..99f7b6d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -780,6 +780,13 @@ config EARLY_PRINTK
>  config SYS_HAS_EARLY_PRINTK
>        bool
>
> +config COMMAND_LINE_SIZE
> +       int "Maximum size of command line passed to kernel from bootloader"
> +       default 256
> +       help
> +         Most systems work well with the default value, but some bootloaders pass more
> +         information on the command line than others. A smaller value is good here.
> +
>  config HOTPLUG_CPU
>        bool
>        default n
> diff --git a/arch/mips/include/asm/setup.h b/arch/mips/include/asm/setup.h
> index e600ced..132e397 100644
> --- a/arch/mips/include/asm/setup.h
> +++ b/arch/mips/include/asm/setup.h
> @@ -1,7 +1,7 @@
>  #ifndef _MIPS_SETUP_H
>  #define _MIPS_SETUP_H
>
> -#define COMMAND_LINE_SIZE      256
> +#define COMMAND_LINE_SIZE      CONFIG_COMMAND_LINE_SIZE
>
>  #ifdef  __KERNEL__
>  extern void setup_early_printk(void);
>
>
