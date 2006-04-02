Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Apr 2006 15:52:41 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:46541 "HELO ict.ac.cn")
	by ftp.linux-mips.org with SMTP id S8133535AbWDBOwd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Apr 2006 15:52:33 +0100
Received: (qmail 12695 invoked by uid 507); 2 Apr 2006 14:15:11 -0000
Received: from unknown (HELO ?192.168.2.202?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 2 Apr 2006 14:15:11 -0000
Message-ID: <442FE7B0.1070209@ict.ac.cn>
Date:	Sun, 02 Apr 2006 23:03:12 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Fuxin Zhang <fxzhang@ict.ac.cn>
CC:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Anyone using marvell 64420 system controller
References: <442FE669.8060606@ict.ac.cn>
In-Reply-To: <442FE669.8060606@ict.ac.cn>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=gb18030
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

I forget to mention that in boot loader things look like quite stable:
memory test is ok(we ported memtest86), loading big files over the
network is ok, gzip/unzip/diff a 40MB file is ok too.

And if we turn on memory debug for slab allocator on 2.6, we often meet
random slab corruptions. It looks like some memory area will be
mysteriously changed.

Fuxin Zhang Ð´µÀ:
> hi,
> 
>   We have been puzzled by the strange problems with our new board with
> marvell 64420 for nearly one month.
> 
> The board is unstable in linux. Using a 2.6.14 kernel it dies very
> easily with file system operations;with a 2.4.22 kernel it can survive
> a "cp -a /usr /usr1", but diffing two identical files with sizes > 50M
> often mistakely reports difference.The diff result is often 32 bytes,but
> the first byte is not cache line aligned(in fact,almost always
> %cachelinesize == 1).
> 
> The results remain true even with ramdisk only and any other pci device
> removed from the board. The same mips CPU works well on other boards,
> the same kernel with different platform chosen is very stable too. So I
> tend to doubt the bridge or its DDR controller.( Is there any possiblity
> of platform related code that lead to such problem? )
> 
> 
> If anyone has experiences on this chip, could you point us some way out?
> It seems we cannot easily reach the marvell's core developers.
> 
> Thanks a lot.
> 
> 
> 
> 
> 
