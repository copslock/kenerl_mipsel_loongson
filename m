Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UCHlnC002047
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 05:17:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UCHkkV002046
	for linux-mips-outgoing; Thu, 30 May 2002 05:17:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UCHhnC002040
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 05:17:43 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.SGI.COM [128.167.58.27]) with SMTP; 30 May 2002 12:19:15 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 26BDFB46B; Thu, 30 May 2002 21:19:13 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id VAA09184; Thu, 30 May 2002 21:19:12 +0900 (JST)
Date: Thu, 30 May 2002 21:19:02 +0900 (JST)
Message-Id: <20020530.211902.102583216.nemoto@toshiba-tops.co.jp>
To: takeshi_aihana@montavista.co.jp
Cc: linux-mips@oss.sgi.com
Subject: Re: (Re-Send) shmctl() returns corrupt value on pb1000.
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <1022757017.1045.47.camel@aihana>
References: <1022757017.1045.47.camel@aihana>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On 30 May 2002 20:10:16 +0900, Takeshi Aihana <takeshi_aihana@montavista.co.jp> said:
takeshi_aihana> I have a problem now about return the segment size of
takeshi_aihana> shared memory from shmctl() func.

What version of libc are you using?  It seems your kernel headers and
libc headers are inconsistent.

Please look structures in libc's /usr/include/bits/{ipc,sem,shm,msg}.h
and kernel's include/asm-mips/{ipc,sem,shm,msg}buf.h carefully.

---
Atsushi Nemoto
