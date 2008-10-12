Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Oct 2008 13:54:25 +0100 (BST)
Received: from smtp5.pp.htv.fi ([213.243.153.39]:58812 "EHLO smtp5.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S21283729AbYJLMyX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 12 Oct 2008 13:54:23 +0100
Received: from cs181140183.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id 8AB365BC00C;
	Sun, 12 Oct 2008 15:54:22 +0300 (EEST)
Date:	Sun, 12 Oct 2008 15:53:27 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	David Daney <ddaney@avtrex.com>, Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix include paths in malta-amon.c
Message-ID: <20081012125326.GJ31153@cs181140183.pp.htv.fi>
References: <48D52FF4.2000905@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48D52FF4.2000905@avtrex.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

Ralf, can you apply David's patch?

The build error is now in Linus' tree.

TIA
Adrian


On Sat, Sep 20, 2008 at 10:16:36AM -0700, David Daney wrote:
> 
> On linux-queue, malta doesn't build after the include file relocation.
> This should fix it.
> 
> There some occurrences of 'asm-mips' in the comments of quite a few
> files, but this is the only place I found it in any code.
> 
> Signed-off-by: David Daney <ddaney@avtrex.com>
> ---
>  arch/mips/mti-malta/malta-amon.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/mti-malta/malta-amon.c b/arch/mips/mti-malta/malta-amon.c
> index 96236bf..df9e526 100644
> --- a/arch/mips/mti-malta/malta-amon.c
> +++ b/arch/mips/mti-malta/malta-amon.c
> @@ -22,9 +22,9 @@
>  #include <linux/init.h>
>  #include <linux/smp.h>
>  
> -#include <asm-mips/addrspace.h>
> -#include <asm-mips/mips-boards/launch.h>
> -#include <asm-mips/mipsmtregs.h>
> +#include <asm/addrspace.h>
> +#include <asm/mips-boards/launch.h>
> +#include <asm/mipsmtregs.h>
>  
>  int amon_cpu_avail(int cpu)
>  {
