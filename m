Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B7k9Rw016199
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 00:46:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B7k9IC016198
	for linux-mips-outgoing; Thu, 11 Jul 2002 00:46:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B7k0Rw016189;
	Thu, 11 Jul 2002 00:46:01 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6B7oLXb011040;
	Thu, 11 Jul 2002 00:50:21 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA02436;
	Thu, 11 Jul 2002 00:50:23 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6B7oNb17092;
	Thu, 11 Jul 2002 09:50:23 +0200 (MEST)
Message-ID: <3D2D38BE.F1C6AC73@mips.com>
Date: Thu, 11 Jul 2002 09:50:22 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: "H. J. Lu" <hjl@lucon.org>, Jun Sun <jsun@mvista.com>,
   linux-mips@oss.sgi.com
Subject: Re: Malta crashes on the latest 2.4 kernel
References: <3D2CBF73.50001@mvista.com> <20020710164900.A28911@lucon.org> <20020711043601.B3207@dea.linux-mips.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Wed, Jul 10, 2002 at 04:49:00PM -0700, H. J. Lu wrote:
>
> > > See the crash scene.  Anybody knows the cause?  It is strange to see the
> > > reserved exception.
> > >
> >
> > The 2.4 kernel checked out around Jul  4 09:28 PDT works fine on Malta.
>
> Jun's patch certainly is correct for some MIPS32 CPUs; others may get
> away without this one.  Previous experience with pipeline hazards on MIPS
> processors has shown that at times hazards may change even between minor
> revisions of a CPU; documentation isn't always trustworthy about such
> minor details of the pipeline.

I actually discovered the hazard problem on a 4Kc, based on some older RTL, but
the hazard some how disappear on a newer revision.
So you are absolutely right.

>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
