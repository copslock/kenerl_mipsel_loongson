Received:  by oss.sgi.com id <S553785AbQLSSuq>;
	Tue, 19 Dec 2000 10:50:46 -0800
Received: from router.isratech.ro ([193.226.114.69]:6918 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553712AbQLSSug>;
	Tue, 19 Dec 2000 10:50:36 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id eBJIoGp21651;
	Tue, 19 Dec 2000 20:50:17 +0200
Message-ID: <3A401C4D.C3FAB4D4@isratech.ro>
Date:   Tue, 19 Dec 2000 21:41:17 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Writting flash.
References: <20001219091316.10085.qmail@nw175.netaddress.usa.net> <3A3F3C6E.39C64947@mips.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello Carsten,

I folowed the ATLAS instructions but when I do cat flashimage > /dev/lp0 it get
stucked at the first write . I will send you what message I get when I run strace
cat flashimage > /dev/lp0.

open("claudiuwright", O_RDONLY|O_LARGEFILE) = 3
fstat(3, {st_mode=S_IFREG|0664, st_size=2479223, ...}) = 0
read(3, "!R\n@1c000000\n>UploadSS\n!E\n000000"..., 512) = 512
write(1, "!R\n@1c000000\n>UploadSS\n!E\n000000"..., 512

Do you have any ideea ?

Please try to give me a clue because in the ATLAS docs says that I have to set the
parallel prot to Generic text only and I do not know how to do that. Second I guess
that it stucks from other reasons .

Best Regards,
Nicu

Carsten Langgaard wrote:

> It should be straight forward, just follow the Atlas documentation.
> I don't think you need to do anything with the parallel port, except that you
> need parallel port support on you linux PC, of course.
>
> /Carsten
>
> POPOVICI Nicolae wrote:
>
> > Hello Carlsten,
> >
> >  My address is actually octavpo@isratech.ro but I need an answer to my
> > problem.
> > So I have to write the system flash on an ATLAS board. PLease tell me how do I
> > do that. I read the manuals that come with the board and there it says that I
> > have to set the parallel port to "Generic text only". How do I do that on a
> > LINUX machine ? Then I just copy the file that I want to write in system flash
> > to the parallel port , am I correct ?
> > I do not have to convert the file that I want to write in FLASH in a text only
> > format !!!! Am I correct ?
> >
> > Please try to tell me how can I write the system flash with as much details as
> > you can.
> >
> > Regards,
> > Nicu
> >
> >
> >
> > ____________________________________________________________________
> > Get free email and a permanent address at http://www.netaddress.com/?N=1
>
> --
> _    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark             http://www.mips.com
