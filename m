Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7V6IcT10590
	for linux-mips-outgoing; Thu, 30 Aug 2001 23:18:38 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7V6Iad10587
	for <linux-mips@oss.sgi.com>; Thu, 30 Aug 2001 23:18:36 -0700
Received: from inside-ms2.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 31 Aug 2001 06:18:36 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP id D47A054C0E
	for <linux-mips@oss.sgi.com>; Fri, 31 Aug 2001 15:18:33 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id PAA08308; Fri, 31 Aug 2001 15:18:31 +0900 (JST)
Date: Fri, 31 Aug 2001 15:23:10 +0900 (JST)
Message-Id: <20010831.152310.104026325.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Subject: ret_from_sys_call and signal
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

After merging with 2.4.6 kernel, ret_from_sys_call (and
o32_ret_from_sys_call) does not check whether it returns to kernel
mode or not.

syscall may happen in kernel mode, so we should check KU_USER bits (as
 done in past code).  Is this right?

At least, currently DO_FAULT() jumps to ret_from_sys_call and it may
cause problems.  If page fault happened in kernel code when any
signals pending, do_signal() is called before returning to kernel and
it fails to setup sigcontext.

Any ideas?

---
Atsushi Nemoto
