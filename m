Received:  by oss.sgi.com id <S553954AbQKHQhk>;
	Wed, 8 Nov 2000 08:37:40 -0800
Received: from [194.98.116.10] ([194.98.116.10]:33796 "EHLO hermes.epita.fr")
	by oss.sgi.com with ESMTP id <S553940AbQKHQhX>;
	Wed, 8 Nov 2000 08:37:23 -0800
Received: from purple42.epx.epita.fr (purple42.epx.epita.fr [10.225.7.1])
	by hermes.epita.fr id RAA20741 for <linux-mips@oss.sgi.com> 
	EPITA Paris France Wed, 8 Nov 2000 17:36:22 GMT
Received: by purple42.epx.epita.fr (Postfix, from userid 501)
	id 789622294; Wed,  8 Nov 2000 17:35:53 +0100 (CET)
Date:   Wed, 8 Nov 2000 17:35:53 +0100
From:   Thomas Poindessous <poinde_t@epita.fr>
To:     linux-mips@oss.sgi.com
Subject: Re: Decstation 5000/200
Message-ID: <20001108173553.A1305@purple42.epx.epita.fr>
References: <20001107162653.A31659@purple42.epx.epita.fr> <20001107213708.G1930@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001107213708.G1930@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Nov 07, 2000 at 09:37:08PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Nov 07, 2000 at 09:37:08PM +0100, Florian Lohoff wrote:
> On Tue, Nov 07, 2000 at 04:26:53PM +0100, Thomas Poindessous wrote:
> > Hi,
> > I have one IBM Decstation 5000/200 (PowerServer). 
> > I have minicom it but nothing, no garbage, nada.

First sorry for the wrong description.
It's a digital Decstation 5000/200.

> Are you sure you are not on the wrong serial ? 
> Do you have a Framebuffer and Keyboard attached ?

I connect my laplink to serial port #3
The keyboard is unplugged, and I hav test with and without the framebuffer
and the scsi controller. This box has three set of ram but no hard drive,
is it a problem ?

> > Where can I find these errors code ?
> 
> They are in the Decstation Hardware Reference Manual
> delivered with the Decstation - I havent got them
> handy right now but probably someone could copy
> them to a digital form and put it into the 
> Mips HOWTO.

It would be great.

> > BTW, is there a port for Mips Magnum R4000 (Big endian) ?
> 
> Hmm - From memory: yes - But i dont think it'll work out of the box
> as the have been a lot of kernel changes and nobody cared on the 
> Mips Magnum Port.

Ok, I will test.

> Flo
> -- 
> Florian Lohoff                  flo@rfc822.org             +49-5201-669912
>      Why is it called "common sense" when nobody seems to have any?
> 

-- 
Thomas Poindessous
EpX asso GNU/Linux de l'Epita
epx@epita.fr && http://www.epita.fr/~epx
