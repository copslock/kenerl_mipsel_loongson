Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Mar 2003 23:27:03 +0000 (GMT)
Received: from mother.pmc-sierra.com ([IPv6:::ffff:216.241.224.12]:46841 "HELO
	mother.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225263AbTCNX1C>; Fri, 14 Mar 2003 23:27:02 +0000
Received: (qmail 24289 invoked by uid 104); 14 Mar 2003 23:26:55 -0000
Received: from Adam_Kiepul@pmc-sierra.com by mother by uid 101 with qmail-scanner-1.15 
 (uvscan: v4.1.40/v4252.  Clear:. 
 Processed in 1.209598 secs); 14 Mar 2003 23:26:55 -0000
Received: from unknown (HELO hymir.pmc-sierra.bc.ca) (134.87.114.120)
  by mother.pmc-sierra.com with SMTP; 14 Mar 2003 23:26:53 -0000
Received: from bby1exi01.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by hymir.pmc-sierra.bc.ca (jason/8.11.6) with ESMTP id h2ENQqh01812;
	Fri, 14 Mar 2003 15:26:52 -0800 (PST)
Received: by bby1exi01 with Internet Mail Service (5.5.2656.59)
	id <DCP4NR55>; Fri, 14 Mar 2003 15:26:52 -0800
Message-ID: <71690137A786F7428FF9670D47CB95ED10E01E@SJE4EXM01>
From: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>
To: "'Wayne Gowcher'" <wgowcher@yahoo.com>, linux-mips@linux-mips.org
Subject: RE: Tips on inspecting / debuging cache
Date: Fri, 14 Mar 2003 15:23:52 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Adam_Kiepul@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Adam_Kiepul@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi Wayne,

Enclosed please find routines that I developed for PMC-Sierra RM52x1 and RM7000 processors.
Enjoy!

Adam


# Cache Dump - will dump the cache contents from I or D cache.
# Arguments:
# a0 is 0 for I Cache or 1 for D Cache
# a1 is the pointer to the Tag/States Array. Size is Cache Size / 4. There are 2 words per line.
# a2 is the pointer to the Data Array (size equal to the Cache size, MUST be Set Size aligned)
# Note: For user's convenience the pointers can be in KSeg1 or KSeg0.
#
# The TagHi/TagLo registers are stored in an array pointed to by the 2nd argument.
#
# TagHi_Address(Set, Index) = a1 + Set*(SET_SIZE/4) + 8*Index
# TagLo_Address(Set, Index) = a1 + Set*(SET_SIZE/4) + 8*Index + 4
#
# In case of RM52x1 Caches are 32KB total, 2-way set-associative so SET_SIZE is 16KB.
# With 32B line size there are 16KB/32B = 512 lines per Set.
# Thus:
#
# TagHi_Address(Set, Index) = a1 + Set*4096 + 8*Index
# TagLo_Address(Set, Index) = a1 + Set*4096 + 8*Index + 4
#
# Where Set is 0..1 and Index is 0..511.
#
# Cache Data fields are stored in an array pointed to by the 3rd argument.
#
# Line_Data_Address(Set, Index) = a2 + Set*SET_SIZE + Index*32
#
# In case of RM52x1 it is:
#
# Line_Data_Address(Set, Index) = a2 + Set*16384 + Index*32
#
# Note: The Original Physical Address of a cache line has to be calculated based on Tag and Index.
#
# In case of RM52x1 the Physical Address of the cache line is calculated as follows:
#
# PA = ((TagLo & 0xffffff00) << 4) | ((Index*32) & 0x00000fff)
#
# Note: The PA and Data Field are only valid if the line is marked Valid in the TagLo.
# This means that the State field (TagLo[7:6]) must be 3 for D Cache or 2 for I Cache.



#define C0_TAGLO			$28
#define C0_TAGHI			$29

#define Index_Load_Tag_I		4
#define Index_Load_Tag_D		5
#define Index_Store_Tag_I		8
#define Index_Store_Tag_D		9
#define Hit_Writeback_I			24
#define Hit_Writeback_D			25
#define Create_Dirty_Exclusive_D	13

#define ICACHE_VALID			2
#define DCACHE_VALID			3


# Now: 1 is for RM52x1 and 0 is for RM7000

#define RM52x1				1

#if RM52x1
#define CACHE_SIZE			0x00008000
#else
#define CACHE_SIZE			0x00004000
#endif


	.text

	.set noreorder
	.set noat

	.globl cachedmp
	.ent	cachedmp

	.align 5

cachedmp:

# Switch to K1 (optional for D Cache dumping)

	la	t0, 1f
	li	t1, 0x20000000
	or	t0, t1
	jr	t0
	nop
1:

# Read and Modify the Tags/States

	li	t0, 0x80000000				# base address for Index cache ops in t0
	li	t1, 0x80000000+CACHE_SIZE-32		# end address in t1
	li	at, 0x20000000
	or	t2, a1, at				# convert a1 to a K1 address and put to t2
	or	a2, at
	xor	a2, at					# make sure pointer in a2 is a K0 address
	or	t3, a2, zero				# copy a2 to t3
L1:	bne	a0, zero, 1f
	nop
	cache	Index_Load_Tag_I, (t0)
	b	2f
	nop
1:	cache	Index_Load_Tag_D, (t0)
2:	nop ; nop ; nop ; nop
	mfc0	t4, C0_TAGHI
	mfc0	t5, C0_TAGLO
	sw	t4, 0(t2)				# preserve the original Tags/States
	sw	t5, 4(t2)
	li	t7, 0x1ffff000				# mask for PA[28:12]
	and	t7, t3					# mask bits of the pointer in t3
	srl	t7, 4					# t7 is now a Tag for the pointer
#if RM52x1
	li	t6, 0x0000003f
	and	t6, t5					# mask off the PTagLo and PState
	or	t6, t7					# "paste" the Tag value to t6
#else
	mtc0	t7, C0_TAGHI				# in RM7k the Tag is in TAGHI
	li	t6, 0xfff0003f
	and	t6, t5					# mask off the PState
#endif
	bne	a0, zero, 1f				# now set the PState field as valid
	nop
	b	2f
	ori	t6, ICACHE_VALID<<6
1:	ori	t6, DCACHE_VALID<<6
2:	mtc0	t6, C0_TAGLO				# write the new value to TAGLO
	nop ; nop ; nop ; nop
	bne	a0, zero, 1f
	nop
	cache	Index_Store_Tag_I, (t0)			# write back to the cache line states
	b	2f
	nop
1:	cache	Index_Store_Tag_D, (t0)
2:	addiu	t2, 8
	addiu	t3, 32
	bne	t0, t1, L1
	addiu	t0, 32

# For D Cache need to touch the lines in order to set the W bits (make them Dirty)
# We can not use Create_Dirty_Exclusive because it would clear the data fields.
# Therefore we read and store back a word in every line.

	beq	a0, zero, 1f				# Skip for I Cache
	nop

	or	t0, a2, zero
	li	t1, CACHE_SIZE-32
	addu	t1, t0
L2:	lw	t2, (t0)
	sw	t2, (t0)
	bne	t0, t1, L2
	addiu	t0, 32
1:

# Now Write Back the cache contents

	or	t0, a2, zero
	li	t1, CACHE_SIZE-32
	addu	t1, t0
L3:	bne	a0, zero, 1f
	nop
	cache	Hit_Writeback_I, (t0)
	b	2f
	nop
1:	cache	Hit_Writeback_D, (t0)
2:	bne	t0, t1, L3
	addiu	t0, 32

	jr	ra
	nop

	.end	cachedmp

##############################

/* Now: 1 is for RM52x1 and 0 is for RM7000 */

#define RM52x1				1


#if RM52x1
#define CACHE_SIZE	0x00008000
#define SET			2
#else
#define CACHE_SIZE	0x00004000
#define SET			4
#endif

#define SET_SIZE		(CACHE_SIZE/SET)
#define INDEX		SET_SIZE/32

#define Tag_Array_1	0xa0208000
#define Data_Array_1	0xa0200000
#define Tag_Array_2	0xa0218000
#define Data_Array_2	0xa0210000

unsigned char serial_buffer[250];

CacheDisplay(unsigned long TagsAddr, unsigned long DataAddr)
{ int Set, Index, i;
  unsigned long TAGHI, TAGLO, PA, State, Word, *CurrentTags, *CurrentWord;

CurrentTags=(unsigned long *)TagsAddr;

#if RM52x1
CurrentWord=(unsigned long *)DataAddr;
#else
CurrentWord=(unsigned long *)(DataAddr&0xdfffffff);
#endif
/* For RM7k we need to read the written-back data cached just in case it ends up in L2 */

for(Set=0; Set<SET; Set++)
    for(Index=0; Index<INDEX; Index++)
        { sprintf(serial_buffer, "\n\rSet: %d, Index: %03d", Set, Index);
          dumpstr(serial_buffer);
          TAGHI=*CurrentTags++;
          TAGLO=*CurrentTags++;
          sprintf(serial_buffer, "\n\rTAGHI=0x%08x, TAGLO=0x%08x", TAGHI, TAGLO);
          dumpstr(serial_buffer);
#if RM52x1
          PA=((TAGLO & 0xffffff00) << 4) | ((Index*32) & 0x00000fff);
#else
          PA=((TAGHI & 0xffffff00) << 4) | ((Index*32) & 0x00000fff);
#endif
          State=(TAGLO & 0x000000c0)>>6;
          sprintf(serial_buffer, "\n\rPA=0x%08x, State=0x%x, Data Words:\n\r", PA, State);
          dumpstr(serial_buffer);
          for(i=0; i<8; i++)
             { Word=*CurrentWord++;
               sprintf(serial_buffer, "%08x ", Word);
               dumpstr(serial_buffer);
             }
          dumpstr("\n\r");
        }
}

main()
{ 
dumpstr("\n\rRunning the cachedmp for D Cache\n\r");
cachedmp(1, Tag_Array_1, Data_Array_1);
CacheDisplay(Tag_Array_1, Data_Array_1);
dumpstr("\n\rRunning the cachedmp for I Cache\n\r");
cachedmp(0, Tag_Array_2, Data_Array_2);
CacheDisplay(Tag_Array_2, Data_Array_2);
}




-----Original Message-----
From: Wayne Gowcher [mailto:wgowcher@yahoo.com]
Sent: Thursday, March 13, 2003 6:13 PM
To: linux-mips@linux-mips.org
Subject: Tips on inspecting / debuging cache


Dear List,

I am wondering if someone could point me towards
articles / source code that would give me a little
insight into how to debug cache problems in mips.

For example , how do I inspect the contents of the
cache ? Are there routines to dump out the contents of
the cache ?

Any help, tips , pointers would be appreciated.

TIA

Wayne 



__________________________________________________
Do you Yahoo!?
Yahoo! Web Hosting - establish your business online
http://webhosting.yahoo.com
