Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fALCmav01371
	for linux-mips-outgoing; Wed, 21 Nov 2001 04:48:36 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fALCmQo01362;
	Wed, 21 Nov 2001 04:48:27 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 21 Nov 2001 11:48:26 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 30EB8B471; Wed, 21 Nov 2001 20:24:22 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id UAA05603; Wed, 21 Nov 2001 20:24:21 +0900 (JST)
Date: Wed, 21 Nov 2001 20:29:06 +0900 (JST)
Message-Id: <20011121.202906.28780735.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: Re: FP exception statistics
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20011121192530.A13414@dea.linux-mips.net>
References: <20011121.160347.48536367.nemoto@toshiba-tops.co.jp>
	<20011121192530.A13414@dea.linux-mips.net>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Wed, 21 Nov 2001 19:25:30 +1100, Ralf Baechle <ralf@oss.sgi.com> said:
ralf> It get's atomicity wrong.  I suggest to make such statistics a
ralf> per thread thing.  That'll not only solve the SMP issues but
ralf> also make sure processes running in parallel won't influence the
ralf> result.

Thank you for the comment.

Yes, my patch provides "CPU" statistics (not "thread" statistics).
Counting per thread might be useful in some case, but counting
globally (like "unaligned_instructions" or "ll_ops" counter) is enough
for me.

---
Atsushi Nemoto
