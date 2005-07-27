Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2005 16:36:02 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:28613 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225539AbVG0Pfp>;
	Wed, 27 Jul 2005 16:35:45 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j6RFc9pr003723;
	Wed, 27 Jul 2005 17:38:09 +0200 (MEST)
Date:	Wed, 27 Jul 2005 17:37:52 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Niels Sterrenburg <pulsar@kpsws.com>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <57480.194.171.252.100.1122478386.squirrel@mail.kpsws.com>
Message-ID: <Pine.LNX.4.62.0507271736150.9140@numbat.sonytel.be>
References: <20050725213607Z8225534-3678+4335@linux-mips.org>
 <57480.194.171.252.100.1122478386.squirrel@mail.kpsws.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 27 Jul 2005, Niels Sterrenburg wrote:
> Do you detect and fix these trailing whitespaces with a script ?

For detection, if you use vim, you want to add

    let c_space_errors=1

to your .vimrc and make the superfluous spacing hurt your eyes.

> If so can you tell me where I can find it (or send it)?

sed(1) is your friend ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
