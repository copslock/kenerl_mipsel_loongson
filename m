Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBE4qgt12768
	for linux-mips-outgoing; Thu, 13 Dec 2001 20:52:42 -0800
Received: from yog-sothoth.sgi.com (eugate.sgi.com [192.48.160.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBE4qco12764
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 20:52:39 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by yog-sothoth.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam-europe) via ESMTP id EAA997594
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 04:52:13 +0100 (CET)
	mail_from (kaos@ocs.com.au)
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180])
	by nodin.corp.sgi.com (8.11.4/8.11.2/nodin-1.0) with ESMTP id fBE3pS417866063;
	Thu, 13 Dec 2001 19:51:29 -0800 (PST)
Received: by kao2.melbourne.sgi.com (Postfix, from userid 16331)
	id 2AA94300090; Fri, 14 Dec 2001 14:51:26 +1100 (EST)
Received: from kao2.melbourne.sgi.com (localhost [127.0.0.1])
	by kao2.melbourne.sgi.com (Postfix) with ESMTP
	id D3EC896; Fri, 14 Dec 2001 14:51:26 +1100 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Geoffrey Espin <espin@idiom.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: No bzImage target for MIPS 
In-reply-to: Your message of "Thu, 13 Dec 2001 19:28:46 -0800."
             <20011213192846.A36207@idiom.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 14 Dec 2001 14:51:21 +1100
Message-ID: <1901.1008301881@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 13 Dec 2001 19:28:46 -0800, 
Geoffrey Espin <espin@idiom.com> wrote:
>=misc.c=========================================================================
>#include "../../../fs/jffs2/zlib.c" /**/
>#include "../../../lib/ctype.c"

I am phasing out the practice of ../ in kernel include paths.  It is
much better to do

#include "zlib.c"
#include "ctype.c"

and the Makefile adds -I$(TOPDIR)/fs/jffs2 -I$(TOPDIR)/lib.  Then when
sources are moved from one directory to another, the source does not
change, only the Makefile.  Relative paths are a pain in the neck in
Makefiles, they are even more of a pain in source code.

>TOPDIR          = ../../..

TOPDIR := $(shell cd ../../..; /bin/pwd)

is better, it returns an absolute path instead of a relative one.

Keith Owens, kernel build maintainer
