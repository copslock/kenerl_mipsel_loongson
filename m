Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9H9bdu22530
	for linux-mips-outgoing; Wed, 17 Oct 2001 02:37:39 -0700
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9H9bRD22521
	for <linux-mips@oss.sgi.com>; Wed, 17 Oct 2001 02:37:30 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id NAA32647;
	Wed, 17 Oct 2001 13:37:25 +0300
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id NAA05416; Wed, 17 Oct 2001 13:32:32 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id MAA16320; Wed, 17 Oct 2001 12:32:24 +0300 (MSK)
Message-ID: <3BCD506F.9683F0E8@niisi.msk.ru>
Date: Wed, 17 Oct 2001 13:33:35 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
CC: hli@quicklogic.com, linux-mips@oss.sgi.com
Subject: Re: IDE DMA mode in Big endian for mips
References: <20011012225433.A10523@lucon.org>
		<APEOLACBIPNAFKJDDFIIEECJCBAA.hli@quicklogic.com> <20011017.113842.41627007.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Atsushi Nemoto wrote:
> When I tried PCI-IDE in BigEndian (with 2.4.6 kernel), this patch
> solved my problem.
> 

It seems you need either own version of outl and outw with byte swapping
or instruct your hw to do that itself (if your hw can, of course).

Regards,
Gleb.
