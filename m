Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 07:35:28 +0000 (GMT)
Received: from dfpost.ru ([IPv6:::ffff:194.85.103.225]:34733 "EHLO
	mail.dfpost.ru") by linux-mips.org with ESMTP id <S8224942AbULHHfY>;
	Wed, 8 Dec 2004 07:35:24 +0000
Received: from toch.dfpost.ru (toch.dfpost.ru [192.168.7.60])
	by mail.dfpost.ru (Postfix) with SMTP id 577903E517
	for <linux-mips@linux-mips.org>; Wed,  8 Dec 2004 10:29:45 +0300 (MSK)
Date: Wed, 8 Dec 2004 10:35:42 +0300
From: Dmitriy Tochansky <toch@dfpost.ru>
To: linux-mips@linux-mips.org
Subject: Re: mmap problem
Message-Id: <20041208103542.6964f84f.toch@dfpost.ru>
In-Reply-To: <BAY15-F22AE91D0812E86B5F51579AFB60@phx.gbl>
References: <BAY15-F22AE91D0812E86B5F51579AFB60@phx.gbl>
Organization: Special Technology Center
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <toch@dfpost.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: toch@dfpost.ru
Precedence: bulk
X-list: linux-mips

On Wed, 08 Dec 2004 13:28:30 +0600
"Alexey Shinkin" <alexshinkin@hotmail.com> wrote:

> Hi !
> 
> On Au1550 code like yours works
> 
> I use ioremap_nocache(PhysAddr,length)  to get access from kernel
> level.
  Yes, it works. Even just ioremap()
 
> For access from  userland I don't set any vm_flags in drivers' mmap()
> ,
>   vma->vm_flags is set by kernel to  0x40FB (VM_IO is set and
>   VM_LOCKED isn't).
  I tryed it - same result. :(

> 
> And , as Dan said , pci_resource_* functions used for getting valid
> PCI memory address
  Done! :)
