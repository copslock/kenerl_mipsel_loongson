Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g27M0Q019168
	for linux-mips-outgoing; Thu, 7 Mar 2002 14:00:26 -0800
Received: from mail.matriplex.com (ns1.matriplex.com [208.131.42.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g27M0L919163
	for <linux-mips@oss.sgi.com>; Thu, 7 Mar 2002 14:00:21 -0800
Received: from mail.matriplex.com (mail.matriplex.com [208.131.42.9])
	by mail.matriplex.com (8.9.2/8.9.2) with ESMTP id NAA01186;
	Thu, 7 Mar 2002 13:00:17 -0800 (PST)
	(envelope-from rh@matriplex.com)
Date: Thu, 7 Mar 2002 13:00:17 -0800 (PST)
From: Richard Hodges <rh@matriplex.com>
To: "Siders, Keith" <keith_siders@toshibatv.com>
cc: Linux MIPS <linux-mips@oss.sgi.com>
Subject: RE: Questions?
In-Reply-To: <7DF7BFDC95ECD411B4010090278A44CA1B75EC@ATVX>
Message-ID: <Pine.BSF.4.10.10203071250390.351-100000@mail.matriplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 7 Mar 2002, Siders, Keith wrote:

> You can get that down to 5 instructions. You could either use a typecast, or
> for portability, use a union definition. For that matter you could even
> typecast *mptr as a pointer to the union and extract the data from the
> string however you choose. But it still takes 5 instructions, unless you're
> pulling the data into another buffer, in which case you're down to 4.

Which 5 instructions are those?  For htonl from memory, the only sequence
I can think of is the "obvious" one of lbu/shift (7 instructions).  And
for swapping BE-LE in memory (an important thing for me), I do not see any
method better than the "obvious" one I mentioned earlier:

    90c50000        lbu     a1,0(a2)
    90c40001        lbu     a0,1(a2)
    90c30002        lbu     v1,2(a2)
    90c20003        lbu     v0,3(a2)
    a0c20000        sb      v0,0(a2)
    a0c30001        sb      v1,1(a2)
    a0c40002        sb      a0,2(a2)
    a0c50003        sb      a1,3(a2)

Thanks,

-Richard

> -> From: Richard Hodges [mailto:rh@matriplex.com]

> -> To me, byte swapping on MIPS actually seems rather 
> -> expensive.  The code
> -> for htonl (linux/byteorder/swab.h) ends up something like this:
> -> 
> ->         srl     $5,$4,8
> ->         andi    $5,$5,0xff00
> ->         srl     $2,$4,24
> ->         andi    $3,$4,0xff00
> ->         or      $2,$2,$5
> ->         sll     $3,$3,8
> ->         or      $2,$2,$3
> ->         sll     $4,$4,24
