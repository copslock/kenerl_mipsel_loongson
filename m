Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2007 14:23:44 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:25790 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20024600AbXHXNXg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Aug 2007 14:23:36 +0100
Received: (qmail 23885 invoked by uid 507); 24 Aug 2007 22:07:24 +0800
Received: from unknown (HELO ?10.2.0.23?) (fxzhang@10.2.0.23)
  by ict.ac.cn with SMTP; 24 Aug 2007 22:07:24 +0800
Message-ID: <46CEDC47.3010503@ict.ac.cn>
Date:	Fri, 24 Aug 2007 21:25:27 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: IceDove 1.5.0.10 (X11/20070329)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Sunil Amitkumar Janki <devel.sjanki@gmail.com>,
	linux-mips@linux-mips.org
Subject: Re: Kernel 2.6.23-rc3 build error
References: <46CB0876.5030508@gmail.com> <20070824110729.GA4321@linux-mips.org> <46CEC23D.1090706@gmail.com> <20070824130721.GA27604@linux-mips.org>
In-Reply-To: <20070824130721.GA27604@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

Ralf Baechle 写道:
>
> I've just pushed a fix for the __cmpdi2 problem.  It's a generic MIPS issue
> and I didn't invest the time into figuring out what circumstances exactly
> are required to trigger it.
>
> The references to request_dma and free_dma are a separate Fulong-specific
> issue.  They are the result of platform neither defining GENERIC_ISA_DMA
> nor GENERIC_ISA_DMA_SUPPORT_BROKEN.  I'm not sure if the Fulong contains
> ISA-ish peripherals in its south bridge which are actually being used.
> Maybe else knows?
>   
We don't have any ISA usage so I think it is safe to define 
GENERIC_ISA_DMA or the other one.
>   Ralf
>
>
>
>
>   
