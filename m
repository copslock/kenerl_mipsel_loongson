Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g53CmOnC029490
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 3 Jun 2002 05:48:24 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g53CmOnh029489
	for linux-mips-outgoing; Mon, 3 Jun 2002 05:48:24 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g53CmKnC029486
	for <linux-mips@oss.sgi.com>; Mon, 3 Jun 2002 05:48:21 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.SGI.COM [128.167.58.27]) with SMTP; 3 Jun 2002 12:50:10 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 326E1B46B; Mon,  3 Jun 2002 21:50:08 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id VAA22291; Mon, 3 Jun 2002 21:50:08 +0900 (JST)
Date: Mon, 03 Jun 2002 21:49:57 +0900 (JST)
Message-Id: <20020603.214957.105435769.nemoto@toshiba-tops.co.jp>
To: takeshi_aihana@montavista.co.jp
Cc: linux-mips@oss.sgi.com
Subject: Re: (Re-Send) shmctl() returns corrupt value on pb1000.
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <m3d6v8znap.wl@aihana>
References: <1022763778.1046.71.camel@aihana>
	<20020531.112847.74756483.nemoto@toshiba-tops.co.jp>
	<m3d6v8znap.wl@aihana>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Mon, 03 Jun 2002 19:09:18 +0900, Takeshi AIHANA <takeshi_aihana@montavista.co.jp> said:
takeshi_aihana> There are any differences 'struct shmid_ds' between
takeshi_aihana> glibc-2.2.3 and 2.2.4 that I saw.  However, I do not
takeshi_aihana> think those diffs are caused this problem.  Because
takeshi_aihana> the 'shm_segsz` which a member of this will be
takeshi_aihana> allocated on same location even if the follows members
takeshi_aihana> behind 'shm_segsz' are changed; i.e. it will have same
takeshi_aihana> value as 'shm_segsz' on both different structure.  Is
takeshi_aihana> this right?

Did you check the contents of 'shm_perm'?  The type of shm_perm is
'struct ipc64_perm' in kernel and 'struct ipc_perm' in libc.  I
suppose these definitions are differ.

---
Atsushi Nemoto
