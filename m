Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9J9nMb22401
	for linux-mips-outgoing; Fri, 19 Oct 2001 02:49:22 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9J9nJD22397
	for <linux-mips@oss.sgi.com>; Fri, 19 Oct 2001 02:49:19 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 19 Oct 2001 09:49:19 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 701DBB46D; Fri, 19 Oct 2001 18:49:17 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id SAA03896; Fri, 19 Oct 2001 18:49:44 +0900 (JST)
Date: Fri, 19 Oct 2001 18:54:07 +0900 (JST)
Message-Id: <20011019.185407.71082409.nemoto@toshiba-tops.co.jp>
To: geert@linux-m68k.org
Cc: raiko@niisi.msk.ru, hli@quicklogic.com, linux-mips@oss.sgi.com
Subject: Re: IDE DMA mode in Big endian for mips
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <Pine.GSO.4.21.0110180752320.9667-100000@mullein.sonytel.be>
	<APEOLACBIPNAFKJDDFIICEDCCBAA.hli@quicklogic.com>
References: <20011018.111843.41626947.nemoto@toshiba-tops.co.jp>
	<Pine.GSO.4.21.0110180752320.9667-100000@mullein.sonytel.be>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Thu, 18 Oct 2001 07:54:18 +0200 (MEST), Geert Uytterhoeven <geert@linux-m68k.org> said:
geert> The functions above should take care of endian conversion.

This is what I wanted to know.  Thank you.

>>>>> On Wed, 17 Oct 2001 13:52:20 -0400, "Hanks Li" <hli@quicklogic.com> said:
hli> Thanks Atsushi San, the patch did help. The partition check can
hli> pass now.

Sorry, my patch is not correct.  You can configure your PCI controller
to swap dword (if your hw have this function), or you can use
CONFIG_SWAP_IO_SPACE.

If your hardware have not this function AND you want to swap entire
I/O access (for example, do swap for PCI, not for other area), you may
have to create your own version of outl/outw etc.  (This is my
case...)

---
Atsushi Nemoto
