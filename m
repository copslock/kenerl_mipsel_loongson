Received:  by oss.sgi.com id <S553698AbRANRaS>;
	Sun, 14 Jan 2001 09:30:18 -0800
Received: from blackdog.wirespeed.com ([208.170.106.25]:37638 "EHLO
        blackdog.wirespeed.com") by oss.sgi.com with ESMTP
	id <S553690AbRANR3v>; Sun, 14 Jan 2001 09:29:51 -0800
Received: from redhat.com (IDENT:joe@dhcp-250.wirespeed.com [172.16.17.250] (may be forged))
	by blackdog.wirespeed.com (8.9.3/8.9.3) with ESMTP id LAA22728;
	Sun, 14 Jan 2001 11:25:37 -0600
Message-ID: <3A61E2A3.3040600@redhat.com>
Date:   Sun, 14 Jan 2001 11:32:19 -0600
From:   Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     Nicu Popovici <octavp@isratech.ro>
CC:     linux-mips@oss.sgi.com
Subject: Re: Glibc-error.
References: <3A611CFF.FD28766@isratech.ro>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I would think the 2.1.95 version of glibc from sgi would be much closer 
to 2.1.3 than the 2.0.6/7 versions are.

Nicu Popovici wrote:

> Hello ,
> 
> I am struggling to get glibc 2.1.3 working for mips. I have to do this
> so please not redirect me to another glibc. I did a diff between glibc
> 2.0.6 for mips and glibc 2.1.3 and now I applied the patch obtained on
> glibc 2.1.3 . At make I get the following error and I don't know what to
> do. Maybe someone will help me.
> 
> Here is the error
> 
> =====================================================================
>  (libs='libpthread.so.0 libpthread.so.0 libm.so.6 libc.so.6 ld.so.1
> libdl.so.2 libutil.so.1 libresolv.so.2 libnss_files.so.2 libnss
> _dns.so.2 libnss_db.so.2 libnss_compat.so.2 libnss_nis.so.2
> libnss_nisplus.so.2 libnss_ldap.so.2 libnss_hesiod.so.2 libnsl.so.1 lib
> db.so.3 libdb1.so.2 libcrypt.so.1 libBrokenLocale.so.1 librt.so.1';\
>   for l in $libs; do \
>                'ABCDEFGHIJKLMNOPQRSTUVWXYZ_'`; \
>     echo "#define       ${upname}_SO    \"$l\""; \
>   done;) | sort; \
>  echo; \
>  echo '#endif   /* gnu/lib-names.h */';) >
> /home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/gnu/lib-names.T
> /bin/sh ../scripts/move-if-change
> /home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/gnu/lib-names.T
> /home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/gnu/lib-names.h
> touch
> /home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/gnu/lib-names.stmp
> 
> ..././scripts/mkinstalldirs
> /home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/csu
> rm -f
> /home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/csu/abi-tag.h.new
> sed -e 's/#.*$//' -e '/^[       ]*$/d' ../abi-tags | \
> while read conf tag; do \
>   test `expr 'mips-mips-linux-gnu' \
>              : "$conf"` != 0 || continue; \
>   echo "$tag" | \
>   sed -e 's/[^0-9xXa-fA-F]/ /g' -e 's/ *$//' \
>       -e 's/ /,/g' -e 's/^ */#define ABI_TAG /' >
> /home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/csu/abi-tag.h.new;
> \
> done
> if test -r
> /home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/csu/abi-tag.h.new;
> then mv -f
> /home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/csu/abi-tag.h.new
> /home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/csu/abi-tag.h; \
> else echo >&2 'This configuration not matched in ../abi-tags'; exit 1;
> fi
> make[2]: *** No rule to make target `../posix/posix1_lim.h', needed by
> `/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc_build/mk-stdiolim'.
> Stop.
> make[2]: Leaving directory
> `/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc-2.1.3/csu'
> make[1]: *** [csu/subdir_lib] Error 2
> make[1]: Leaving directory
> `/home/nicu/JUNGO/work/glibc2.1.3-the_rest/glibc-2.1.3'
> make: *** [all] Error 2
> 
> =======================================================================
> 
> Nicu


-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839
