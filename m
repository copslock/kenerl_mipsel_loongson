Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3OApIK10428
	for linux-mips-outgoing; Tue, 24 Apr 2001 03:51:18 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3OApGM10422
	for <linux-mips@oss.sgi.com>; Tue, 24 Apr 2001 03:51:16 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 349867D9; Tue, 24 Apr 2001 12:51:14 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id CD3F5F391; Tue, 24 Apr 2001 12:48:28 +0200 (CEST)
Date: Tue, 24 Apr 2001 12:48:28 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Michael Shmulevich <michaels@jungo.com>
Cc: Linux/MIPS <linux-mips@oss.sgi.com>, FR Linux/MIPS <linux-mips@fnet.fr>
Subject: Re: ld.so-1.9.x for mips
Message-ID: <20010424124828.D6256@paradigm.rfc822.org>
References: <3AE44D0A.9080003@jungo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3AE44D0A.9080003@jungo.com>; from michaels@jungo.com on Mon, Apr 23, 2001 at 06:40:58PM +0300
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 23, 2001 at 06:40:58PM +0300, Michael Shmulevich wrote:
> 
> Hi,
> 
> I have seen a compiled version of ld.so-1.9.11_mips on ftp.rfc882.com 
> site.I am searching for its sources.
> 
> Where can I find them, please?

Its ftp.rfc822.org - Any yes there is one in the debian packages
i and Ryan Murray built on all debian ftp server for mips and mipsel.

For non-debianers - You can extract the .deb by using "ar x <file.deb>"
and then you get 2 tar.gz one data which contains the files and
the control.tar.gz which contains the package informations.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
