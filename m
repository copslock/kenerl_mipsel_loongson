Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2HApMA24769
	for linux-mips-outgoing; Sat, 17 Mar 2001 02:51:22 -0800
Received: from pandora.research.kpn.com (pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2HApLM24766
	for <linux-mips@oss.sgi.com>; Sat, 17 Mar 2001 02:51:21 -0800
Received: (from karel@localhost)
	by pandora.research.kpn.com (8.9.3/8.9.3) id LAA04852
	for linux-mips@oss.sgi.com; Sat, 17 Mar 2001 11:51:19 +0100
From: Karel van Houten <K.H.C.vanHouten@kpn.com>
Message-Id: <200103171051.LAA04852@pandora.research.kpn.com>
Subject: rpm crashing on RH 7.0 indy
To: linux-mips@oss.sgi.com
Date: Sat, 17 Mar 2001 11:51:19 +0100 (MET)
X-Url: http://www-lsdm.research.kpn.com/~karel
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all,

I hope someone can help me with this problem...

I've installed an Indy with Ralfs Redhat/test-7.0 packages.
Most things work OK, but rpm itself crashes when installing
a package. Here is a trace of what happens:

(gdb) run
Starting program: /usr/src/redhat/BUILD/rpm-4.0/rpm -ihv /cdrom/mips/XFree86-dev
el-4.0.1-1lm.mips.rpm 

Program received signal SIGSEGV, Segmentation fault.
_dl_lookup_versioned_symbol (undef_name=0x2affa6af "strcpy", 
    undef_map=0x10075330, ref=0x7fff9818, symbol_scope=0x1007554c, 
    version=0x100756b0, reloc_type=3, explicit=0) at do-lookup.h:52
52      do-lookup.h: No such file or directory.
(gdb) bt
#0  _dl_lookup_versioned_symbol (undef_name=0x2affa6af "strcpy", 
    undef_map=0x10075330, ref=0x7fff9818, symbol_scope=0x1007554c, 
    version=0x100756b0, reloc_type=3, explicit=0) at do-lookup.h:52
#1  0x5c30e4 in _dl_relocate_object () at ../sysdeps/mips/dl-machine.h:684
#2  0x5b6a40 in dl_open_worker (a=0x1007554c) at dl-open.c:316
#3  0x5b4a18 in _dl_catch_error (objname=0x7fff9a38, errstring=0x7fff9a3c, 
    operate=0x5b6470 <dl_open_worker>, args=0x7fff9a28) at dl-error.c:149
#4  0x5b6ca0 in _dl_open (file=0x7fff9c10 "libnss_nisplus.so.2", mode=1, 
    caller=0x0) at dl-open.c:380
#5  0x58882c in do_dlopen (ptr=0x7fff9bf0) at dl-libc.c:78
#6  0x5b4a18 in _dl_catch_error (objname=0x7fff9bc0, errstring=0x7fff9bc4, 
    operate=0x5887ec <do_dlopen>, args=0x7fff9bf0) at dl-error.c:149
#7  0x5887a4 in dlerror_run (operate=0x1007554c, args=0x0) at dl-libc.c:42
#8  0x58893c in __libc_dlopen (__name=0x1007554c "\020\b\023\230\020\b\031 ")
    at dl-libc.c:104
#9  0x57d1d0 in __nss_lookup_function (ni=0x10080b80, 
    fct_name=0x5e3be0 "getpwnam_r") at nsswitch.c:333
#10 0x57c560 in __nss_lookup (ni=0x7ffff2b0, fct_name=0x5e3be0 "getpwnam_r", 
    fctp=0x7ffff2b4) at nsswitch.c:148
#11 0x57e544 in __nss_passwd_lookup (ni=0x7ffff2b0, 
    fct_name=0x5e3be0 "getpwnam_r", fctp=0x7ffff2b4) at XXX-lookup.c:68
#12 0x56d7d0 in __getpwnam_r (name=0x5cc34c "root", resbuf=0x10018c08, 
    buffer=0x10080520 "\020", buflen=1024, result=0x7ffff308)
    at ../nss/getXXbyYY_r.c:159
#13 0x56c9bc in getpwnam (name=0x5cc34c "root") at ../nss/getXXbyYY.c:127
#14 0x42753c in installBinaryPackage (rootdir=0x1004de50 "/", db=0x1004a688, 
    fd=0x100a2bb8, h=0x10088890, flags=0, notify=0x438fa0 <showProgress>, 
    notifyData=0x12, pkgKey=0x7ffff9f6, actions=0x1006edb8, sharedList=0x0, 
    scriptFd=0x0) at install.c:941
#15 0x449c20 in rpmRunTransactions (ts=0x1004dde8, 
    notify=0x438fa0 <showProgress>, notifyData=0x12, okProbs=0x0, 
    newProbs=0x7ffff6c4, transFlags=0, ignoreSet=0) at transaction.c:1701
#16 0x439c4c in rpmInstall (rootdir=0x5c917c "/", fileArgv=0x1001faf8, 
    transFlags=0, interfaceFlags=2, probFilter=0, relocations=0x0)
    at rpminstall.c:370
#17 0x406a2c in main (argc=3, argv=0xffffffff) at rpm.c:1133
#18 0x53599c in __libc_start_main (main=0x404090 <main>, argc=3, 
    ubp_av=0x7ffff8d4, init=0x4000f8 <_init>, fini=0x5c6880 <_fini>, 
    rtld_fini=0, stack_end=0x7ffff8b0) at ../sysdeps/generic/libc-start.c:111

This is a static rpm binary, so I don't understand why it tries
do dynaload anything at all...

Thanks in advance,
-- 
Karel van Houten
