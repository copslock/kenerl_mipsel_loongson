Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2003 07:29:46 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:22308
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225374AbTJ2H3O>; Wed, 29 Oct 2003 07:29:14 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 29 Oct 2003 07:29:33 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h9T7TO9X042791;
	Wed, 29 Oct 2003 16:29:25 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Wed, 29 Oct 2003 16:32:01 +0900 (JST)
Message-Id: <20031029.163201.39178653.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Huge dynamically linked program does not run on mips-linux
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20031022.171118.88468465.nemoto@toshiba-tops.co.jp>
References: <20031022.171118.88468465.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 3547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 22 Oct 2003 17:11:18 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
anemo> I have a problem that my huge dynamically linked program cause
anemo> SIGSEGV or SIGBUS immediately after running from main() on
anemo> mips-linux.

anemo> Digging into this problem, I found that GOT entries are
anemo> corrupted.
...
anemo> My program is huge enough so that older binutils causes
anemo> "relocation truncated to fit" error.

More information.  My program's .got size exceeds 64K.  It seems the
corruption does not happen if .got size is smaller then 64K.

$ mips-linux-readelf -e myapp
...
Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
...
  [21] .got              PROGBITS        100b15d0 a075d0 013a04 04 WAp  0   0 16

---
Atsushi Nemoto
