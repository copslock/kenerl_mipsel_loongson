Received:  by oss.sgi.com id <S553811AbRBXADl>;
	Fri, 23 Feb 2001 16:03:41 -0800
Received: from u-183-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.183]:1522
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553796AbRBXAD3>; Fri, 23 Feb 2001 16:03:29 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1NBbe113526;
	Fri, 23 Feb 2001 12:37:40 +0100
Date:   Fri, 23 Feb 2001 12:37:40 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     ldavies@oz.agile.tv
Cc:     linux-mips@oss.sgi.com
Subject: Re: Small remote debug kernels??
Message-ID: <20010223123739.A13254@bacchus.dhis.org>
References: <3A95E682.982AC529@agile.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A95E682.982AC529@agile.tv>; from ldavies@agile.tv on Fri, Feb 23, 2001 at 02:26:42PM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Feb 23, 2001 at 02:26:42PM +1000, Liam Davies wrote:

> I would like to remote debug my kernel.
> On the Cobalt box I have there is (allegedly) a bootloader bug that
> stops the
> kernel being any larger than 1M/2.5M, compressed/uncompressed.

I've never read the bootloader code during my Cobalt time but supposedly
it reserves a fixed amount of memory for loading and decompressing the
kernel.  As the firmware uses gzip routines to decompress the loaded
kernel and has an entire Linux kernel in it for reading the real kernel
from an ext2 filesystem it must be covered by the GPL and you can ask
Cobalt^WSun for the source to change this limit.

> I have stripped the kernel bare but can't get much lower than 6M
> uncompressed.
> 
> Is there any way I can have a mini-remote debugging kernel??

Either your kernel isn't really stripped or you have a huge configuration.
The 64-bit Origin kernel which I'm using here is 3037235 (unstripped) /
1874064 (striped) in size.  Did you strip symbols only and left debug
information in the object file?

  Ralf
