Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g69677Rw026311
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Jul 2002 23:07:07 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g69677a7026310
	for linux-mips-outgoing; Mon, 8 Jul 2002 23:07:07 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6966rRw026276;
	Mon, 8 Jul 2002 23:06:53 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g696B4Xb002128;
	Mon, 8 Jul 2002 23:11:04 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA20879;
	Mon, 8 Jul 2002 23:11:05 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g696B5b19705;
	Tue, 9 Jul 2002 08:11:05 +0200 (MEST)
Message-ID: <3D2A7E79.605DA06@mips.com>
Date: Tue, 09 Jul 2002 08:11:05 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: Ralf Baechle <ralf@oss.sgi.com>, Jun Sun <jsun@mvista.com>,
   linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: PATCH: Fix SHMLBA for mips (Re: LTP testing (shmat01))
References: <3D246924.542682B2@mips.com> <20020704193414.A29570@dea.linux-mips.net> <3D249181.D9147AAE@mips.com> <20020704215614.B29422@dea.linux-mips.net> <3D29CC6B.5090004@mvista.com> <20020708194539.C2758@dea.linux-mips.net> <3D29D65C.84630789@mips.com> <20020708112903.A14451@lucon.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Looks fine to me.
Thanks
/Carsten


"H. J. Lu" wrote:

> On Mon, Jul 08, 2002 at 08:13:48PM +0200, Carsten Langgaard wrote:
> > I have no preferences of the value of SHMLBA, as long as the define in
> > /usr/include/sys/shm.c and include/asm-mips/shmparam.h are in sync.
> >
> > /Carsten
> >
>
> How about this patch?
>
> H.J.
>
>   ------------------------------------------------------------------------
>
>    glibc-mips-shm.patchName: glibc-mips-shm.patch
>                        Type: Plain Text (text/plain)

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
