Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4V2RSnC014339
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 19:27:28 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4V2RStg014338
	for linux-mips-outgoing; Thu, 30 May 2002 19:27:28 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4V2ROnC014334
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 19:27:25 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [128.167.58.27]) with SMTP; 31 May 2002 02:28:59 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 86EC0B46B; Fri, 31 May 2002 11:28:57 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id LAA10842; Fri, 31 May 2002 11:28:57 +0900 (JST)
Date: Fri, 31 May 2002 11:28:47 +0900 (JST)
Message-Id: <20020531.112847.74756483.nemoto@toshiba-tops.co.jp>
To: takeshi_aihana@montavista.co.jp
Cc: linux-mips@oss.sgi.com
Subject: Re: (Re-Send) shmctl() returns corrupt value on pb1000.
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <1022763778.1046.71.camel@aihana>
References: <1022757017.1045.47.camel@aihana>
	<20020530.211902.102583216.nemoto@toshiba-tops.co.jp>
	<1022763778.1046.71.camel@aihana>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On 30 May 2002 22:02:57 +0900, Takeshi Aihana <takeshi_aihana@montavista.co.jp> said:
takeshi_aihana> (B) The version of glibc on pb1000 is 2.2.3/kernel-2.4.17.

takeshi_aihana> Is there any inconsistents on those conditions?

AFAIK, Yes.  For example, look struct ipc_perm in bits/ipc.h and
struct ipc64_perm in asm-mips/ipcbuf.h (not struct ipc_perm in
linux/ipc.h which is obsolete).

takeshi_aihana> Should be update to 2.2.4 on pb1000?

If you can.  Please do not forget rebuilding all applications which
including these headers.  If you want to stay in 2.2.3, you will have
to modify your kernel headers according to the libc headers.

---
Atsushi Nemoto
