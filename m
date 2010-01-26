Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 18:44:27 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17191 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493412Ab0AZRoX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 18:44:23 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b5f29fa0000>; Tue, 26 Jan 2010 09:44:26 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 26 Jan 2010 09:44:15 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 26 Jan 2010 09:44:15 -0800
Message-ID: <4B5F29EE.1060906@caviumnetworks.com>
Date:   Tue, 26 Jan 2010 09:44:14 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: fix dbdma ring destruction memory debugcheck.
References: <1264527242-9214-1-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1264527242-9214-1-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jan 2010 17:44:15.0796 (UTC) FILETIME=[2DC6F740:01CA9EAF]
X-archive-position: 25682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16835

Manuel Lauss wrote:
> DBDMA descriptors need to be located at 32-byte aligned addresses;
> however kmalloc rarely delivers such addresses.  The dbdma code
> works around that by allocating 63 bytes and re-aligning the
> descriptor base afterwards.  Hoewever when freeing memory it does
> not account for this adjustment and trips the kfree debugcheck:
> 

Correct me if I am wrong, but don't kmalloc et al. return blocks aligned 
   boundaries of the size rounded up the the next power of two?  So if 
you need 32-byte aligned addresses, just use a size value of 32 or 
greater.  You wouldn't have to add 63 and do masking and remember the 
membase value as you do in the patch.

David Daney



> Kernel bug detected[#1]:
> [...]
> Call Trace:
> [<80186010>] cache_free_debugcheck+0x284/0x318
> [<801869d8>] kfree+0xe8/0x2a0
> [<8010b31c>] au1xxx_dbdma_chan_free+0x2c/0x7c
> [<80388dc8>] au1x_pcm_dbdma_free+0x34/0x4c
> [<80388fa8>] au1xpsc_pcm_close+0x28/0x38
> [<80383cb8>] soc_codec_close+0x14c/0x1cc
> [<8036dbb4>] snd_pcm_release_substream+0x60/0xac
> [<8036dc40>] snd_pcm_release+0x40/0xa0
> [<8018c7a8>] __fput+0x11c/0x228
> [<80188f60>] filp_close+0x7c/0x98
> [<80189018>] sys_close+0x9c/0xe4
> [<801022a0>] stack_done+0x20/0x3c
> 
> Fix this by recording the address delivered by kmalloc() and using
> it as parameter to kfree().
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
>  arch/mips/alchemy/common/dbdma.c                 |    7 +++++--
>  arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |    1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
> index 40071bd..3b2ccc0 100644
> --- a/arch/mips/alchemy/common/dbdma.c
> +++ b/arch/mips/alchemy/common/dbdma.c
> @@ -411,8 +411,11 @@ u32 au1xxx_dbdma_ring_alloc(u32 chanid, int entries)
>  		if (desc_base == 0)
>  			return 0;
>  
> +		ctp->cdb_membase = desc_base;
>  		desc_base = ALIGN_ADDR(desc_base, sizeof(au1x_ddma_desc_t));
> -	}
> +	} else
> +		ctp->cdb_membase = desc_base;
> +
>  	dp = (au1x_ddma_desc_t *)desc_base;
>  
>  	/* Keep track of the base descriptor. */
> @@ -829,7 +832,7 @@ void au1xxx_dbdma_chan_free(u32 chanid)
>  
>  	au1xxx_dbdma_stop(chanid);
>  
> -	kfree((void *)ctp->chan_desc_base);
> +	kfree((void *)ctp->cdb_membase);
>  
>  	stp->dev_flags &= ~DEV_FLAGS_INUSE;
>  	dtp->dev_flags &= ~DEV_FLAGS_INUSE;
> diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
> index c098b45..8c6b110 100644
> --- a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
> +++ b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
> @@ -305,6 +305,7 @@ typedef struct dbdma_chan_config {
>  	dbdev_tab_t		*chan_dest;
>  	au1x_dma_chan_t		*chan_ptr;
>  	au1x_ddma_desc_t	*chan_desc_base;
> +	u32			cdb_membase; /* kmalloc base of above */
>  	au1x_ddma_desc_t	*get_ptr, *put_ptr, *cur_ptr;
>  	void			*chan_callparam;
>  	void			(*chan_callback)(int, void *);
