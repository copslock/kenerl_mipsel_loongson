Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9J9ID021532
	for linux-mips-outgoing; Fri, 19 Oct 2001 02:18:13 -0700
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9J9I9D21526
	for <linux-mips@oss.sgi.com>; Fri, 19 Oct 2001 02:18:10 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id NAA31634;
	Fri, 19 Oct 2001 13:18:12 +0300
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id NAA15576; Fri, 19 Oct 2001 13:16:35 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id KAA26371; Fri, 19 Oct 2001 10:29:02 +0300 (MSK)
Message-ID: <3BCFD6C0.6035210C@niisi.msk.ru>
Date: Fri, 19 Oct 2001 11:31:12 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Gerald Champagne <gerald.champagne@esstech.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Moving kernel_entry to LOADADDR
References: <3BCF7AD2.2000000@esstech.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Gerald Champagne wrote:
> Is this worth changing in cvs, or did I miss something?

Embed your kernel in your own bootloader, load the bootloader from fixed
addr. In the bootloader move the kernel at any location you want and
jump to the kernel entry. The kernel entry is known at compile time, so
you can teach the bootloader. This way you won't disturb others.

Regards,
Gleb.
