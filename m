Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6DEtZ116193
	for linux-mips-outgoing; Fri, 13 Jul 2001 07:55:35 -0700
Received: from t111.niisi.ras.ru (IDENT:root@t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6DEtYV16184
	for <linux-mips@oss.sgi.com>; Fri, 13 Jul 2001 07:55:34 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id SAA02910;
	Fri, 13 Jul 2001 18:56:06 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id SAA11711; Fri, 13 Jul 2001 18:53:16 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id SAA24868; Fri, 13 Jul 2001 18:49:11 +0400 (MSD)
Message-ID: <3B4F0A5B.C1C0287D@niisi.msk.ru>
Date: Fri, 13 Jul 2001 18:48:59 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Marc Karasek <marc_karasek@ivivity.com>
CC: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: RFC: run-time defining serial ports
References: <3B4E45D9.8DBE84E7@mvista.com> <995034043.1803.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Marc Karasek wrote:
> 
> All boot monitors (YAMON, PMON,
> REDBOOT) initialize the serial port as part of there bootup for use as a
> debug monitor, etc.  Why should we have to redo something that is
> already taken care of.

Because we've got completely another policy of handling a device. For
example, a boot monitor (good one) must implement polling technique
only, Linux uses interrupt-driven technique (well, mostly). In general
case, Linux has to reinitialize a device after a boot monitor. It's
clear.

Regards,
Gleb.
