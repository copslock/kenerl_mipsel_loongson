Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Oct 2004 14:59:37 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:16163
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224841AbUJ2N7c>; Fri, 29 Oct 2004 14:59:32 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 29 Oct 2004 13:59:31 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP id CAE06239E3C
	for <linux-mips@linux-mips.org>; Fri, 29 Oct 2004 22:59:28 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i9TDxSdD001580
	for <linux-mips@linux-mips.org>; Fri, 29 Oct 2004 22:59:28 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 29 Oct 2004 22:58:17 +0900 (JST)
Message-Id: <20041029.225817.76758438.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Subject: failed to merge string constant? (gcc 3.4.2 + binutils 2.15)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I have some strange kernel panic with gcc 3.4.2 + binutils 2.15.
Address of some string constant seems broken.

For example, scsi_init_procfs() is compled to following code.

int __init scsi_init_procfs(void)
{
	struct proc_dir_entry *pde;

	proc_scsi = proc_mkdir("scsi", NULL);
	if (!proc_scsi)
		goto err1;
...

803d47f4 <scsi_init_procfs> 27bdffe8 	addiu	sp,sp,-24
803d47f8 <scsi_init_procfs+0x4> afb00010 	sw	s0,16(sp)
803d47fc <scsi_init_procfs+0x8> 3c108030 	lui	s0,0x8030
803d4800 <scsi_init_procfs+0xc> 2604c7e0 	addiu	a0,s0,-14368
803d4804 <scsi_init_procfs+0x10> afbf0014 	sw	ra,20(sp)
803d4808 <scsi_init_procfs+0x14> 0c03536f 	jal	800d4dbc <proc_mkdir>
803d480c <scsi_init_procfs+0x18> 00002821 	move	a1,zero

Then, 0x80300000-14368 = 0x802fc7e0 must contain a string "scsi".  But
when I loaded the kernel (ELF or binary), there is obvious wrong data.

802fc7e0  74 20 77 72 69 74 65 20  43 54 52 20 77 68 69 6c   t write CTR whil
802fc7f0  65 20 72 65 67 69 73 74  65 72 69 6e 67 2e 0a 00   e registering...
802fc800  3c 36 3e 73 65 72 69 6f  3a 20 69 38 30 34 32 20   <6>serio: i8042 
802fc810  25 73 20 70 6f 72 74 20  61 74 20 25 23 6c 78 2c   %s port at %#lx,

If I compiled kernel with -fno-merge-constants, this problem does not
happen.  gcc 3.3.4 + bintuils 2.15 also works fine.

Does anyone see this sort of problem?

---
Atsushi Nemoto
