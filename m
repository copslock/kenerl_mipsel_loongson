Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7HBlfZ32008
	for linux-mips-outgoing; Fri, 17 Aug 2001 04:47:41 -0700
Received: from dea.waldorf-gmbh.de (u-214-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.214])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7HBlQj31994
	for <linux-mips@oss.sgi.com>; Fri, 17 Aug 2001 04:47:26 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7HBjd405339
	for linux-mips@oss.sgi.com; Fri, 17 Aug 2001 13:45:39 +0200
Received: from dea.waldorf-gmbh.de (u-47-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.47])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7H3Y6j20772
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 20:34:07 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7H3QZr03388;
	Fri, 17 Aug 2001 05:26:35 +0200
Date: Fri, 17 Aug 2001 05:26:35 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: machael thailer <dony.he@huawei.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Where is the first entry point for linux-mips boot?
Message-ID: <20010817052635.A2931@bacchus.dhis.org>
References: <000701c11c8b$77e039e0$8021690a@huawei.com> <20010804071016.A1275@bacchus.dhis.org> <001501c126ca$4a5331a0$8021690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001501c126ca$4a5331a0$8021690a@huawei.com>; from dony.he@huawei.com on Fri, Aug 17, 2001 at 11:11:21AM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 17, 2001 at 11:11:21AM +0800, machael thailer wrote:

> After my custom board  finished initializations, It should load "linux
> kernel" into RAM.
> The question is :  Is this a compressed "linux kernel" just like vmlinux.gz
> of X86 that I should load? Or is it "/usr/src/linux/vmlinux" that is not
> compressed that I should load?

The standard MIPS kernel doesn't support compressed kernels on MIPS.

> And what RAM address should it loaded at?  Since it is linked at
> 0x80200000,Should I load there or at somewhere else?

Obviously to the address it's linked for.  You can adjust that address
as you need.  With compressed kernels it may be necessary to choose a
different address however so the decompressed kernel doesn't overwrite
the compressed kernel during compression.

  Ralf
