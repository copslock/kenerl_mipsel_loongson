Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAS16bm04741
	for linux-mips-outgoing; Tue, 27 Nov 2001 17:06:37 -0800
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAS16Vo04738
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 17:06:32 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id A34A8125C8; Tue, 27 Nov 2001 16:06:30 -0800 (PST)
Date: Tue, 27 Nov 2001 16:06:30 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: linux-mips@oss.sgi.com
Subject: Does the MIPS 2.4.14 kernel work with RedHat 7.1?
Message-ID: <20011127160630.A4448@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Does the MIPS 2.4.14 kernel work with RedHat 7.1? I couldn't get RedHat
7.1 to work with today's 2.4.14 kernel from oss.sgi.com. All dynamic
binaries die inside of dynamic linker:

#0  0x2aab1ed8 in _dl_lookup_versioned_symbol (
    undef_name=0x2adc05cb "nis_local_directory", undef_map=0x10012410, 
    ref=0x7fff2050, symbol_scope=0x10012674, version=0x1000f440, type_class=1, 
    explicit=0) at do-lookup.h:80
#1  0x2aab4130 in _dl_relocate_object () at ../sysdeps/mips/dl-machine.h:626
#2  0x2acb9694 in dl_open_worker (a=0x10012410) at dl-open.c:289
#3  0x2aab62c0 in _dl_catch_error (objname=0x7fff2230, errstring=0x7fff2234, 
    operate=0x2acb9220 <dl_open_worker>, args=0x7fff2220) at dl-error.c:152
#4  0x2acb9a00 in _dl_open (file=0x7fff23f0 "libnss_nis.so.2", mode=1, 
    caller=0x0) at dl-open.c:402
#5  0x2acbac50 in do_dlopen (ptr=0x7fff23c0) at dl-libc.c:78
#6  0x2aab62c0 in _dl_catch_error (objname=0x7fff23c8, errstring=0x7fff23cc, 
    operate=0x2acbac14 <do_dlopen>, args=0x7fff23c0) at dl-error.c:152
#7  0x2acbaa84 in __libc_dlopen (
    __name=0x433acb9 <Address 0x433acb9 out of bounds>) at dl-libc.c:42
#8  0x2ac8d114 in __nss_lookup_function (ni=0x10010110, 
    fct_name=0x2acd068c "endpwent") at nsswitch.c:340
#9  0x2ac8e08c in __nss_next (ni=0x2ad1ea70, fct_name=0x2acd068c "endpwent", 
    fctp=0x7fff7a68, status=2147427264, all_values=1) at nsswitch.c:194
#10 0x2ac8e6f4 in __nss_endent (func_name=0x2acd068c "endpwent", 
    lookup_fct=0x2ac8f650 <__nss_passwd_lookup>, nip=0x2ad1ea70, startp=0x1, 
    last_nip=0x2ad1ea74, res=0) at getnssent_r.c:117
#11 0x2ac406e0 in endpwent () at ../nss/getXXent_r.c:135
#12 0x00413cc4 in get_current_user_info () at shell.c:1455
#13 0x00413e8c in shell_initialize () at shell.c:1498
#14 0x00410880 in main (argc=1, argv=0x7fff7f24, env=0x7fff7f2c) at shell.c:474
(gdb) p sym
$34 = (Elf32_Sym *) 0xd8554764
(gdb) p symidx
$35 = 718791408
(gdb) p map->l_buckets[hash % map->l_nbuckets]
$36 = 718791408
(gdb) p hash % map->l_nbuckets
$37 = 113
(gdb) p/x hash
$38 = 0x433acb9
(gdb) p  map->l_nbuckets
$39 = 227

It looks like the memory is corrupted.


H.J.
