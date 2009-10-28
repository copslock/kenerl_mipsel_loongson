Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 20:36:54 +0100 (CET)
Received: from gateway-1237.mvista.com ([206.112.117.35]:45786 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with SMTP id S1493409AbZJ1Tgh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 20:36:37 +0100
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with SMTP
	id D699B3ECB; Wed, 28 Oct 2009 12:36:21 -0700 (PDT)
Message-ID: <4AE89D2E.4060704@ru.mvista.com>
Date:	Wed, 28 Oct 2009 22:36:14 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Alchemy: UARTs are 16550A
References: <1256756954-29211-1-git-send-email-manuel.lauss@gmail.com> <1256756954-29211-2-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1256756954-29211-2-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:

> UART autodetection breaks on the Au1300 but the IP blocks are
> identical, at least in the datasheets.

> Pass uart type on to the 8250 driver via platform data, and move
> the MSR quirk to another place sind autoconf() is now no longer

    s/sind autoconf/since autoconfig/

> called on init.

> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Tested on DB1200 and DB1300.
> The mips parts apply on top of Ralf's mips-queue tree.
> 
>  arch/mips/alchemy/common/platform.c |    4 +++-
>  drivers/serial/8250.c               |   13 +++++++------
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
> index 195e5b3..3be14b0 100644
> --- a/arch/mips/alchemy/common/platform.c
> +++ b/arch/mips/alchemy/common/platform.c
> @@ -26,7 +26,9 @@
>  		.irq		= _irq,				\
>  		.regshift	= 2,				\
>  		.iotype		= UPIO_AU,			\
> -		.flags		= UPF_SKIP_TEST | UPF_IOREMAP	\
> +		.flags		= UPF_SKIP_TEST | UPF_IOREMAP |	\
> +				  UPF_FIXED_TYPE,		\

    Good to know this has been implemented.

WBR, Sergei
