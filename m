Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1IACiJ15133
	for linux-mips-outgoing; Mon, 18 Feb 2002 02:12:44 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1IACb915128
	for <linux-mips@oss.sgi.com>; Mon, 18 Feb 2002 02:12:37 -0800
Message-Id: <200202181012.g1IACb915128@oss.sgi.com>
Received: (qmail 6526 invoked from network); 18 Feb 2002 09:15:18 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 18 Feb 2002 09:15:18 -0000
Date: Mon, 18 Feb 2002 17:9:32 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "H . J . Lu" <hjl@lucon.org>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: math broken on mips
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g1IACc915129
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

 will try later,thank you.

ÔÚ 2002-02-18 00:18:00 you wrote£º
>On Mon, Feb 18, 2002 at 03:57:04PM +0800, Zhang Fuxin wrote:
>> 
>>    (gcc3.1 seems a lot better,but it has problem to compile glibc.I can't even compile
>>  current glibc cvs code(with dl-conflict.c etc patched) with it. The best result is
>>  a segment fault when using ld.so.1:
>>       ../elf/ld.so.1 --library-path ..:../math:../elf:../dlfcn:../nss:../nis:../rt:../resolv:
>>   ../crypt:../linuxthreads ./rpcgen -Y ../scripts -c rpcsvc/bootparam_prot.x -o 
>>   xbootparam_prot.T
>
>You need to get the current glibc/gcc from CVS. You also need to apply
>my glibc patches for mips if they are not in CVS yet. They are:
>
>2002-01-20  H.J. Lu  <hjl@gnu.org>
>
>        * config.make.in (inline-limit): New.
>
>        * configure.in: Check if gcc supports -finline-limit=xxx.
>        * configure: Rebuild.
>
>        * elf/Makefile (CFLAGS-rtld.c): Set to -finline-limit=2000 if
>        needed.
>
>2002-02-04  H.J. Lu  <hjl@gnu.org>
>
>        * elf/dl-conflict.c (_dl_resolve_conflicts): Dummy if
>        _DL_HAVE_NO_ELF_MACHINE_RELA is defined.
>
>2001-07-10  H.J. Lu  <hjl@gnu.org>
>
>        * sysdeps/unix/sysv/linux/powerpc/mmap64.c: Moved to ...
>        * sysdeps/unix/sysv/linux/mmap64.c: Here.
>
>        * sysdeps/unix/sysv/linux/mmap64.c (MMAP2_PAGE_SHIFT): Renamed
>        from PAGE_SHIFT. Define if not defined. Check MMAP2_PAGE_SHIFT
>        only if __NR_mmap2 is defined.
>
>        * sysdeps/unix/sysv/linux/hppa/mmap64.c : Removed.
>        * sysdeps/unix/sysv/linux/sparc/sparc32/mmap64.c: Likewise.
>
>Please check the glibc mailing list archive for those patches.
>
>
>H.J.

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
