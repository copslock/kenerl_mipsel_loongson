Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Aug 2007 15:46:44 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:28628 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20024007AbXHZOqf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 26 Aug 2007 15:46:35 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id BD98F3EC9; Sun, 26 Aug 2007 07:46:02 -0700 (PDT)
Message-ID: <46D192C9.7070208@ru.mvista.com>
Date:	Sun, 26 Aug 2007 18:48:41 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Alchemy DMA and GFP_DMA
References: <20070816110501.GA5701@linux-mips.org>
In-Reply-To: <20070816110501.GA5701@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

> arch/mips/au1000/common/dbdma.c uses GFP_DMA in two places and I think
> both instances are uncessary.  Could some alchmist confirm that both are
> unnecessary?

> Thanks,

>   Ralf

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

> diff --git a/arch/mips/au1000/common/dbdma.c b/arch/mips/au1000/common/dbdma.c
> index 626de44..708b83b 100644
> --- a/arch/mips/au1000/common/dbdma.c
> +++ b/arch/mips/au1000/common/dbdma.c
> @@ -397,7 +397,7 @@ au1xxx_dbdma_ring_alloc(u32 chanid, int entries)
>  	 * slabs of memory.
>  	 */
>  	desc_base = (u32)kmalloc(entries * sizeof(au1x_ddma_desc_t),
> -			GFP_KERNEL|GFP_DMA);
> +			GFP_KERNEL);
>  	if (desc_base == 0)
>  		return 0;
>  
> @@ -408,7 +408,7 @@ au1xxx_dbdma_ring_alloc(u32 chanid, int entries)
>  		kfree((const void *)desc_base);
>  		i = entries * sizeof(au1x_ddma_desc_t);
>  		i += (sizeof(au1x_ddma_desc_t) - 1);
> -		if ((desc_base = (u32)kmalloc(i, GFP_KERNEL|GFP_DMA)) == 0)
> +		if ((desc_base = (u32)kmalloc(i, GFP_KERNEL)) == 0)
>  			return 0;
>  
>  		desc_base = ALIGN_ADDR(desc_base, sizeof(au1x_ddma_desc_t));

     Those are probably still necessary because the DBDMA descriptors itselves 
(not the data they address) must have 32-bit addresses.

WBR, Sergei
