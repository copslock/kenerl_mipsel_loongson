Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3IIKKj10812
	for linux-mips-outgoing; Wed, 18 Apr 2001 11:20:20 -0700
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.225])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3IIK3M10790
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 11:20:19 -0700
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 14pwYZ-0006QW-00; Wed, 18 Apr 2001 14:19:59 -0400
Date: Wed, 18 Apr 2001 14:19:59 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Steven J. Hill" <sjhill@cotw.com>, linux-mips@oss.sgi.com
Subject: Question on the binutils tradlittlemips patch
Message-ID: <20010418141959.A24473@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I've been trying to make this patch work as part of a complete
toolchain, based on glibc.  In addition to a little snag (when building
glibc for big-endian mips you need an equivalent change in the target
format), I hit a serious shared library error - nothing linked
dynamically worked.  This is the cause:

--- elf32lsmip.sh       Thu Jun  3 14:02:10 1999
+++ elf32ltsmip.sh      Wed Apr 11 00:14:08 2001

...

-SHLIB_TEXT_START_ADDR=0x5ffe0000
+SHLIB_TEXT_START_ADDR=0x0


Is this necessary for the ABI?  If so, glibc needs to be updated to
reflect that:

/*
 * MIPS libraries are usually linked to a non-zero base address.  We
 * subtract the base address from the address where we map the object
 * to.  This results in more efficient address space usage.
 *
 * FIXME: By the time when MAP_BASE_ADDR is called we don't have the
 * DYNAMIC section read.  Until this is fixed make the assumption that
 * libraries have their base address at 0x5ffe0000.  This needs to be
 * fixed before we can safely get rid of this MIPSism.
 */
#if 0
#define MAP_BASE_ADDR(l) ((l)->l_info[DT_MIPS(BASE_ADDRESS)] ? \
			  (l)->l_info[DT_MIPS(BASE_ADDRESS)]->d_un.d_ptr : 0)
#else
#define MAP_BASE_ADDR(l) 0x5ffe0000
#endif


Of course, now that is completely wrong.

One of the two definitely needs to give.  From the evilness of the hack
in glibc, I'm assuming that glibc needs to give.


Am I on the right track here?

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
