Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBR4klD02790
	for linux-mips-outgoing; Wed, 26 Dec 2001 20:46:47 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBR4khX02787;
	Wed, 26 Dec 2001 20:46:44 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 27 Dec 2001 03:46:42 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 60E48B471; Thu, 27 Dec 2001 12:46:40 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id MAA00436; Thu, 27 Dec 2001 12:46:40 +0900 (JST)
Date: Thu, 27 Dec 2001 12:51:22 +0900 (JST)
Message-Id: <20011227.125122.71082554.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: dony.he@huawei.com, linux-mips@oss.sgi.com
Subject: Re: vmalloc bugs in 2.4.5???
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20011227011222.A16695@dea.linux-mips.net>
References: <20011226013221.A737@dea.linux-mips.net>
	<20011227.105518.74756316.nemoto@toshiba-tops.co.jp>
	<20011227011222.A16695@dea.linux-mips.net>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Thu, 27 Dec 2001 01:12:22 -0200, Ralf Baechle <ralf@oss.sgi.com> said:
ralf> Yes, you're right as for the cache.  But there is no reason for
ralf> the TLB flush, right?

Yes, I agree.

---
Atsushi Nemoto
