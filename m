Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g27Ml3321252
	for linux-mips-outgoing; Thu, 7 Mar 2002 14:47:03 -0800
Received: from server3.toshibatv.com (mail.toshibatv.com [67.32.37.75])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g27Mkp921248
	for <linux-mips@oss.sgi.com>; Thu, 7 Mar 2002 14:46:51 -0800
Received: by SERVER3 with Internet Mail Service (5.5.2653.19)
	id <FQRY6L8V>; Thu, 7 Mar 2002 15:46:44 -0600
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA1B75EE@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "'Richard Hodges'" <rh@matriplex.com>
Cc: Linux MIPS <linux-mips@oss.sgi.com>
Subject: RE: Questions?
Date: Thu, 7 Mar 2002 15:44:30 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="windows-1252"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hmm, assembly or C? Your original message had examples in both. In C the
large part is the definitions in the union. 

If you define

struct le_bitfield {
	unsigned long low:8;
	unsigned long lmid:8;
	unsigned long hmid:8;
	unsigned long high:8;
};

struct be_bitfield {
	unsigned long high:8;
	unsigned long hmid:8;
	unsigned long lmid:8;
	unsigned long low:8;
};

union byte_swap {
	unsigned long original;
	struct le_bitfield le;
	struct be_bitfield be;
}swapper;

Now you can use your previous char pointer

	swapper.original = *((unsigned long *)mptr);
	mptr[0] = swapper.le.low;
	mptr[1] = swapper.le.lmid;
	mptr[2] = swapper.le.hmid;
	mptr[3] = swapper.le.high;

5 instructions in C.

To swap the other way, just use swapper.be.xxxx. If this still translates to
8 assembly instructions (or worse), oh well... just trying to help. ;)



-> -----Original Message-----
-> From: Richard Hodges [mailto:rh@matriplex.com]
-> Sent: Thursday, March 07, 2002 3:00 PM
-> To: Siders, Keith
-> Cc: Linux MIPS
-> Subject: RE: Questions?
-> 
-> 
-> On Thu, 7 Mar 2002, Siders, Keith wrote:
-> 
-> > You can get that down to 5 instructions. You could either 
-> use a typecast, or
-> > for portability, use a union definition. For that matter 
-> you could even
-> > typecast *mptr as a pointer to the union and extract the 
-> data from the
-> > string however you choose. But it still takes 5 
-> instructions, unless you're
-> > pulling the data into another buffer, in which case you're 
-> down to 4.
-> 
-> Which 5 instructions are those?  For htonl from memory, the 
-> only sequence
-> I can think of is the "obvious" one of lbu/shift (7 
-> instructions).  And
-> for swapping BE-LE in memory (an important thing for me), I 
-> do not see any
-> method better than the "obvious" one I mentioned earlier:
-> 
->     90c50000        lbu     a1,0(a2)
->     90c40001        lbu     a0,1(a2)
->     90c30002        lbu     v1,2(a2)
->     90c20003        lbu     v0,3(a2)
->     a0c20000        sb      v0,0(a2)
->     a0c30001        sb      v1,1(a2)
->     a0c40002        sb      a0,2(a2)
->     a0c50003        sb      a1,3(a2)
-> 
-> Thanks,
-> 
-> -Richard
-> 
-> > -> From: Richard Hodges [mailto:rh@matriplex.com]
-> 
-> > -> To me, byte swapping on MIPS actually seems rather 
-> > -> expensive.  The code
-> > -> for htonl (linux/byteorder/swab.h) ends up something like this:
-> > -> 
-> > ->         srl     $5,$4,8
-> > ->         andi    $5,$5,0xff00
-> > ->         srl     $2,$4,24
-> > ->         andi    $3,$4,0xff00
-> > ->         or      $2,$2,$5
-> > ->         sll     $3,$3,8
-> > ->         or      $2,$2,$3
-> > ->         sll     $4,$4,24
-> 
-> 
