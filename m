Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9V4PSN20502
	for linux-mips-outgoing; Tue, 30 Oct 2001 20:25:28 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9V4PO020499;
	Tue, 30 Oct 2001 20:25:24 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 31 Oct 2001 04:25:24 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 31F13B46D; Wed, 31 Oct 2001 13:25:23 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id NAA38941; Wed, 31 Oct 2001 13:25:22 +0900 (JST)
Date: Wed, 31 Oct 2001 13:30:11 +0900 (JST)
Message-Id: <20011031.133011.11593683.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: carstenl@mips.com, ahennessy@mvista.com, ajob4me@21cn.com,
   linux-mips@oss.sgi.com
Subject: Re: Toshiba TX3927 board boot problem.
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20011031050637.B8456@dea.linux-mips.net>
References: <20011030155533.A28550@dea.linux-mips.net>
	<20011031.115856.41626992.nemoto@toshiba-tops.co.jp>
	<20011031050637.B8456@dea.linux-mips.net>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Wed, 31 Oct 2001 05:06:37 +0100, Ralf Baechle <ralf@oss.sgi.com> said:
ralf> I don't think there is much point in returning a version number
ralf> if there is nothing we could return a version number of.  Well,
ralf> maybe the fp emulation sw version or kernel version.  What would
ralf> you consider a sensible return value?

The reason of my request is that user-mode gdb reports error on "info
reg" command.  "info reg" command shows fsr and fir.

So, I don't care the return value.  I think "0" is enough for FPU-less
CPUs.

---
Atsushi Nemoto
