Received:  by oss.sgi.com id <S553740AbQJ2Q1T>;
	Sun, 29 Oct 2000 08:27:19 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:27147 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553714AbQJ2Q1F>;
	Sun, 29 Oct 2000 08:27:05 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 9EF84815; Sun, 29 Oct 2000 17:27:02 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 75B1A900C; Sun, 29 Oct 2000 17:25:17 +0100 (CET)
Date:   Sun, 29 Oct 2000 17:25:17 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com
Subject: atomic.h changes fixed bug Was: CVS Update@oss.sgi.com: linux
Message-ID: <20001029172517.C2663@paradigm.rfc822.org>
References: <20001026235921Z553785-493+346@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001026235921Z553785-493+346@oss.sgi.com>; from ralf@oss.sgi.com on Thu, Oct 26, 2000 at 04:59:17PM -0700
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Oct 26, 2000 at 04:59:17PM -0700, Ralf Baechle wrote:
> CVSROOT:	/home/pub/cvs
> Module name:	linux
> Changes by:	ralf@oss.sgi.com	00/10/26 16:59:17
> 
> Modified files:
> 	include/asm-mips: atomic.h 
> 	include/asm-mips64: atomic.h 
> 
> Log message:
> 	Add memory clobbers to the atomic_*_return functions.  I hope this
> 	fixes the file corruption / `D' state processes people observe.

This at least fixes the file corruption stuff i have been seeing
(Never The Same Checksum aka NTSC)


remake:/home/flo# md5sum xfree86_4.0.1.orig.tar.gz
590767187e145407bcda582facf5afc0  xfree86_4.0.1.orig.tar.gz
remake:/home/flo# md5sum xfree86_4.0.1.orig.tar.gz
590767187e145407bcda582facf5afc0  xfree86_4.0.1.orig.tar.gz
remake:/home/flo# md5sum xfree86_4.0.1.orig.tar.gz
590767187e145407bcda582facf5afc0  xfree86_4.0.1.orig.tar.gz
remake:/home/flo# md5sum xfree86_4.0.1.orig.tar.gz
590767187e145407bcda582facf5afc0  xfree86_4.0.1.orig.tar.gz
remake:/home/flo# md5sum xfree86_4.0.1.orig.tar.gz
590767187e145407bcda582facf5afc0  xfree86_4.0.1.orig.tar.gz


Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
