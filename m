Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5CBdgV30091
	for linux-mips-outgoing; Tue, 12 Jun 2001 04:39:42 -0700
Received: from dea.waldorf-gmbh.de (u-243-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.243])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5CBddV30088
	for <linux-mips@oss.sgi.com>; Tue, 12 Jun 2001 04:39:39 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5CBdPI05297;
	Tue, 12 Jun 2001 13:39:25 +0200
Date: Tue, 12 Jun 2001 13:39:25 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: A new mips toolchain is available
Message-ID: <20010612133925.B5106@bacchus.dhis.org>
References: <20010611210311.A8768@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010611210311.A8768@lucon.org>; from hjl@lucon.org on Mon, Jun 11, 2001 at 09:03:11PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 11, 2001 at 09:03:11PM -0700, H . J . Lu wrote:

> I put my new mips toolchain at
> 
> http://ftp.kernel.org/pub/linux/devel/binutils/mips/
> 
> There are source rpms for RedHat 7.1. They may only be built correctly
> with rpm, especially binutils. I can provide mips and mipsel binaries
> rpms for them. But it will take at least a few days.
> 
> BTW, my toolchain is for the SVR4 MIPS ABI. I don't know how compatible
> it is with the IRIX ABI. Old IRIX ABI binaries seem to run fine. But I
> don't know abour the IRIX ABI DSOs.

No known issues except that modutils only works ok with SVR4 ABI flavoured
binaries.


> Also my glibc is compiled with -mmips2 since kernel cannot handle mips I
> glibc.

It's noticable faster also ...

  Ralf
