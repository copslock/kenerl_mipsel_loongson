Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0SGaao23023
	for linux-mips-outgoing; Mon, 28 Jan 2002 08:36:36 -0800
Received: from intotoinc.com (sdsl-66-80-10-146.dsl.sca.megapath.net [66.80.10.146])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0SGaWP23012
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 08:36:32 -0800
Received: from localhost (rajeshbv@localhost)
	by intotoinc.com (8.11.0/8.11.0) with ESMTP id g0SFZZp06635;
	Mon, 28 Jan 2002 07:35:35 -0800
Date: Mon, 28 Jan 2002 07:35:35 -0800 (PST)
From: Venkata Rajesh Bikkina <rajeshbv@intotoinc.com>
To: Jon Burgess <Jon_Burgess@eur.3com.com>
cc: linux-mips@oss.sgi.com
Subject: Re: INSMOD failing on MIPS
In-Reply-To: <80256B4F.00416BF5.00@notesmta.eur.3com.com>
Message-ID: <Pine.LNX.4.21.0201280731550.6584-100000@intotoinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi Jon,

Thankyou very much for your quick reply.
And it worked with your suggestion of adding "-G 0" for linking also.

Thanks,
--Rajesh


On Mon, 28 Jan 2002, Jon Burgess wrote:

> 
> 
> >But when i link two '.o' files with ld as
> >"mipsel-linux-ld -r -o temp.o temp.o temp1.o"
> >and insert the output 'temp.o' it is crashing.
> 
> I've seen this before, I think the solution is to use:
> 
> mipsel-linux-ld -G 0 -r -o temp.o temp.o temp1.o
> 
> Without the '-G0' the linker places small common variables into a '.scommon'
> section which insmod fails to relocate.
> 
> 'insmod' should complain in this situation or try to relocate these symbols
> properly.
> 
>      Jon Burgess
> 
> 
