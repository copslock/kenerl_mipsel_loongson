Received:  by oss.sgi.com id <S42325AbQIYJbE>;
	Mon, 25 Sep 2000 02:31:04 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:38148 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42229AbQIYJa7>;
	Mon, 25 Sep 2000 02:30:59 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D3B457FD; Mon, 25 Sep 2000 11:37:09 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3023A9014; Mon, 25 Sep 2000 11:24:13 +0200 (CEST)
Date:   Mon, 25 Sep 2000 11:24:13 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-origin@oss.sgi.com
Subject: Re: libc upgrade
Message-ID: <20000925112413.B3247@paradigm.rfc822.org>
References: <20000922152604.A2627@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20000922152604.A2627@bacchus.dhis.org>; from ralf@oss.sgi.com on Fri, Sep 22, 2000 at 03:26:04PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Sep 22, 2000 at 03:26:04PM +0200, Ralf Baechle wrote:
> I've uploaded the hopefully last glibc 2.0.6 release to oss.sgi.com.  The
> rpm package filenames are:
> 
>   glibc-2.0.6-6lm.src.rpm,

Build fails on mipsel ...

gcc rpcinfo.c -c -O2 -g -w     -I. -I.. -I../libio  -I../sysdeps/mips/elf -I../crypt/sysdeps/unix -I../linuxthreads/sysdeps/unix/sysv/linux -I../linuxthreads/sysdeps/pthread -I../linuxthreads/sysdeps/unix/sysv -I../linuxthreads/sysdeps/unix -I../linuxthreads/sysdeps/mips -I../linuxthreads/sysdeps/pthread/cmpxchg -I../sysdeps/unix/sysv/linux/mips -I../sysdeps/unix/sysv/linux -I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman -I../sysdeps/unix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix/mips -I../sysdeps/unix -I../sysdeps/posix -I../sysdeps/mips/mipsel -I../sysdeps/mips -I../sysdeps/wordsize-32 -I../sysdeps/ieee754 -I../sysdeps/libm-ieee754 -I../sysdeps/generic -I../sysdeps/stub  -D_LIBC_REENTRANT -D_PATH_RPC='"/etc/rpc"' -include ../libc-symbols.h     -o rpcinfo.o
gcc -nostdlib -nostartfiles -o rpcinfo  -Wl,-dynamic-linker=/lib/ld.so.1 -g ../csu/start.o ../csu/crti.o `gcc --print-file-name=crtbegin.o` rpcinfo.o  -Wl,-rpath-link=..:../elf:../nss ../libc.so.6 ../elf/ld.so.1 ../libc.a -lgcc `gcc --print-file-name=crtend.o` ../csu/crtn.o
/bin/sh: invalid character 45 in exportstr for full-config-sysdirs
LD_LIBRARY_PATH=..:../elf:../nss ../elf/ld.so.1 ./rpcgen -c rpcsvc/bootparam.x -o xbootparam.T
/bin/sh: invalid character 45 in exportstr for full-config-sysdirs
make[1]: *** [xbootparam.stmp] Segmentation fault
make[1]: Leaving directory `/usr/src/redhat/BUILD/glibc-2.0.6/sunrpc'
make: *** [sunrpc/others] Error 2
Bad exit status from /var/tmp/rpm-tmp.29023 (%build)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
