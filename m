Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7CKUii23623
	for linux-mips-outgoing; Sun, 12 Aug 2001 13:30:44 -0700
Received: from dea.waldorf-gmbh.de (u-132-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.132])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7CKUfj23620
	for <linux-mips@oss.sgi.com>; Sun, 12 Aug 2001 13:30:42 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7CKTKM21341;
	Sun, 12 Aug 2001 22:29:20 +0200
Date: Sun, 12 Aug 2001 22:29:20 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Hartvig Ekner <hartvige@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Malta kernel config file
Message-ID: <20010812222920.A21308@bacchus.dhis.org>
References: <200108121348.PAA02757@copsun17.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108121348.PAA02757@copsun17.mips.com>; from hartvige@mips.com on Sun, Aug 12, 2001 at 03:48:35PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Aug 12, 2001 at 03:48:35PM +0200, Hartvig Ekner wrote:

> I think I saw somebody ask last week how to configure the kernel
> for the MIPS Malta board.
> 
> In the tar archives on ftp.mips.com, e.g. 
> 
> 	linux-2.4.3.mips-src-01.00.tar.gz
> 
> There are several .config files:
> 
> /home/hartvige/tmp/linux-2.4.3> ll .config*
> -r--r-----   1 hartvige mips       11361 May 25 10:59 .config.atlas
> -r--r-----   1 hartvige mips       11436 May 17 09:59 .config.malta
> -r--r-----   1 hartvige mips       10681 May 17 10:49 .config.malta.64

Keeping the sample config files in the root directory of the tree is
not a good idea as ``make distclean'' will wipe them away.

  Ralf
