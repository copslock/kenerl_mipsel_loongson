Received: (from majordomo@localhost)
	by oss.sgi.com (8.9.3/8.9.3) id QAA14800
	for linuxmips-outgoing; Thu, 21 Oct 1999 16:33:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linuxmips@oss.sgi.com using -f
Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by oss.sgi.com (8.9.3/8.9.3) with ESMTP id QAA14796
	for <linuxmips@oss.sgi.com>; Thu, 21 Oct 1999 16:33:31 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA05502
	for <linuxmips@oss.sgi.com>; Thu, 21 Oct 1999 16:37:49 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA23761
	for linux-list;
	Thu, 21 Oct 1999 16:15:52 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA35567
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 21 Oct 1999 16:15:47 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA2714876
	for <linux@cthulhu.engr.sgi.com>; Thu, 21 Oct 1999 16:15:37 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id SAA16637;
	Thu, 21 Oct 1999 18:15:25 -0500
Date: Thu, 21 Oct 1999 18:14:15 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Linux SGI <linux@cthulhu.engr.sgi.com>
cc: linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Byte swapping versions of insl & outsl
Message-ID: <Pine.LNX.3.96.991021180759.30765C-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk


I needed these to get a 3COM Etherlink III working in the Indigo2.  I
don't know if anyone else could use them, but here they are.  I might be
able to come up with an algorithm that uses one or two fewer instructions.
The can probably be optimised to only use 3 registers instead of 4.  But 
thay are still a lot better than four consecutive insb/outsb.  If other
people are planning on using these I'll do it sooner rather than later.  
I'll try and sneak them into the CVS archive sometime soon ;)


/* 
 * Byte swapping versions of insl and outsl.  I needed these to get the
 * Etherlink III working efficiently on the Indigo2.  They might be useful
 * in porting other ISA drivers to big-endian architectures
 *
 * -Andrew
 */


extern inline void insl_sw(unsigned int port, void * addr, unsigned long count)
{
	if (count) __asm__ __volatile__ (
		".set\tnoreorder\n\t"
		".set\tnoat\n"
		"1:\tlw\t$1,%4(%5)\n\t"
		"subu\t%1,1\n\t"
		"sll\t$2,$1,24\n\t"
		"srl\t$3,$1,24\n\t"
		"or\t$4,$2,$3\n\t"
		"sll\t$2,$1,8\n\t"
		"srl\t$1,$2,16\n\t"
		"andi\t$2,$1,65280\n\t"
		"andi\t$3,$1,255\n\t"
		"sll\t$1,$3,16\n\t"
		"or\t$3,$2,$1\n\t"
		"or\t$1,$4,$3\n\t"
		"sw\t$1,(%0)\n\t"
		"bne\t$0,%1,1b\n\t"
		"addiu\t%0,%6\n\t"
		".set\tat\n\t"
		".set\treorder"
		: "=r" (addr), "=r" (count)
		: "0" (addr), "1" (count), "i" (0), "r" (mips_io_port_base+port), "I" ( 4 )
		: "$1", "$2", "$3", "$4" );
}

extern inline void outsl_sw(unsigned int port, void * addr, unsigned long count)
{
	if (count) __asm__ __volatile__ (
		".set\tnoreorder\n\t"
		".set\tnoat\n"
		"1:\tlw\t$1,(%0)\n\t"
		"subu\t%1,1\n\t"
		"sll\t$2,$1,24\n\t"
		"srl\t$3,$1,24\n\t"
		"or\t$4,$2,$3\n\t"
		"sll\t$2,$1,8\n\t"
		"srl\t$1,$2,16\n\t"
		"andi\t$2,$1,65280\n\t"
		"andi\t$3,$1,255\n\t"
		"sll\t$1,$3,16\n\t"
		"or\t$3,$2,$1\n\t"
		"or\t$1,$4,$3\n\t"
		"sw\t$1,%4(%5)\n\t"
		"bne\t$0,%1,1b\n\t"
		"addiu\t%0,%6\n\t"
		".set\tat\n\t"
		".set\treorder"
		: "=r" (addr), "=r" (count)
		: "0" (addr), "1" (count), "i" (0), "r" (mips_io_port_base+port), "I" ( 4 )
		: "$1", "$2", "$3", "$4" );
}
