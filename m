Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g27KLvk15643
	for linux-mips-outgoing; Thu, 7 Mar 2002 12:21:57 -0800
Received: from server3.toshibatv.com (mail.toshibatv.com [67.32.37.75])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g27KLn915637
	for <linux-mips@oss.sgi.com>; Thu, 7 Mar 2002 12:21:49 -0800
Received: by SERVER3 with Internet Mail Service (5.5.2653.19)
	id <FQRY6LZL>; Thu, 7 Mar 2002 13:21:43 -0600
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA1B75EC@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: Linux MIPS <linux-mips@oss.sgi.com>
Subject: RE: Questions?
Date: Thu, 7 Mar 2002 13:19:29 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="windows-1252"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

You can get that down to 5 instructions. You could either use a typecast, or
for portability, use a union definition. For that matter you could even
typecast *mptr as a pointer to the union and extract the data from the
string however you choose. But it still takes 5 instructions, unless you're
pulling the data into another buffer, in which case you're down to 4.

Keith

-> -----Original Message-----
-> From: Richard Hodges [mailto:rh@matriplex.com]
-> Sent: Thursday, March 07, 2002 11:57 AM
-> To: Ralf Baechle
-> Cc: Linux MIPS
-> Subject: Re: Questions?
-> 
-> 
-> On Thu, 7 Mar 2002, Ralf Baechle wrote:
-> 
-> > The MIPS ABI only covers big endian systems - every "real" 
-> MIPS UNIX
-> > system is big endian.  Everything else is a GNU extension. 
->  There is
-> > hardly any reason to choose a particular byteorder as 
-> usually endianess
-> > swapping takes so little CPU time that it isn't even 
-> meassurable but so
-> > I'm told there are exceptions.
-> 
-> To me, byte swapping on MIPS actually seems rather 
-> expensive.  The code
-> for htonl (linux/byteorder/swab.h) ends up something like this:
-> 
->         srl     $5,$4,8
->         andi    $5,$5,0xff00
->         srl     $2,$4,24
->         andi    $3,$4,0xff00
->         or      $2,$2,$5
->         sll     $3,$3,8
->         or      $2,$2,$3
->         sll     $4,$4,24
-> 
-> This may not be an issue if it is only needed a few times 
-> per packet, but
-> my system must byte-swap (LE to BE) about 500KB (or 4mb) per second.
-> Actually, I save a bit of work by combining the byte 
-> swapping with the
-> memory move, just after copy_from_user, and looks something like:
-> 
->     unsigned char a, b, c, d, *mptr;
-> 	a = mptr[0];
-> 	b = mptr[1];
-> 	c = mptr[2];
-> 	d = mptr[3];
-> 	mptr[0] = d;
-> 	mptr[1] = c;
-> 	mptr[2] = b;
-> 	mptr[3] = a;
-> 
-> This method works, but it is still 8 instructions per word.  
-> Yuck!  Does
-> anyone know of a _decent_ way to handle this on MIPS?
-> 
-> All the best,
-> 
-> -Richard
-> 
