Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 10:46:38 +0000 (GMT)
Received: from directfb.org ([212.227.87.76]:44506 "EHLO www.directfb.org")
	by ftp.linux-mips.org with ESMTP id S20029764AbXKTKqK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2007 10:46:10 +0000
Received: from [88.134.87.7] (helo=[10.1.1.6])
	by www.directfb.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <dok@directfb.org>)
	id 1IuQZB-0003PJ-7V; Tue, 20 Nov 2007 11:42:53 +0100
Message-ID: <4742BA25.9070208@directfb.org>
Date:	Tue, 20 Nov 2007 11:42:45 +0100
From:	Denis Oliver Kropp <dok@directfb.org>
User-Agent: Thunderbird 2.0.0.6 (X11/20070803)
MIME-Version: 1.0
To:	kaka <share.kt@gmail.com>
CC:	linux-mips@linux-mips.org, uclinux-dev@uclinux.org,
	celinux-dev@tree.celinuxforum.org,
	linux-fbdev-users@lists.sourceforge.net,
	directfb-users@directfb.org, directfb-dev@directfb.org
Subject: Re: Usage of mmap command
References: <eea8a9c90711192239q6009cbb8y76790fa73bc4a5b7@mail.gmail.com>	 <47429AEF.3010403@directfb.org> <eea8a9c90711200140w46bda8cek6ee1a1817db9ae0d@mail.gmail.com>
In-Reply-To: <eea8a9c90711200140w46bda8cek6ee1a1817db9ae0d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dok@directfb.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dok@directfb.org
Precedence: bulk
X-list: linux-mips

kaka wrote:
> Hi Denis,
> 
> Thanks for the reply.
> I am writing gfxdriver for directFB library for broadcom chip.
> I have also written a frambuffer driver for broadcom chip.

Directly for broadcom or at another company?

> In directFB code,
> 
> static volatile void *
> system_map_mmio( unsigned int    offset,
>                  int             length )
> {
>      void *addr;
> 
>      if (length <= 0)
>           length = dfb_fbdev->shared->fix.mmio_len;
> 
>      addr = mmap( NULL, length, PROT_READ | PROT_WRITE, MAP_SHARED,
>                   dfb_fbdev->fd, dfb_fbdev->shared->fix.smem_len + offset );
>      if ((int)(addr) == -1) {
>           D_PERROR( "DirectFB/FBDev: Could not mmap MMIO region "
>                      "(offset %d, length %d)!\n", offset, length );
>           return NULL;
>      }
> 
>      return(volatile void*) ((u8*) addr + (dfb_fbdev->shared->fix.mmio_start&
>                                            dfb_fbdev->shared->page_mask));
> }

Can you add printfs to show dfb_fbdev->shared->fix.mmio_start, mmio_len,
smem_start and smem_len?

> the length and offset i am providing as 0 and -1.

You mean offset 0 and length -1?

> It is throwing me error as Could not mmap MMIO region.
> length coming from dfb_fbdev->shared->fix.smem_len is 16,00,000.

1600000 = 1.6MB?

> When i change the code to  addr = mmap( NULL, 900000, PROT_READ |
> PROT_WRITE, MAP_SHARED, dfb_fbdev->fd, dfb_fbdev->shared->fix.smem_len +
> offset );

You changed the length to 900000, but you need to use this to map offset
900000:

addr = mmap( NULL, length, PROT_READ | PROT_WRITE, MAP_SHARED,
dfb_fbdev->fd, 900000 );

But it should work if you set smem_len to 900000 in the fb driver.

> Then it works fine but it is not allowing me to write to addresses with
> offset greater than 900000.

Segfault?

> My requirement is to write in to the MMIO registers with offset between
> 900000 and 16 00 000.

What exactly is your frame buffer size and physical MMIO address?

You need to put the frame buffer size into smem_len and the physical
MMIO address into mmio_start, the length into mmio_len.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"
