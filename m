Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 10:05:21 +0100 (BST)
Received: from smtp2.int-evry.fr ([157.159.10.45]:40156 "EHLO
	smtp2.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20029463AbXJIJFN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Oct 2007 10:05:13 +0100
Received: from meteor.local (unknown [157.159.47.35])
	by smtp2.int-evry.fr (Postfix) with ESMTP id E591D3EF3F8;
	Tue,  9 Oct 2007 11:05:05 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	kaka <share.kt@gmail.com>
Subject: Re: Error opening framebuffer device
Date:	Tue, 9 Oct 2007 11:07:49 +0200
User-Agent: KMail/1.9.6
Cc:	linux-mips@linux-mips.org
References: <eea8a9c90710082258y5bbfc987h83f00d2b48d96fc6@mail.gmail.com> <eea8a9c90710090145mb65a89dr4244050b58a0eea7@mail.gmail.com>
In-Reply-To: <eea8a9c90710090145mb65a89dr4244050b58a0eea7@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200710091107.49453.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: 
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

Hi,

On Tuesday 09 October 2007 10:45:43 kaka wrote:
> *Hi All,*
>
> *While running  the cross compiled directFB example on MIPS chip,*
>
> *
> We tried to install the framebuffer driver(command given at the
> bottom) and we have already created the node fb0.*

Looking at the insmod below, I think the framebuffer did not register 
correctly, so creating the device will not help if the driver is not 
registered.

> # insmod brcmstfb.ko
> brcmstfb: Unknown symbol unregister_framebuffer
> brcmstfb: Unknown symbol BKNI_EnterCriticalSection_tagged
> brcmstfb: Unknown symbol printf
> brcmstfb: Unknown symbol BKNI_DestroyEventGroup
> brcmstfb: Unknown symbol BKNI_WaitForEvent_tagged
> brcmstfb: Unknown symbol BKNI_Printf
> brcmstfb: Unknown symbol __divsf3
> brcmstfb: Unknown symbol BKNI_Vprintf
> brcmstfb: Unknown symbol BKNI_Memset
> brcmstfb: Unknown symbol bnetif_dma_data
> brcmstfb: Unknown symbol bnetif_dma_delete_filter
> brcmstfb: Unknown symbol cleanup_bnetif_dma
> brcmstfb: Unknown symbol BKNI_AcquireMutex_tagged
> brcmstfb: Unknown symbol malloc
> brcmstfb: Unknown symbol BKNI_DestroyMutex
> brcmstfb: Unknown symbol framebuffer_alloc
> brcmstfb: Unknown symbol BKNI_RemoveEventGroup
> brcmstfb: Unknown symbol BKNI_Malloc_tagged
> brcmstfb: Unknown symbol BKNI_CreateEventGroup
> brcmstfb: Unknown symbol BKNI_WaitForGroup
> brcmstfb: Unknown symbol __extendsfdf2
> brcmstfb: Unknown symbol BKNI_SetEvent_tagged
> brcmstfb: Unknown symbol BKNI_Memcpy
> brcmstfb: Unknown symbol BKNI_LinuxKernel_SetIsrTasklet
> brcmstfb: Unknown symbol BKNI_Memcmp
> brcmstfb: Unknown symbol fb_find_mode
> brcmstfb: Unknown symbol fb_dealloc_cmap
> brcmstfb: Unknown symbol bnetif_dma_stop
> brcmstfb: Unknown symbol BKNI_ResetEvent_tagged
> brcmstfb: Unknown symbol BKNI_CreateMutex
> brcmstfb: Unknown symbol BKNI_CreateEvent_tagged
> brcmstfb: Unknown symbol __floatsisf
> brcmstfb: Unknown symbol brcm_dir_entry
> brcmstfb: Unknown symbol register_framebuffer
> brcmstfb: Unknown symbol BKNI_Fail
> brcmstfb: Unknown symbol fb_alloc_cmap
> brcmstfb: Unknown symbol BKNI_Snprintf
> brcmstfb: Unknown symbol BKNI_Delay_tagged
> brcmstfb: Unknown symbol BKNI_LeaveCriticalSection_tagged
> brcmstfb: Unknown symbol BKNI_Sleep_tagged
> brcmstfb: Unknown symbol bnetif_dma_add_filter
> brcmstfb: Unknown symbol BKNI_Free_tagged
> brcmstfb: Unknown symbol BKNI_DestroyEvent_tagged
> brcmstfb: Unknown symbol init_bnetif_dma
> brcmstfb: Unknown symbol framebuffer_release
> brcmstfb: Unknown symbol BKNI_AddEventGroup
> brcmstfb: Unknown symbol BKNI_ReleaseMutex_tagged
> brcmstfb: Unknown symbol __addsf3
> brcmstfb: Unknown symbol free
> insmod: cannot insert `brcmstfb.ko': Unknown symbol in module (2): No
> such file or directory
> #

Did you compile framebuffer support for your kernel ? Because if yes, most 
symbols (I did not check all) used by your drivers seems to be exported with 
EXPORT_SYMBOL, and not EXPORT_SYMBOL_GPL, so your driver, even with a 
proprietary license should be able to access them.

I would recommend you mention your linux version, and the relevant kernel 
configuration parts.
