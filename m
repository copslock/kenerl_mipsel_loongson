Received:  by oss.sgi.com id <S554033AbQKIIae>;
	Thu, 9 Nov 2000 00:30:34 -0800
Received: from mx.mips.com ([206.31.31.226]:42886 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553759AbQKIIa1>;
	Thu, 9 Nov 2000 00:30:27 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA04454;
	Thu, 9 Nov 2000 00:29:19 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA19433;
	Thu, 9 Nov 2000 00:29:37 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id JAA12516;
	Thu, 9 Nov 2000 09:29:30 +0100 (MET)
Message-ID: <3A0A606A.CE90B43F@mips.com>
Date:   Thu, 09 Nov 2000 09:29:30 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Klaus Naumann <spock@mgnet.de>
CC:     Nicu Popovici <octavp@isratech.ro>,
        Ralf Baechle <ralf@uni-koblenz.de>,
        Linux/MIPS list <linux-mips@oss.sgi.com>
Subject: Re: MIPS kernel!
References: <Pine.LNX.4.21.0011090922450.7879-100000@spock.mgnet.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Klaus Naumann wrote:

> On Thu, 9 Nov 2000, Nicu Popovici wrote:
>
> > I try to compile the linux 2.2.13 and   I got that one from ftp.lineo.com.
> > I also tried to cross compile the linux_2_2 from CVS repository from
> > oss.sgi.com and I managed but that one does not have support for my
> > ATLAS borad and I can not run it on my machine.
>
> Did you also try 2.4 from oss.sgi.com ? If not you should try it,
> because IIRC 2.2 doesn't have ATLAS support but 2.4 has.
> I think I remember seeing a CVS commit which included ATLAS support
> into 2.4 ... correct me if I'm wrong.
>

The current version in the CVS repository doesn't work yet,.
I have sent Ralf a set of patches that should make it work, but I don't think
he has committed it yet.

>
>                 HTH, Klaus
>
> --
> Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
> Nickname    : Spock             | Org.: Mad Guys Network
> Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
> PGP Key     : www.mgnet.de/keys/key_spock.txt

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
