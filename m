Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 11:21:27 +0100 (BST)
Received: from mailout01.sul.t-online.com ([IPv6:::ffff:194.25.134.80]:52615
	"EHLO mailout01.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8224821AbTGVKVX>; Tue, 22 Jul 2003 11:21:23 +0100
Received: from fwd01.aul.t-online.de 
	by mailout01.sul.t-online.com with smtp 
	id 19euGl-0002AO-04; Tue, 22 Jul 2003 12:21:19 +0200
Received: from denx.de (Vg-92mZFreGhMC6dlq8CELOFaOmGUu4fb50yd9quA8OXvOjbiZaEoE@[217.235.225.134]) by fmrl01.sul.t-online.com
	with esmtp id 19euGe-0QoGe00; Tue, 22 Jul 2003 12:21:12 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id B74914299F; Tue, 22 Jul 2003 12:21:10 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id ADB10C6D82; Tue, 22 Jul 2003 12:21:09 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id A9F4BC6D81; Tue, 22 Jul 2003 12:21:09 +0200 (MEST)
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [patch] Generic time fixes 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Tue, 22 Jul 2003 12:04:44 +0200."
             <20030722100444.GA4148@linux-mips.org> 
Date: Tue, 22 Jul 2003 12:21:04 +0200
Message-Id: <20030722102109.ADB10C6D82@atlas.denx.de>
X-Seen: false
X-ID: Vg-92mZFreGhMC6dlq8CELOFaOmGUu4fb50yd9quA8OXvOjbiZaEoE@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20030722100444.GA4148@linux-mips.org> Ralf Baechle wrote:
> 
> It's a common case to have a system boot up with the RTC date being
> completly off, then syncing via ntpdate and xntp to the accurate time.

Another common situation especially with embedded systems is that the
RTC holds the "correct"  time,  and  probably  runs  at  much  higher
precision  than  the systm clock. In such systems, NTP can be used to
keep the system time in sync with the RTC, but the system  time  must
never  be  written  back to the RTC. [Except when explicitely setting
the date&time.]

> I share your dislike of updating the RTC for performance reasons; these

There are more problems with the 11 minute mode.  We  ran  into  this
issue  for hard on some PowerPC systems. Assume a situation where the
RTC is connected through a I2C  bus.  Problem  1:  normally  the  i2c
drivers  will  be  loaded prety late, which means the system will run
initially with an undefined time. Problem 2: on some  actions  a  i2c
transfer  involves  programming an on-chip i2c controller, which will
perform the task and then signal it's done by an interrupt. On such a
system the 11 minute mode will crash the system because rtc_set  will
be called from interrupt contect itself.

There was a  somewhat  controverse  discussion  on  the  linuxppc_dev
mailing list, without a real solution.

> chips are impressive performance pigs.  So how about updating the RTC
> date only when
> 
>  - write the time to the RTC for the first time after NTP synchronizes
>  - write the time to the RTC if xtime.tv_sec <= last_rtc_update + 660

And never, ever update the RTC from interrupt context, please.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Free markets select for winning solutions."        - Eric S. Raymond
