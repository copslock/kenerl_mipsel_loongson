Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1I9ID413310
	for linux-mips-outgoing; Mon, 18 Feb 2002 01:18:13 -0800
Received: from rwcrmhc54.attbi.com (rwcrmhc54.attbi.com [216.148.227.87])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1I9I8913300
	for <linux-mips@oss.sgi.com>; Mon, 18 Feb 2002 01:18:08 -0800
Received: from ocean.lucon.org ([12.234.16.87]) by rwcrmhc54.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020218081802.UYLG1214.rwcrmhc54.attbi.com@ocean.lucon.org>;
          Mon, 18 Feb 2002 08:18:02 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id A0024125C1; Mon, 18 Feb 2002 00:18:01 -0800 (PST)
Date: Mon, 18 Feb 2002 00:18:01 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Zhang Fuxin <fxzhang@ict.ac.cn>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>,
   "libc-alpha@sources.redhat.com" <libc-alpha@sources.redhat.com>,
   "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
Subject: Re: math broken on mips
Message-ID: <20020218001801.A21719@lucon.org>
References: <200202180859.g1I8xr912786@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202180859.g1I8xr912786@oss.sgi.com>; from fxzhang@ict.ac.cn on Mon, Feb 18, 2002 at 03:57:04PM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 18, 2002 at 03:57:04PM +0800, Zhang Fuxin wrote:
> 
>    (gcc3.1 seems a lot better,but it has problem to compile glibc.I can't even compile
>  current glibc cvs code(with dl-conflict.c etc patched) with it. The best result is
>  a segment fault when using ld.so.1:
>       ../elf/ld.so.1 --library-path ..:../math:../elf:../dlfcn:../nss:../nis:../rt:../resolv:
>   ../crypt:../linuxthreads ./rpcgen -Y ../scripts -c rpcsvc/bootparam_prot.x -o 
>   xbootparam_prot.T

You need to get the current glibc/gcc from CVS. You also need to apply
my glibc patches for mips if they are not in CVS yet. They are:

2002-01-20  H.J. Lu  <hjl@gnu.org>

        * config.make.in (inline-limit): New.

        * configure.in: Check if gcc supports -finline-limit=xxx.
        * configure: Rebuild.

        * elf/Makefile (CFLAGS-rtld.c): Set to -finline-limit=2000 if
        needed.

2002-02-04  H.J. Lu  <hjl@gnu.org>

        * elf/dl-conflict.c (_dl_resolve_conflicts): Dummy if
        _DL_HAVE_NO_ELF_MACHINE_RELA is defined.

2001-07-10  H.J. Lu  <hjl@gnu.org>

        * sysdeps/unix/sysv/linux/powerpc/mmap64.c: Moved to ...
        * sysdeps/unix/sysv/linux/mmap64.c: Here.

        * sysdeps/unix/sysv/linux/mmap64.c (MMAP2_PAGE_SHIFT): Renamed
        from PAGE_SHIFT. Define if not defined. Check MMAP2_PAGE_SHIFT
        only if __NR_mmap2 is defined.

        * sysdeps/unix/sysv/linux/hppa/mmap64.c : Removed.
        * sysdeps/unix/sysv/linux/sparc/sparc32/mmap64.c: Likewise.

Please check the glibc mailing list archive for those patches.


H.J.
