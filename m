Received:  by oss.sgi.com id <S553840AbRAZHmn>;
	Thu, 25 Jan 2001 23:42:43 -0800
Received: from mx.mips.com ([206.31.31.226]:40162 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553657AbRAZHmX>;
	Thu, 25 Jan 2001 23:42:23 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id XAA03819;
	Thu, 25 Jan 2001 23:42:19 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA03616;
	Thu, 25 Jan 2001 23:42:16 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id IAA29845;
	Fri, 26 Jan 2001 08:42:10 +0100 (MET)
Message-ID: <3A712A52.FAC574F1@mips.com>
Date:   Fri, 26 Jan 2001 08:42:10 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     Michael Shmulevich <michaels@jungo.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: MIPS/linux compatible PCI network cards
References: <3A70A356.F3CA71F1@jungo.com> <20010125141632.B2311@bacchus.dhis.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:

> On Fri, Jan 26, 2001 at 12:06:14AM +0200, Michael Shmulevich wrote:
> > Date:   Fri, 26 Jan 2001 00:06:14 +0200
> > From: Michael Shmulevich <michaels@jungo.com>
> > To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
> > Subject: MIPS/linux compatible PCI network cards
> >
> > Hello all,
> >
> > I would like to ask if someone knows some more or less widely available
> > PCI network card that is compatible with MIPS/Linux.
> >
> > I have heard of Tulip and AMD's PCnet. I wonder if you heard of others.
>
> These all have already been used with Linux/MIPS.  I don't have any reports
> on the current status of these drivers.  If they don't work they should
> be reasonably easy to fix.

The tulip driver worked fine at least in the past. The AMD PCnet driver works
just fine, we are using it on our reference boards.


>
>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
