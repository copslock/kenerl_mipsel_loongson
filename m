Received:  by oss.sgi.com id <S553891AbRAZHxn>;
	Thu, 25 Jan 2001 23:53:43 -0800
Received: from mx.mips.com ([206.31.31.226]:48610 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553842AbRAZHxh>;
	Thu, 25 Jan 2001 23:53:37 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id XAA03904;
	Thu, 25 Jan 2001 23:53:33 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA03884;
	Thu, 25 Jan 2001 23:53:31 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id IAA00535;
	Fri, 26 Jan 2001 08:53:25 +0100 (MET)
Message-ID: <3A712CF5.D783B18C@mips.com>
Date:   Fri, 26 Jan 2001 08:53:25 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     Pete Popov <ppopov@mvista.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: floating point on Nevada cpu
References: <3A6F8F66.6258801@mvista.com> <20010125141231.A2311@bacchus.dhis.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I have been run on a QED RM5261 for quite some time now.
Notice that even it got a FPU, you need to enable the FP emulator to be
fully IEEE compliant.

/Carsten

Ralf Baechle wrote:

> On Wed, Jan 24, 2001 at 06:28:54PM -0800, Pete Popov wrote:
>
> > Has anyone else used floating point with 52xx processors?
>
> Cobalt Qube since '97.  It's working :-)
>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
