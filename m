Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Apr 2004 10:11:21 +0100 (BST)
Received: from web17015.mail.tpe.yahoo.com ([IPv6:::ffff:202.1.236.166]:58788
	"HELO web17015.mail.tpe.yahoo.com") by linux-mips.org with SMTP
	id <S8226025AbUD0JLT>; Tue, 27 Apr 2004 10:11:19 +0100
Message-ID: <20040427091110.53701.qmail@web17015.mail.tpe.yahoo.com>
Received: from [210.243.228.66] by web17015.mail.tpe.yahoo.com via HTTP; Tue, 27 Apr 2004 17:11:10 CST
Date: Tue, 27 Apr 2004 17:11:10 +0800 (CST)
From: "=?big5?q?aluba1231.tw?=" <aluba1231.tw@yahoo.com.tw>
Subject: nfs server on mips platform?
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit
Return-Path: <aluba1231.tw@yahoo.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aluba1231.tw@yahoo.com.tw
Precedence: bulk
X-list: linux-mips


ading cache ./config.cache
checking for gcc... (cached) mipsel-uclibc-gcc
checking whether the C compiler (mipsel-uclibc-gcc  )
works... yes
checking whether the C compiler (mipsel-uclibc-gcc  )
is a cross-compiler... yes
checking whether we are using GNU C... (cached) yes
checking whether mipsel-uclibc-gcc accepts -g...
(cached) yes
checking how to run the C preprocessor... (cached)
mipsel-uclibc-gcc -E
checking for a BSD compatible install... (cached)
/usr/bin/install -c
checking host system type... ./config.guess: line 941:
./dummy-4248: cannot execute binary file
i686-pc-linux-gnu
checking build system type... i686-pc-linux-gnu
checking for ranlib... (cached) mipsel-uclibc-ranlib
checking for ar... (cached) mipsel-uclibc-ar
checking for ld... (cached) mipsel-uclibc-ld
checking for ANSI C header files... (cached) yes
checking for GNU libc2... (cached) yes
checking for main in -lsocket... (cached) no
checking for main in -lnsl... (cached) yes
checking for crypt in -lcrypt... (cached) yes
checking for the tcp wrapper library... (cached) no
checking for innetgr... (cached) no
creating ./config.status
creating config.mk
creating nfs-utils.spec
creating utils/Makefile
creating support/include/config.h
support/include/config.h is unchanged
Making all in tools
Making all in rpcgen
Building rpcgen done.
Making all in getiversion
Building getiversion done.
Making all in getkversion
Building getkversion done.
Making all in rpcdebug
Building rpcdebug done.
Making all in locktest
Building testlk done.
Making all in support
Making all in include
Making all in nfs
Building libnfs.a done.
Making all in export
Building libexport.a done.
Making all in lib
Making all in misc
Building libmisc.a done.
Making all in utils
Making all in exportfs
Building exportfs done.
Making all in mountd
mipsel-uclibc-gcc  -L../../support/lib -o mountd
mountd.o mount_dispatch.o auth.o rmtab.o cache.o
svc_run.o -lexport -lnfs -lmisc   -lnsl
mountd.o: In function `killer':
mountd.o(.text+0xcc): undefined reference to
`pmap_unset'
mountd.o(.text+0xf0): undefined reference to
`pmap_unset'
mountd.o(.text+0x12c): undefined reference to
`pmap_unset'
mount_dispatch.o(.data+0x8): undefined reference to
`xdr_void'
mount_dispatch.o(.data+0x10): undefined reference to
`xdr_void'
mount_dispatch.o(.data+0x38): undefined reference to
`xdr_void'
mount_dispatch.o(.data+0x58): undefined reference to
`xdr_void'
mount_dispatch.o(.data+0x68): undefined reference to
`xdr_void'
mount_dispatch.o(.data+0x70): more undefined
references to `xdr_void' follow
svc_run.o: In function `my_svc_run':
svc_run.o(.text+0x3c): undefined reference to
`__rpc_thread_svc_fdset'
svc_run.o(.text+0x130): undefined reference to
`svc_getreqset'
../../support/lib/libexport.a(mount_xdr.o): In
function `xdr_fhandle':
mount_xdr.o(.text+0x20): undefined reference to
`xdr_opaque'
../../support/lib/libexport.a(mount_xdr.o): In
function `xdr_fhstatus':
mount_xdr.o(.text+0x7c): undefined reference to
`xdr_u_int'
../../support/lib/libexport.a(mount_xdr.o): In
function `xdr_dirpath':
mount_xdr.o(.text+0x12c): undefined reference to
`xdr_string'
../../support/lib/libexport.a(mount_xdr.o): In
function `xdr_name':
mount_xdr.o(.text+0x17c): undefined reference to
`xdr_string'
../../support/lib/libexport.a(mount_xdr.o): In
function `xdr_mountlist':
mount_xdr.o(.text+0x1d0): undefined reference to
`xdr_pointer'
../../support/lib/libexport.a(mount_xdr.o): In
function `xdr_groups':
mount_xdr.o(.text+0x2f0): undefined reference to
`xdr_pointer'
../../support/lib/libexport.a(mount_xdr.o): In
function `xdr_exports':
mount_xdr.o(.text+0x3e4): undefined reference to
`xdr_pointer'
../../support/lib/libexport.a(mount_xdr.o): In
function `xdr_ppathcnf':
mount_xdr.o(.text+0x548): undefined reference to
`xdr_int'
mount_xdr.o(.text+0x5b4): undefined reference to
`xdr_short'
mount_xdr.o(.text+0x5e4): undefined reference to
`xdr_short'
mount_xdr.o(.text+0x614): undefined reference to
`xdr_short'
mount_xdr.o(.text+0x644): undefined reference to
`xdr_short'
mount_xdr.o(.text+0x674): undefined reference to
`xdr_short'
mount_xdr.o(.text+0x6a4): undefined reference to
`xdr_u_char'
mount_xdr.o(.text+0x6d4): undefined reference to
`xdr_char'
mount_xdr.o(.text+0x708): undefined reference to
`xdr_short'
mount_xdr.o(.text+0x714): undefined reference to
`xdr_vector'
mount_xdr.o(.text+0x840): undefined reference to
`xdr_u_char'
mount_xdr.o(.text+0x870): undefined reference to
`xdr_char'
mount_xdr.o(.text+0x934): undefined reference to
`xdr_short'
mount_xdr.o(.text+0x944): undefined reference to
`xdr_vector'
mount_xdr.o(.text+0x980): undefined reference to
`xdr_int'
mount_xdr.o(.text+0x9b0): undefined reference to
`xdr_short'
mount_xdr.o(.text+0x9e0): undefined reference to
`xdr_short'
mount_xdr.o(.text+0xa10): undefined reference to
`xdr_short'
mount_xdr.o(.text+0xa40): undefined reference to
`xdr_short'
mount_xdr.o(.text+0xa70): undefined reference to
`xdr_short'
mount_xdr.o(.text+0xc14): undefined reference to
`xdr_u_char'
mount_xdr.o(.text+0xc44): undefined reference to
`xdr_char'
mount_xdr.o(.text+0xd28): undefined reference to
`xdr_int'
mount_xdr.o(.text+0xd58): undefined reference to
`xdr_short'
mount_xdr.o(.text+0xd88): undefined reference to
`xdr_short'
mount_xdr.o(.text+0xdb8): undefined reference to
`xdr_short'
mount_xdr.o(.text+0xde8): undefined reference to
`xdr_short'
mount_xdr.o(.text+0xe18): undefined reference to
`xdr_short'
../../support/lib/libexport.a(mount_xdr.o): In
function `xdr_fhandle3':
mount_xdr.o(.text+0xe70): undefined reference to
`xdr_bytes'
../../support/lib/libexport.a(mount_xdr.o): In
function `xdr_mountstat3':
mount_xdr.o(.text+0xebc): undefined reference to
`xdr_enum'
../../support/lib/libexport.a(mount_xdr.o): In
function `xdr_mountres3_ok':
mount_xdr.o(.text+0xf5c): undefined reference to
`xdr_int'
mount_xdr.o(.text+0xf7c): undefined reference to
`xdr_array'
../../support/lib/libnfs.a(rpcmisc.o): In function
`rpc_init':
rpcmisc.o(.text+0xa4): undefined reference to
`pmap_unset'
rpcmisc.o(.text+0x164): undefined reference to
`svcudp_create'
rpcmisc.o(.text+0x1a0): undefined reference to
`svc_register'
rpcmisc.o(.text+0x328): undefined reference to
`svctcp_create'
rpcmisc.o(.text+0x364): undefined reference to
`svc_register'
../../support/lib/libnfs.a(rpcmisc.o): In function
`closedown':
rpcmisc.o(.text+0x788): undefined reference to
`__rpc_thread_svc_fdset'
../../support/lib/libnfs.a(rpcdispatch.o): In function
`rpc_dispatch':
rpcdispatch.o(.text+0xa0): undefined reference to
`svcerr_noproc'
rpcdispatch.o(.text+0x15c): undefined reference to
`svcerr_decode'
rpcdispatch.o(.text+0x1c0): undefined reference to
`svc_sendreply'
rpcdispatch.o(.text+0x228): undefined reference to
`svcerr_systemerr'
rpcdispatch.o(.text+0x258): undefined reference to
`svcerr_progvers'
../../support/lib/libnfs.a(svc_socket.o): In function
`svc_socket':
svc_socket.o(.text+0xec): undefined reference to
`__bzero'
svc_socket.o(.text+0x124): undefined reference to
`getrpcbynumber_r'
svc_socket.o(.text+0x194): undefined reference to
`bindresvport'
collect2: ld returned 1 exit status
make[3]: *** [mountd] Error 1
make[2]: *** [all] Error 2
make[1]: *** [all] Error 2



-----------------------------------------------------------------
�۪���I�IEmail�B�B���I
�K�O�U��Yahoo!�_�����|�C
http://tw.companion.yahoo.com/
