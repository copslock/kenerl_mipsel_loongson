Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3UCYGZ08086
	for linux-mips-outgoing; Mon, 30 Apr 2001 05:34:16 -0700
Received: from wiproecmx2.wipro.com (wiproecmx2.wipro.com [164.164.31.6])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3UCY1M08078
	for <linux-mips@oss.sgi.com>; Mon, 30 Apr 2001 05:34:02 -0700
Received: from ecvwall1.wipro.com (ecvwall1.wipro.com [192.168.181.23])
	by wiproecmx2.wipro.com (8.9.3/8.9.3) with SMTP id SAA16661
	for <linux-mips@oss.sgi.com>; Mon, 30 Apr 2001 18:13:49 GMT
Received: from ecvwall1.wipro.com ([192.168.181.23]) by
          ecmail.mail.wipro.com (Netscape Messaging Server 4.15) with SMTP
          id GCLUUP00.SMY for <linux-mips@oss.sgi.com>; Mon, 30 Apr 2001
          18:02:49 +0530 
Received: from wipro.com ([192.168.225.13]) by
          helium.mail.wipro.com (Netscape Messaging Server 4.15) with
          ESMTP id GCLUS500.Q49 for <linux-mips@oss.sgi.com>; Mon, 30 Apr
          2001 18:01:17 +0530 
Message-ID: <3AED5D0D.B8E1B504@wipro.com>
Date: Mon, 30 Apr 2001 18:09:41 +0530
From: Surendranath Reddy G B <surendranath.reddy@wipro.com>
Reply-To: brains@netkracker.com
Organization: Wipro
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Problem in compilation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

HI,


    I am facing problems in compiling test programs using cross
compiler.

The cross compiler is - egcs-objc-mips-linux-1.1.2-3.i386.rpm
glibc is - glibc-2.1.95-1.mips.rpm
binutils is - binutils-mips-linux-2.9.5-3.i386.rpm

My test program is very simple...
test.c

#include <stdio.h>

main()
{
                printf("It is working\n");
}

If I do compilation and linking together I was facing same problems. So
I tried to do them
separate.  Following are the steps I fllowed to compile test.c


# mips-linux-gcc -I /mips-usr/usr/include -c test.c

this created test.o file.

# mips-linux-ld -L/mips-usr/usr/lib -L /mips-usr/lib test.o -o test
mips-linux-ld: warning: cannot find entry symbol __start; defaulting to
00000000004000b0
test.o: In function `main':
test.c(.text+0x30): undefined reference to `printf'

So it was unable to find the symbol from libc.. so I explicitly included
libc in the command line as below.
That gave new problems which are below.


# mips-linux-ld -L/mips-usr/usr/lib -L /mips-usr/lib -lc test.o -o test
mips-linux-ld: warning: ld.so.1, needed by /mips-usr/lib/libc.so.6, not
found (try using --rpath)
mips-linux-ld: warning: cannot find entry symbol __start; defaulting to
0000000000400340
/mips-usr/lib/libc.so.6: undefined reference to `_r_debug@@GLIBC_2.0'
/mips-usr/lib/libc.so.6: undefined reference to `_dl_lazy@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`__libc_stack_end@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_signal_error@@GLIBC_2.0'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_relocate_object@@GLIBC_2.0'
/mips-usr/lib/libc.so.6: undefined reference to `_dl_loaded@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_debug_files@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_initial_searchlist@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_fpu_control@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_check_map_versions@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to `_dl_nloaded@@GLIBC_2.2'

/mips-usr/lib/libc.so.6: undefined reference to
`_dl_main_searchlist@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to `_dl_mcount@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_debug_message@@GLIBC_2.0'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_all_dirs@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined/mips-usr/lib/libc.so.6: undefined
reference to `_dl_mcount@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_debug_message@@GLIBC_2.0'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_all_dirs@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to `_dl_init@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_load_lock@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_platformlen@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to `_dl_argv@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_out_of_memory@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_profile_output@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_catch_error@@GLIBC_2.0'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_profile_map@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_map_object@@GLIBC_2.0'
/mips-usr/lib/libc.so.6: undefined reference to `_dl_profile@@GLIBC_2.2'

/mips-usr/lib/libc.so.6: undefined reference to
`_dl_start_profile@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_lookup_versioned_symbol@@GLIBC_2.0'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_init_all_dirs@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_lookup_symbol_skip@@GLIBC_2.0'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_map_object_deps@@GLIBC_2.0'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_debug_impcalls@@GLIBC_2.0'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_unload_cache@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_lookup_versioned_symbol_skip@@GLIBC_2.0'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_dst_substitute@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_global_scope_alloc@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_debug_state@@GLIBC_2.0'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_lookup_symbol@@GLIBC_2.0'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_origin_path@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`_dl_dst_count@@GLIBC_2.2'
/mips-usr/lib/libc.so.6: undefined reference to
`__libc_enable_secure@@GLIBC_2.0'

So I included --rpath to my compilation command. So the above problem
disappeared but a new
problem appeared.

# mips-linux-ld -L/mips-usr/usr/lib -L /mips-usr/lib
--rpath=/mips-usr/lib -lc test.o -o test
mips-linux-ld: warning: cannot find entry symbol __start; defaulting to
0000000000400350

Now I did include  crti.o and crt1.o to my complation command and I got
the executeble.

# mips-linux-ld -L/mips-usr/usr/lib -L /mips-usr/lib
--rpath=/mips-usr/lib -lc
/usr/lib/gcc-lib/mips-linux/egcs-2.91.66/crti.o
/usr/lib/gcc-lib/mips-linux/egcs-2.91.66/crt1.o test.o -o test
#

Then I tried to execute the xecutable on MIPS system.. But it gave the
error saying no such file even though ls -l was showing that
file.. After that I did strace on and it said exec not found...

I am unable to resolve this problem.. Will you help me to overcome this
problem?


bash-2.04# ./test
bash: ./test: No such file or directory
bash-2.04# ls -l test
-rwxrwxr-x    1 sujata   sujata     131639 Mar  2 03:06 test
bash-2.04#


bash-2.04# strace ./test
strace: exec: No such file or directory
execve("./test", ["./test"], [/* 21 vars */]) = 0
bash-2.04#



Thanks
Regards
Suj
