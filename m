Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9U39Nn31160
	for linux-mips-outgoing; Mon, 29 Oct 2001 19:09:23 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9U39G031157;
	Mon, 29 Oct 2001 19:09:16 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 30 Oct 2001 03:09:16 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 1ED97B46D; Tue, 30 Oct 2001 12:09:15 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id MAA35555; Tue, 30 Oct 2001 12:09:14 +0900 (JST)
Date: Tue, 30 Oct 2001 12:14:03 +0900 (JST)
Message-Id: <20011030.121403.41626778.nemoto@toshiba-tops.co.jp>
To: ahennessy@mvista.com
Cc: carstenl@mips.com, ralf@oss.sgi.com, ajob4me@21cn.com,
   linux-mips@oss.sgi.com
Subject: Re: Toshiba TX3927 board boot problem.
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <3BDDF193.B6405A7F@mvista.com>
References: <20011029.160225.59648095.nemoto@toshiba-tops.co.jp>
	<3BDD140E.432D795B@mips.com>
	<3BDDF193.B6405A7F@mvista.com>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Mon, 29 Oct 2001 16:17:23 -0800, Alice Hennessy <ahennessy@mvista.com> said:
ahennessy> I would think that the CU1 bit should never be set to one
ahennessy> for FPU-less CPUs.

I think so too.

Talking about TX3927, When I tried, TX3927 did NOT raise any exception
on cp1 instruction if CU1 bit enabled.  The CPU just locked there.  So
some workaround is necessary for TX3927.

---
Atsushi Nemoto
