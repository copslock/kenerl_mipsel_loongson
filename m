Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7G2xZj05113
	for linux-mips-outgoing; Wed, 15 Aug 2001 19:59:35 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7G2xUj05106;
	Wed, 15 Aug 2001 19:59:30 -0700
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 16 Aug 2001 02:59:30 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP
	id 25ACD54C0E; Thu, 16 Aug 2001 11:59:28 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id LAA69534; Thu, 16 Aug 2001 11:59:27 +0900 (JST)
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: SysV IPC shared memory and virtual alising
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20010814104941.F5928@bacchus.dhis.org>
References: <20010806164452D.nemoto@toshiba-tops.co.jp>
	<20010814104941.F5928@bacchus.dhis.org>
X-Mailer: Mew version 1.94.2 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010816120401V.nemoto@toshiba-tops.co.jp>
Date: Thu, 16 Aug 2001 12:04:01 +0900
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Tue, 14 Aug 2001 10:49:41 +0200, Ralf Baechle <ralf@oss.sgi.com> said:
ralf> It's wasting huge amounts of address space.  That can be
ralf> prohibitive if you want to run something such as electric fence.
ralf> Technically the worst case of any CPU that's required is 32kb on
ralf> R4000 / R4400 SC and MC versions, so I don't want to go beyond
ralf> that.

Yes.  My patch is wasting address space.  I did not know reasonable
size for alignment, so I used SHMLBA value.  It may be better to
calculate proper alignment size on run-time or compile-time.

ralf> What does this patch have to do with SysV shared mem?  Shmat(2)
ralf> does proper alignment checking and aligning and doesn't call
ralf> arch_get_unmapped_area.

I tried with this code (Xshm extention in Xserver use shm like this) :

	shmid = shmget(IPC_PRIVATE, 0x1000, IPC_CREAT | 0777);
	data = shmat(shmid, 0, 0);
	data2 = shmat(shmid, 0, 0);

In this case, get_unmapped_area() is called with a file structure does
not have 'get_unmapped_area' operation ('shmem_file_operations') so
arch_get_unmapped_area() is called.

---
Atsushi Nemoto
