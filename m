Received:  by oss.sgi.com id <S553896AbRBTHhE>;
	Mon, 19 Feb 2001 23:37:04 -0800
Received: from boco.fee.vutbr.cz ([147.229.9.11]:61198 "EHLO boco.fee.vutbr.cz")
	by oss.sgi.com with ESMTP id <S553869AbRBTHgu>;
	Mon, 19 Feb 2001 23:36:50 -0800
Received: from fest.stud.fee.vutbr.cz (fest.stud.fee.vutbr.cz [147.229.9.16])
	by boco.fee.vutbr.cz (8.11.2/8.11.2) with ESMTP id f1K7agA07256
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified OK);
	Tue, 20 Feb 2001 08:36:47 +0100 (CET)
Received: (from xjezda00@localhost)
	by fest.stud.fee.vutbr.cz (8.11.2/8.11.2) id f1K6n4n68739;
	Tue, 20 Feb 2001 07:49:04 +0100 (CET)
Date:   Tue, 20 Feb 2001 07:49:04 +0100
From:   David Jez <dave.jez@seznam.cz>
To:     ppopov@pacbell.net
Cc:     linux-mips@oss.sgi.com
Subject: Re: redhat 7.0
Message-ID: <20010220074903.A68652@stud.fee.vutbr.cz>
References: <3A901B3F.ADADC601@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A901B3F.ADADC601@pacbell.net>; from ppopov@pacbell.net on Sun, Feb 18, 2001 at 10:58:07AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Feb 18, 2001 at 10:58:07AM -0800, ppopov@pacbell.net wrote:
> 
> Has anyone tried installing 7.0 that's on oss.sgi.com?  The problem I'm
> running into is that after I netboot and mount simple-0.2b as the root
> fs, and install the rpm-4.0 tarball, rpm doesn't work with the
> libraries, or lack of, of that root fs.  It looks like I need an fs with
> a working rpm-4.0, so that I can mount my second disk somewhere and
> install the 7.0 packages.  Any suggestions?
Yes,
If you download rpm-3.0 (I'm not sure, try get newer version) you'll should
be able to work with rpm 4 packages.

> 
> Pete

Best regards,
Dave
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@fest.stud.fee.vutbr.cz
---------=[ ~EOF ]=------------------------------------
