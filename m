Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9I2E1m14069
	for linux-mips-outgoing; Wed, 17 Oct 2001 19:14:01 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9I2DwD14066
	for <linux-mips@oss.sgi.com>; Wed, 17 Oct 2001 19:13:59 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for [216.32.174.27]) with SMTP; 18 Oct 2001 02:13:58 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 84800B46E; Thu, 18 Oct 2001 11:13:51 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id LAA00511; Thu, 18 Oct 2001 11:14:23 +0900 (JST)
Date: Thu, 18 Oct 2001 11:18:43 +0900 (JST)
Message-Id: <20011018.111843.41626947.nemoto@toshiba-tops.co.jp>
To: raiko@niisi.msk.ru
Cc: hli@quicklogic.com, linux-mips@oss.sgi.com
Subject: Re: IDE DMA mode in Big endian for mips
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20011017.204358.39150084.nemoto@toshiba-tops.co.jp>
References: <20011017.113842.41627007.nemoto@toshiba-tops.co.jp>
	<3BCD506F.9683F0E8@niisi.msk.ru>
	<20011017.204358.39150084.nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Wed, 17 Oct 2001 20:43:58 +0900 (JST), Atsushi Nemoto <nemoto@toshiba-tops.co.jp> said:
nemoto> Yes, I depend on hardware swapping on word/dword access.  It
nemoto> seems many pci drivers depend on this swapping too.

Sorry, last sentence might be wrong.  I doubt I have been
misunderstanding long time...

Can anybody explain me a PCI driver's policy of endianness?  Should we
use cpu_to_le32 with outl/writel?  Should we use cpu_to_le32 to write
32bit data to DMA area?

Thank you.
---
Atsushi Nemoto
