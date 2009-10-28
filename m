Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 20:24:51 +0100 (CET)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47419 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492887AbZJ1TYo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 20:24:44 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n9SJOVm3028935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Oct 2009 12:24:32 -0700
Received: from akpm.mtv.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id n9SJOUax025198;
	Wed, 28 Oct 2009 12:24:30 -0700
Date:	Wed, 28 Oct 2009 12:24:30 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Alchemy: UARTs are 16550A
Message-Id: <20091028122430.f7670ae2.akpm@linux-foundation.org>
In-Reply-To: <1256756954-29211-2-git-send-email-manuel.lauss@gmail.com>
References: <1256756954-29211-1-git-send-email-manuel.lauss@gmail.com>
	<1256756954-29211-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Wed, 28 Oct 2009 20:09:14 +0100
Manuel Lauss <manuel.lauss@googlemail.com> wrote:

> UART autodetection breaks on the Au1300 but the IP blocks are
> identical, at least in the datasheets.
> 
> Pass uart type on to the 8250 driver via platform data, and move
> the MSR quirk to another place sind autoconf() is now no longer
> called on init.
> 
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
> +		.type		= PORT_16550A,			\
>  	}

The kernel which you patched differs from current mainline here.
