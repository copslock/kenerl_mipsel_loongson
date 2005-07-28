Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jul 2005 12:21:36 +0100 (BST)
Received: from [IPv6:::ffff:213.189.19.80] ([IPv6:::ffff:213.189.19.80]:14345
	"EHLO mail.kpsws.com") by linux-mips.org with ESMTP
	id <S8225928AbVG1LVR>; Thu, 28 Jul 2005 12:21:17 +0100
Received: (qmail 61544 invoked by uid 89); 28 Jul 2005 11:23:50 -0000
Received: from unknown (HELO mail.kpsws.com) (127.0.0.1)
  by localhost with SMTP; 28 Jul 2005 11:23:50 -0000
Received: from 194.171.252.100
        (SquirrelMail authenticated user pulsar@kpsws.com)
        by mail.kpsws.com with HTTP;
        Thu, 28 Jul 2005 13:23:50 +0200 (CEST)
Message-ID: <26902.194.171.252.100.1122549830.squirrel@mail.kpsws.com>
In-Reply-To: <Pine.LNX.4.62.0507280935040.24391@numbat.sonytel.be>
References: <20050725213607Z8225534-3678+4335@linux-mips.org><57480.194.171.252.10
     0.1122478386.squirrel@mail.kpsws.com><20050727172427.GB3626@linux-mips
     .org> 
     <Pine.LNX.4.61L.0507271858050.13819@blysk.ds.pg.gda.pl><20050727192816
     .GF3626@linux-mips.org> 
     <Pine.LNX.4.62.0507280935040.24391@numbat.sonytel.be>
Date:	Thu, 28 Jul 2005 13:23:50 +0200 (CEST)
Subject: Re: CVS Update@linux-mips.org: linux
From:	"Niels Sterrenburg" <pulsar@kpsws.com>
To:	"Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	"Niels Sterrenburg " <pulsar@kpsws.com>,
	"Linux/MIPS Development" <linux-mips@linux-mips.org>
Reply-To: pulsar@kpsws.com
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Return-Path: <pulsar@kpsws.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pulsar@kpsws.com
Precedence: bulk
X-list: linux-mips

Hi all,

Quite a big threat this question generated (and that for some spaces) :-)

I've adapted my vimrc and check ralfs script when creating patches.

Thanks for all the feedback,

Niels Sterrenburg

> On Wed, 27 Jul 2005, Ralf Baechle wrote:
>> On Wed, Jul 27, 2005 at 07:03:16PM +0100, Maciej W. Rozycki wrote:
>> >  It doesn't wipe other rubbish like spaces followed by tabs, though --
>> > e.g. ones that would match "^ \t".  Perhaps `indent' could help with
>> them,
>> > but I trust my fingers and eyes instead. ;-)
>>
>> Of course it does:
>>
>> [ralf@box ~]$ echo -ne '  \t\t' | perl -pi -e 's/[ \t]+$//' | od -x
>> 0000000
>> [ralf@box ~]$
>
> Maciej meant spaces followed by tabs that do not end a line, e.g.
>
> | tux$ echo -ne '  \t\tx' | perl -pi -e 's/[ \t]+$//' | od -x
> | 0000000 2020 0909 0078
> | 0000005
>
> These are a bit more difficult to auto-remove, since simply removing them
> may
> change indentation (modulo 8).
>
> Gr{oetje,eeting}s,
>
> 						Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something like
> that.
> 							    -- Linus Torvalds
>
>
