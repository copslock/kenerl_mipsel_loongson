Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2SFvCM07649
	for linux-mips-outgoing; Wed, 28 Mar 2001 07:57:12 -0800
Received: from boco.fee.vutbr.cz (boco.fee.vutbr.cz [147.229.9.11])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2SFvBM07646
	for <linux-mips@oss.sgi.com>; Wed, 28 Mar 2001 07:57:11 -0800
Received: from fest.stud.fee.vutbr.cz (fest.stud.fee.vutbr.cz [147.229.9.16])
	by boco.fee.vutbr.cz (8.11.3/8.11.3) with ESMTP id f2SFv9t14543
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified OK);
	Wed, 28 Mar 2001 17:57:10 +0200 (CEST)
Received: (from xjezda00@localhost)
	by fest.stud.fee.vutbr.cz (8.11.2/8.11.2) id f2SFv9T59024;
	Wed, 28 Mar 2001 17:57:09 +0200 (CEST)
Date: Wed, 28 Mar 2001 17:57:09 +0200
From: David Jez <dave.jez@seznam.cz>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: loop stuff
Message-ID: <20010328175709.C56054@stud.fee.vutbr.cz>
References: <20010327200219.B32706@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010327200219.B32706@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Mar 27, 2001 at 08:02:19PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Hi,
  Hi Flo,

> does anyone know if the 2.4.2 kernel does support loop devices - I mean
> in the sense of - "It works" - I do have problems with processes like
> mke2fs getting hung while accessing the loop without any error message.
> 
> I am not running 2.4.x on any other platform so i cant verify ...
  Unfortunately this isn't a problem with MIPS platform but whole kernel.
Loopback is broken. You can use mke2fs -o loop <file> instead /dev/loop0,
because loop device will goes to hell.
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@fest.stud.fee.vutbr.cz
---------=[ ~EOF ]=------------------------------------
