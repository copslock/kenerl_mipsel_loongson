Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9HBdB726901
	for linux-mips-outgoing; Wed, 17 Oct 2001 04:39:11 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9HBd9D26898
	for <linux-mips@oss.sgi.com>; Wed, 17 Oct 2001 04:39:09 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for [216.32.174.27]) with SMTP; 17 Oct 2001 11:39:09 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id E626CB46A; Wed, 17 Oct 2001 20:39:06 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id UAA25195; Wed, 17 Oct 2001 20:39:06 +0900 (JST)
Date: Wed, 17 Oct 2001 20:43:58 +0900 (JST)
Message-Id: <20011017.204358.39150084.nemoto@toshiba-tops.co.jp>
To: raiko@niisi.msk.ru
Cc: hli@quicklogic.com, linux-mips@oss.sgi.com
Subject: Re: IDE DMA mode in Big endian for mips
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <3BCD506F.9683F0E8@niisi.msk.ru>
References: <APEOLACBIPNAFKJDDFIIEECJCBAA.hli@quicklogic.com>
	<20011017.113842.41627007.nemoto@toshiba-tops.co.jp>
	<3BCD506F.9683F0E8@niisi.msk.ru>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Wed, 17 Oct 2001 13:33:35 +0400, "Gleb O. Raiko" <raiko@niisi.msk.ru> said:
raiko> It seems you need either own version of outl and outw with byte
raiko> swapping or instruct your hw to do that itself (if your hw can,
raiko> of course).

Yes, I depend on hardware swapping on word/dword access.  It seems
many pci drivers depend on this swapping too.

---
Atsushi Nemoto
