Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9IAbCX24458
	for linux-mips-outgoing; Thu, 18 Oct 2001 03:37:12 -0700
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9IAb8D24448
	for <linux-mips@oss.sgi.com>; Thu, 18 Oct 2001 03:37:08 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id OAA11970;
	Thu, 18 Oct 2001 14:36:53 +0300
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id OAA10851; Thu, 18 Oct 2001 14:32:52 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id NAA23636; Thu, 18 Oct 2001 13:32:07 +0300 (MSK)
Message-ID: <3BCEAFFD.3EDDBE29@niisi.msk.ru>
Date: Thu, 18 Oct 2001 14:33:33 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
CC: hli@quicklogic.com, linux-mips@oss.sgi.com
Subject: Re: IDE DMA mode in Big endian for mips
References: <20011017.113842.41627007.nemoto@toshiba-tops.co.jp>
		<3BCD506F.9683F0E8@niisi.msk.ru>
		<20011017.204358.39150084.nemoto@toshiba-tops.co.jp> <20011018.111843.41626947.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Atsushi Nemoto wrote:
> Can anybody explain me a PCI driver's policy of endianness?  

It depens on device and board. Most drivers assume PCI is little-endian,
but rely on outl implementation in byte swapping policy.

> Should we use cpu_to_le32 with outl/writel?  

If you can't instruct hw to perform byte-swapping for PCI IO, you have
to add cpu_to_le32, it's clear. For writel, i.e. PCI MEM the situation
is a bit subtle. The problem is your videocard, that may or may not
support byte swapping. So, in order to suport videocards that aren't
able to swap bytes, you have to setup PCI MEM in big-endian mode.

Look, for example, at the tulip driver, it swaps bytes for DMA and
doesn't do it for register access.

> Should we use cpu_to_le32 to write 32bit data to DMA area?

DMA data is stream of bytes. I would treat a device/board as broken, if
it would need byte swapping for DMA data.

Regards,
Gleb.
