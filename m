Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2005 21:23:18 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.206]:36400 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225073AbVDVUXA> convert rfc822-to-8bit;
	Fri, 22 Apr 2005 21:23:00 +0100
Received: by wproxy.gmail.com with SMTP id 57so972861wri
        for <linux-mips@linux-mips.org>; Fri, 22 Apr 2005 13:22:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jgOv23GgDYzMVoBt9g3jg7KUPuNsdZI0z9UhZgjN3kGWAP96OkDO6UUngbicHrGBID1tl9hyS/3aIayDsmuPSpUAS6kJzODhhrc77YoYzE95DtgBJsuOy8Tf2XWSplFAVrMAMC64RoVMiIKX3eyrClx8gAfYwl3+YSoYihTmJ2c=
Received: by 10.54.10.6 with SMTP id 6mr695461wrj;
        Fri, 22 Apr 2005 13:22:53 -0700 (PDT)
Received: by 10.54.41.29 with HTTP; Fri, 22 Apr 2005 13:22:53 -0700 (PDT)
Message-ID: <ecb4efd105042213221c30cac4@mail.gmail.com>
Date:	Fri, 22 Apr 2005 16:22:53 -0400
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: troubles writing to a mmapped PCI BAR
In-Reply-To: <ecb4efd10504211231748d2525@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <ecb4efd10504211231748d2525@mail.gmail.com>
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

On 4/21/05, Clem Taylor <clem.taylor@gmail.com> wrote:
> I'm working on a Au1550 driver for a PCI based co-processor. The
> driver provides mmap() that allows the mapping of a PCI BAR. From
> userspace I can happily read from the mmaped region, but writes just
> hang the user space program. gdb shows that the user program is
> sitting at the write statement. The read() and write() system calls
> work just fine as well.

I saw in drivers/video/epson1356fb.c it was doing:
        // FIXME: shouldn't have to do this. If the pages are marked writeable,
        // the TLB fault handlers should set these.
        pgprot_val(vma->vm_page_prot) |= (_PAGE_DIRTY | _PAGE_VALID);

So I tried adding this before my io_remap_page_range() and it seems to
have fixed my problem. My mmap() write to a PCI device is working now.
I tried setting just the _PAGE_DIRTY bit and that seems to be the
trick. Any ideas why I would need do to this or what is going on?

                        --Clem
