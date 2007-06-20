Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2007 15:17:57 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.178]:60287 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20024708AbXFTORz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Jun 2007 15:17:55 +0100
Received: by py-out-1112.google.com with SMTP id f31so385479pyh
        for <linux-mips@linux-mips.org>; Wed, 20 Jun 2007 07:16:52 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z1agr6g73vAaB/WZ+2DFQm9ZKlTrj+KXPRC1de0cGS97+p6OCoYa6X3twZFf4LY8XoaZDhbi8tebONrngr7Vb/BUFyoMa0QTPAYkVJE3fmAiSjHAW3WkXEYIwygKg1gCO29JRCdADeKNnaW6jYk1+6mynjCnDLkJV3uDfdw4BWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f1bp7iIapIkqxjJN9IC9fo1UNXwD+UwhwXs9RtOwL6IGjgf9IALIRM1R9iEeANxHj10rIhRtB+9b7LXzqf8nYoCP5QcWVrmC2+O+A4JAOXyO867ckP68AMoGAYiLYabJSs+OP4qJZQpMg7AosgHFR4OwAaCLLT7wqK4sWTZSBrY=
Received: by 10.64.204.19 with SMTP id b19mr1603125qbg.1182349011511;
        Wed, 20 Jun 2007 07:16:51 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Wed, 20 Jun 2007 07:16:51 -0700 (PDT)
Message-ID: <cda58cb80706200716g6de08bb5hdbe408888abf3de4@mail.gmail.com>
Date:	Wed, 20 Jun 2007 16:16:51 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Adrian Bunk" <bunk@stusta.de>
Subject: Re: [2.6 patch] more MOMENCO_JAGUAR_ATX removal
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20070619202704.GG12950@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070619202704.GG12950@stusta.de>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 6/19/07, Adrian Bunk <bunk@stusta.de> wrote:
> This patch removes the few leftovers of the MOMENCO_JAGUAR_ATX removal.
>

thanks for catching it,

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
>
>  drivers/net/Kconfig    |    2 +-
>  include/asm-mips/war.h |    7 +++----
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> --- linux-2.6.22-rc4-mm2/drivers/net/Kconfig.old        2007-06-18 15:24:49.000000000 +0200
> +++ linux-2.6.22-rc4-mm2/drivers/net/Kconfig    2007-06-18 15:25:02.000000000 +0200
> @@ -2362,7 +2362,7 @@
>
>  config MV643XX_ETH
>         tristate "MV-643XX Ethernet support"
> -       depends on MOMENCO_OCELOT_C || MOMENCO_JAGUAR_ATX || MV64360 || MV64X60 || MOMENCO_OCELOT_3 || (PPC_MULTIPLATFORM && PPC32)
> +       depends on MOMENCO_OCELOT_C || MV64360 || MV64X60 || MOMENCO_OCELOT_3 || (PPC_MULTIPLATFORM && PPC32)

Actually MOMENCO_OCELOT_C has been killed too...

-- 
               Franck
