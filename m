Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f54LwA419446
	for linux-mips-outgoing; Mon, 4 Jun 2001 14:58:10 -0700
Received: from dea.waldorf-gmbh.de (u-99-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.99])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f54Lw3h19422
	for <linux-mips@oss.sgi.com>; Mon, 4 Jun 2001 14:58:04 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f54LshF28007;
	Mon, 4 Jun 2001 23:54:43 +0200
Date: Mon, 4 Jun 2001 23:54:43 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Native compile on the target using RedHat 6.1 rpms - Update
Message-ID: <20010604235443.A27996@bacchus.dhis.org>
References: <20010604223652.C22903@bacchus.dhis.org> <20010604205333.8499.qmail@web11901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010604205333.8499.qmail@web11901.mail.yahoo.com>; from wgowcher@yahoo.com on Mon, Jun 04, 2001 at 01:53:33PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 04, 2001 at 01:53:33PM -0700, Wayne Gowcher wrote:

> I was using binutils found in
> ftp://oss.sgi.com/pub/linux/mips/mipsel-linux/RedHat-6.1/RPMS/mipsel/
> 
> version is 2.10.91-1lm.mipsel.rpm
> 
> Do you have a rpm neweer than this or know where I may
> get one ?

There is one in the Redhat 7.0 directory.  I think we only have big endian
binaries, so you may have to build little endian binaries yourself.

   Ralf
