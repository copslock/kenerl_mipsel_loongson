Received:  by oss.sgi.com id <S553667AbRAMTkH>;
	Sat, 13 Jan 2001 11:40:07 -0800
Received: from router.isratech.ro ([193.226.114.69]:49924 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553659AbRAMTjx>;
	Sat, 13 Jan 2001 11:39:53 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id f0DJdCQ02821
	for <linux-mips@oss.sgi.com>; Sat, 13 Jan 2001 21:39:13 +0200
Message-ID: <3A611CFF.FD28766@isratech.ro>
Date:   Sat, 13 Jan 2001 22:29:03 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Glibc-error.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello ,

I am struggling to get glibc 2.1.3 working for mips. I have to do this
so please not redirect me to another glibc. I did a diff between glibc
2.0.6 for mips and glibc 2.1.3 and now I applied the patch obtained on
glibc 2.1.3 . At make I get the following error and I don't know what to
do. Maybe someone will help me.

Here is the error

=====================================================================
 (libs='libpthread.so.0 libpthread.so.0 libm.so.6 libc.so.6 ld.so.1
libdl.so.2 libutil.so.1 libresolv.so.2 libnss_files.so.2 libnss
_dns.so.2 libnss_db.so.2 libnss_compat.so.2 libnss_nis.so.2
libnss_nisplus.so.2 libnss_ldap.so.2 libnss_hesiod.so.2 libnsl.so.1 lib
db.so.3 libdb1.so.2 libcrypt.so.1 libBrokenLocale.so.1 librt.so.1';\
  for l in $libs; do \
               'ABCDEFGHIJKLMNOPQRSTUVWXYZ_'`; \
    echo "#define       ${upname}_SO    \"$l\""; \
  done;) | sort; \
 echo; \
 echo '#endif   /* gnu/lib-names.h */';) >
/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/gnu/lib-names.T
/bin/sh ../scripts/move-if-change
/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/gnu/lib-names.T
/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/gnu/lib-names.h
touch
/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/gnu/lib-names.stmp

.././scripts/mkinstalldirs
/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/csu
rm -f
/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/csu/abi-tag.h.new
sed -e 's/#.*$//' -e '/^[       ]*$/d' ../abi-tags | \
while read conf tag; do \
  test `expr 'mips-mips-linux-gnu' \
             : "$conf"` != 0 || continue; \
  echo "$tag" | \
  sed -e 's/[^0-9xXa-fA-F]/ /g' -e 's/ *$//' \
      -e 's/ /,/g' -e 's/^ */#define ABI_TAG /' >
/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/csu/abi-tag.h.new;
\
done
if test -r
/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/csu/abi-tag.h.new;
then mv -f
/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/csu/abi-tag.h.new
/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/csu/abi-tag.h; \
else echo >&2 'This configuration not matched in ../abi-tags'; exit 1;
fi
make[2]: *** No rule to make target `../posix/posix1_lim.h', needed by
`/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/mk-stdiolim'.
Stop.
make[2]: Leaving directory
`/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc-2.1.3/csu'
make[1]: *** [csu/subdir_lib] Error 2
make[1]: Leaving directory
`/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc-2.1.3'
make: *** [all] Error 2

=======================================================================

Nicu
