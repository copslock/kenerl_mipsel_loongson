Received:  by oss.sgi.com id <S553760AbQKGUhc>;
	Tue, 7 Nov 2000 12:37:32 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:39182 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553747AbQKGUhS>;
	Tue, 7 Nov 2000 12:37:18 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id BBB7084B; Tue,  7 Nov 2000 21:37:15 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 419548F81; Tue,  7 Nov 2000 21:37:08 +0100 (CET)
Date:   Tue, 7 Nov 2000 21:37:08 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Thomas Poindessous <poinde_t@epita.fr>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Decstation 5000/200
Message-ID: <20001107213708.G1930@paradigm.rfc822.org>
References: <20001107162653.A31659@purple42.epx.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001107162653.A31659@purple42.epx.epita.fr>; from poinde_t@epita.fr on Tue, Nov 07, 2000 at 04:26:53PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Nov 07, 2000 at 04:26:53PM +0100, Thomas Poindessous wrote:
> Hi,
> I have one IBM Decstation 5000/200 (PowerServer). 
> I have minicom it but nothing, no garbage, nada.

Are you sure you are not on the wrong serial ? 
Do you have a Framebuffer and Keyboard attached ?

> The little led behind are set like this.
> 
> .XXX..XX  (X light, . no light)
> 
> After two day of google, I still can't find what are errors code ?


> Where can I find these errors code ?

They are in the Decstation Hardware Reference Manual
delivered with the Decstation - I havent got them
handy right now but probably someone could copy
them to a digital form and put it into the 
Mips HOWTO.

> BTW, is there a port for Mips Magnum R4000 (Big endian) ?

Hmm - From memory: yes - But i dont think it'll work out of the box
as the have been a lot of kernel changes and nobody cared on the 
Mips Magnum Port.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
