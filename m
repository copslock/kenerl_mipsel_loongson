Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 09:09:13 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:6404
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225359AbTJVIIl>; Wed, 22 Oct 2003 09:08:41 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 22 Oct 2003 08:08:58 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h9M88m9X023964;
	Wed, 22 Oct 2003 17:08:49 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Wed, 22 Oct 2003 17:11:18 +0900 (JST)
Message-Id: <20031022.171118.88468465.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Huge dynamically linked program does not run on mips-linux
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I have a problem that my huge dynamically linked program cause
SIGSEGV or SIGBUS immediately after running from main() on mips-linux.

Digging into this problem, I found that GOT entries are corrupted.

Here are some informations from readelf and objdump:

$ mips-linux-readelf -a myapp
...
Relocation section '.rel.dyn' at offset 0xe3b20 contains 426 entries:
 Offset     Info    Type            Sym.Value  Sym. Name
...
100c47bc  003f7f03 R_MIPS_REL32      004e4990   getrlimit
...
Symbol table '.dynsym' contains 17742 entries:
   Num:    Value  Size Type    Bind   Vis      Ndx Name
...
 16255: 004e4990     0 FUNC    GLOBAL DEFAULT  UND getrlimit
...
Symbol table '.symtab' contains 26849 entries:
   Num:    Value  Size Type    Bind   Vis      Ndx Name
...
  7664: 004e4990     0 FUNC    GLOBAL DEFAULT  UND getrlimit
...

$ mips-linux-objdump -s -j .got myapp
...
Contents of section .got:
...
 100c47b0 100c5cba 00c07c54 100c5c5c 004e4990  ..\...|T..\\.NI.
...


0x004e4990 is "stub" routine to jump into libc's getrlimit.

0x100c47bc must contain 0x004e4990 at run-time, but when the signal
sent the value is 0x009c9320.  It is 0x004e4990+0x004e4990.

The outout from objdump shows 0x004e4990 is already in .got and the
output from readelf shows 0x004e4990 will be added to it by dynamic
loader.  Is my understanding right?

Could anyone tell me why binutils generate such informations?  Or is
this dynamic loader issue?

I'm using binutils 2.14, gcc-3.3.2, glibc-2.2.5.  I tried gcc-3.3.1,
glibc-2.3.2, uClibc-0.9.21, binutils-2.14.90.0.6 and binutils-cvs but
no lock.

My program is huge enough so that older binutils causes "relocation
truncated to fit" error.

The program can work well if statically linked.  Other (relatively
small) dynamically linked programs can work well also.

Thanks.
---
Atsushi Nemoto
