Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f841Ikj06526
	for linux-mips-outgoing; Mon, 3 Sep 2001 18:18:46 -0700
Received: from dea.linux-mips.net (u-155-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.155])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f841Ihd06523
	for <linux-mips@oss.sgi.com>; Mon, 3 Sep 2001 18:18:44 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f841IDl08799;
	Tue, 4 Sep 2001 03:18:13 +0200
Date: Tue, 4 Sep 2001 03:18:13 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Fuxin Zhang <fxzhang@ict.ac.cn>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: kernel test & benchmark tools?
Message-ID: <20010904031813.B8728@dea.linux-mips.net>
References: <200109031754.f83Hsod32239@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109031754.f83Hsod32239@oss.sgi.com>; from fxzhang@ict.ac.cn on Tue, Sep 04, 2001 at 01:56:42AM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Sep 04, 2001 at 01:56:42AM +0800, Fuxin Zhang wrote:

> hello,linux-mips
>     I have barely finished porting 2.4 kernel to Algorithmics P6032 board.Now I want
> to make it more stable and run faster,is there any well-known test or benchmark tools used
> by mips kernel group? There are too many benchmark around,I don't know which is better suit
> for kernel test. I heard that linus use lmbench?

lmbench is just a microbenchmark which tests certain very specific aspects
of the system call interface.  Application performance can be very different.
I suggest to search google or a well sorted ftp server for benchmarks - there
are many.

  Ralf
