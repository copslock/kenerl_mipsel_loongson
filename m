Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7O81rj06913
	for linux-mips-outgoing; Fri, 24 Aug 2001 01:01:53 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7O81od06910
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 01:01:51 -0700
Received: from inside-ms2.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 24 Aug 2001 08:01:50 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP
	id 0C8B254C12; Fri, 24 Aug 2001 17:01:47 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id RAA91025; Fri, 24 Aug 2001 17:01:46 +0900 (JST)
Date: Fri, 24 Aug 2001 17:06:21 +0900 (JST)
Message-Id: <20010824.170621.85418510.nemoto@toshiba-tops.co.jp>
To: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Cc: Ralf Baechle <ralf@uni-koblenz.de>
Subject: get_insn_opcode is broken (ll/sc emulation does not work)
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I found that get_insn_opcode(in traps.c) is broken.


static inline int get_insn_opcode(struct pt_regs *regs, unsigned int *opcode)
...
	if (!get_user(opcode, epc))


This must be:


static inline int get_insn_opcode(struct pt_regs *regs, unsigned int *opcode)
...
	if (!get_user(*opcode, epc))


Without this fix, ll/sc emulation might not work.

---
Atsushi Nemoto
