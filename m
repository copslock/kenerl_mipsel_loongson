Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 16:50:50 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:51152 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133415AbWDQPuk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Apr 2006 16:50:40 +0100
Received: from localhost (p1246-ipad213funabasi.chiba.ocn.ne.jp [124.85.66.246])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A4203A744; Tue, 18 Apr 2006 01:03:02 +0900 (JST)
Date:	Tue, 18 Apr 2006 01:03:27 +0900 (JST)
Message-Id: <20060418.010327.115906647.anemo@mba.ocn.ne.jp>
To:	sam@ravnborg.org
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix modpost segfault for 64bit mipsel kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060417134005.GA13304@mars.ravnborg.org>
References: <20060417.210039.95063383.nemoto@toshiba-tops.co.jp>
	<20060417134005.GA13304@mars.ravnborg.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 17 Apr 2006 15:40:05 +0200, Sam Ravnborg <sam@ravnborg.org> wrote:
> Maybe we need to do some simple range check also so it becomes:
> 	if ((sym->st_shndx >= SHN_LORESERVE) || (sym > elf->symtab_stop))
> 		continue;
> 
> Could you try this - and if you still see the SEGVAL then try to print
> out the value of all members in 'r'.
> 
> You can also try to add '-g' to HOSTCFLAGS in toplevel makefile.
> Then use make V=1 to see what arguments modpost is caleld with and call
> it from the commandline or from a debugger.

When segfault happened, 'sym' has an invalid value.  Here is gdb session log:

$ gdb scripts/mod/modpost
GNU gdb 6.3-debian
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-linux"...Using host libthread_db library "/lib/tls/libthread_db.so.1".

(gdb) run -m -a -o /home/git/build-swarm-le/Module.symvers   vmlinux crypto/aes.o crypto/anubis.o crypto/arc4.o crypto/blowfish.o crypto/cast5.o crypto/cast6.o crypto/crc32c.o crypto/crypto_null.o crypto/deflate.o crypto/des.o crypto/khazad.o crypto/md4.o crypto/md5.o crypto/michael_mic.o crypto/serpent.o crypto/sha1.o crypto/sha256.o crypto/sha512.o crypto/tea.o crypto/tgr192.o crypto/twofish.o crypto/wp512.o drivers/base/firmware_class.o drivers/block/aoe/aoe.o drivers/block/pktcdvd.o drivers/connector/cn.o drivers/input/serio/serio_raw.o drivers/net/phy/cicada.o drivers/net/phy/davicom.o drivers/net/phy/libphy.o drivers/net/phy/lxt.o drivers/net/phy/marvell.o drivers/net/phy/qsemi.o fs/fuse/fuse.o lib/crc16.o lib/libcrc32c.o lib/zlib_deflate/zlib_deflate.o lib/zlib_inflate/zlib_inflate.o net/ieee80211/ieee80211.o net/ieee80211/ieee80211_crypt.o net/ieee80211/ieee80211_crypt_ccmp.o net/ieee80211/ieee80211_crypt_wep.o net/xfrm/xfrm_user.o
Starting program: /home/git/build-swarm-le/scripts/mod/modpost -m -a -o /home/git/build-swarm-le/Module.symvers   vmlinux crypto/aes.o crypto/anubis.o crypto/arc4.o crypto/blowfish.o crypto/cast5.o crypto/cast6.o crypto/crc32c.o crypto/crypto_null.o crypto/deflate.o crypto/des.o crypto/khazad.o crypto/md4.o crypto/md5.o crypto/michael_mic.o crypto/serpent.o crypto/sha1.o crypto/sha256.o crypto/sha512.o crypto/tea.o crypto/tgr192.o crypto/twofish.o crypto/wp512.o drivers/base/firmware_class.o drivers/block/aoe/aoe.o drivers/block/pktcdvd.o drivers/connector/cn.o drivers/input/serio/serio_raw.o drivers/net/phy/cicada.o drivers/net/phy/davicom.o drivers/net/phy/libphy.o drivers/net/phy/lxt.o drivers/net/phy/marvell.o drivers/net/phy/qsemi.o fs/fuse/fuse.o lib/crc16.o lib/libcrc32c.o lib/zlib_deflate/zlib_deflate.o lib/zlib_inflate/zlib_inflate.o net/ieee80211/ieee80211.o net/ieee80211/ieee80211_crypt.o net/ieee80211/ieee80211_crypt_ccmp.o net/ieee80211/ieee80211_crypt_wep.o net/xfrm/xfrm_user.o

Program received signal SIGSEGV, Segmentation fault.
check_sec_ref (mod=0x806a2d8, modname=0xbffff79a "crypto/aes.o",
    elf=0xbffff230, section=0x804a050 <init_section>,
    section_ref_ok=0x804a0b0 <init_section_ref_ok>)
    at /home/git/linux-mips/scripts/mod/modpost.c:717
717                             if (sym->st_shndx >= SHN_LORESERVE)
(gdb) p/x sym
$1 = 0xf8161a58
(gdb) p/x elf->symtab_start
$2 = 0x40161a58
(gdb) p/x r
$3 = {r_offset = 0x1a4, r_info = 0x1d00000000000004, r_addend = 0x2028}


I suppose r_info have is following layout on 64bit mips:

typedef struct
{
  Elf32_Word    r_sym;		/* Symbol index */
  unsigned char r_ssym;		/* Special symbol for 2nd relocation */
  unsigned char r_type3;	/* 3rd relocation type */
  unsigned char r_type2;	/* 2nd relocation type */
  unsigned char r_type1;	/* 1st relocation type */
} _Elf64_Mips_R_Info;

For 64bit big-endian mips, r_info was byte-swapped by TO_NATIVE, so I
can use standard ELF_R_SYM().

---
Atsushi Nemoto
