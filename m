Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5PC2OO29189
	for linux-mips-outgoing; Mon, 25 Jun 2001 05:02:24 -0700
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5PC2LV29186
	for <linux-mips@oss.sgi.com>; Mon, 25 Jun 2001 05:02:23 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id QAA02013;
	Mon, 25 Jun 2001 16:02:32 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id PAA23418; Mon, 25 Jun 2001 15:55:51 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id PAA18618; Mon, 25 Jun 2001 15:59:51 +0400 (MSD)
Message-ID: <3B372BE8.C9B3D08F@niisi.msk.ru>
Date: Mon, 25 Jun 2001 16:17:44 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: =?iso-8859-1?Q?=C1=B6=BE=E7=C8=AF?= <joey@medialincs.com>
CC: linux-mips@oss.sgi.com
Subject: Re: SanDisk flash memory 16M
References: <200106250104.KAA00397@intranet.medialincs.com>
Content-Type: text/plain; charset=iso-8859-1
X-MIME-Autoconverted: from 8bit to quoted-printable by t111.niisi.ras.ru id QAA02013
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f5PC2NV29187
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Á¶¾çÈ¯ wrote:
> 
> anyone have experience SanDisk flash memory porting?
> I finded driver for Intel & AMD driver, but this flash device
> is not documented..
> 
> and CFI is not ported on Big Endian machine?

Indeed. Check MTD cvs.

Regards,
Gleb.
