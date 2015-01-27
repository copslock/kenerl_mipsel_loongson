Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2015 17:15:35 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57683 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011124AbbA0QPdEmbky (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jan 2015 17:15:33 +0100
Date:   Tue, 27 Jan 2015 16:15:33 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
In-Reply-To: <54C69FCE.80002@gmail.com>
Message-ID: <alpine.LFD.2.11.1501262345320.28301@eddie.linux-mips.org>
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com> <54BF12B9.8000507@gentoo.org> <alpine.LFD.2.11.1501210347180.28301@eddie.linux-mips.org> <20150126131621.GB31322@linux-mips.org> <alpine.LFD.2.11.1501261358540.28301@eddie.linux-mips.org>
 <54C68429.4030701@gmail.com> <alpine.LFD.2.11.1501261904310.28301@eddie.linux-mips.org> <54C69FCE.80002@gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, 26 Jan 2015, David Daney wrote:

> >   Well, read(2), write(2) and similar calls operate on byte streams, these
> > are endianness agnostic (like the text of this e-mail for example is --
> > it's stored in memory of a byte-addressed computer the same way regardless
> > of its processor's endianness).
> 
> This is precisely the point I was attempting to make.  What you say here is
> *not* correct with respect to MIPS as specified in the architecture reference
> mentioned above.  The byte streams are scrambled up when viewed from contexts
> of opposite endianness.
> 
> Byte streams are *not* endian agnostic, but aligned 64-bit loads and stores
> are.
> 
> It is bizarre, and perhaps almost mind bending, but that seems to be how it is
> specified.  Certainly the OCTEON implementation works this way.

 Well, I think this observation:

"2.2.2.2 Memory Operation Functions

"Regardless of byte ordering (big- or little-endian), the address of a 
halfword, word, or doubleword is the smallest byte address of the bytes 
that form the object.  For big-endian ordering this is the 
most-significant byte; for a little-endian ordering this is the 
least-significant byte."

contradicts your claim as it would not be possible to have all these 
quantities at once arranged such that the smallest byte address points at 
the quantity itself *and* the MSB or LSB for the big- and the 
little-endian memory interface byte ordering respectively *both* at a 
time.

 The implication of the above observation is that a 64-bit, 32-bit and 
16-bit values of 0xfedcba9876543210, 0x76543210 and 0x3210 respectively 
are for the individual memory interface endiannesses stored in memory like 
this:

         memory interface endiannesses          | memory
  big    little   big    little   big    little | address
------------------------------------------------+---------
  0x10    0xfe                                  |    7
  0x32    0xdc                                  |    6
  0x54    0xba                                  |    5
  0x76    0x98                                  |    4
  0x98    0x76    0x10    0x76                  |    3
  0xba    0x54    0x32    0x54                  |    2
  0xdc    0x32    0x54    0x32    0x10    0x32  |    1
  0xfe    0x10    0x76    0x10    0x32    0x10  |    0

This representation meets all the requirements set by 2.2.2.2 and makes 
the reverse-endian interpretation correct as well.

 And the supposedly bizarre physical address adjustment made by the LB, 
etc. pseudocode you refer to merely reflects the fact that (in the 64-bit 
case considered here) sub-doubleword addresses (i.e. the 3 LSBs) are 
presented on the SysAD bus with byte enables rather than via address 
lines.  This is clearly indicated in the description of `LoadMemory' and 
`StoreMemory' pseudocode:

"The low-order 2 (or 3) bits of the address and the AccessLength indicate 
which of the bytes within MemElem need to be passed to the processor."

 So given a 64-bit SysAD bus to load a byte from the bus/memory address 
0x00000000 a 0b00000001 logical bit pattern has to be driven on BE[7:0].  
And that pattern corresponds to CPU's physical address 0x00000000 in the 
native-endian load/store instruction mode, but 0x00000007 in the 
reverse-endian load/store instruction mode, because the doubleword 
location requested is swapped compared to how the memory interface has 
been configured (the `BigEndianMem' setting in the architecture spec).  
Hence the `XOR ReverseEndian' address adjustment made for the 
reverse-endianness mode.  And similarly for other sub-doubleword accesses; 
they'll have a higher number of byte enables asserted accordingly.

 So again, to illustrate, we have a 64-bit value of 0xfedcba9876543210 
stored at the bus/memory address 0x00000000 and will use LB to retrieve 
the byte at that address.  For the big memory interface endianness and a 
native access we have this:

BE:       BE7     BE6     BE5     BE4     BE3     BE2     BE1     BE0
memory:  0x10    0x32    0x54    0x76    0x98    0xba    0xdc    0xfe
           |       |       |       |       |       |       |       |
            \       \       \       \     /       /       /       /
             \       \       \       \   /       /       /       /
              ------------------------\ /------------------------
                                       X
              ------------------------/ \------------------------
             /       /       /       /   \       \       \       \
            /       /       /       /     \       \       \       \
           |       |       |       |       |       |       |       |
buffer:  0xfe    0xdc    0xba    0x98    0x76    0x54    0x32    0x10
pAddr:     0       1       2       3       4       5       6       7

(forgive the inferior ASCII art, I hope the way lanes are swapped is 
clear).  So the byte at pAddr 0 in the buffer corresponds to 0xfe at BE0 
and consequently bus/memory address 0x00000000, as expected.  Now in the 
reverse-endian load/store instruction mode we have the lane swapping 
reconfigured in the memory interface so now things look like this:

BE:       BE7     BE6     BE5     BE4     BE3     BE2     BE1     BE0
memory:  0x10    0x32    0x54    0x76    0x98    0xba    0xdc    0xfe
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
buffer:  0x10    0x32    0x54    0x76    0x98    0xba    0xdc    0xfe
pAddr:     0       1       2       3       4       5       6       7

Of course (on a byte-addressed machine) byte addresses are the same 
regardless of the endianness, so we still want to retrieve the 0xfe byte 
at BE0.  But that now corresponds to pAddr 7!

 For the little-endian memory interface mode things are reversed 
respectively and for the native mode we have:

BE:       BE7     BE6     BE5     BE4     BE3     BE2     BE1     BE0
memory:  0xfe    0xdc    0xba    0x98    0x76    0x54    0x32    0x10
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
           |       |       |       |       |       |       |       |
buffer:  0xfe    0xdc    0xba    0x98    0x76    0x54    0x32    0x10
pAddr:     7       6       5       4       3       2       1       0

and for the reverse-endian one:

BE:       BE7     BE6     BE5     BE4     BE3     BE2     BE1     BE0
memory:  0xfe    0xdc    0xba    0x98    0x76    0x54    0x32    0x10
           |       |       |       |       |       |       |       |
            \       \       \       \     /       /       /       /
             \       \       \       \   /       /       /       /
              ------------------------\ /------------------------
                                       X
              ------------------------/ \------------------------
             /       /       /       /   \       \       \       \
            /       /       /       /     \       \       \       \
           |       |       |       |       |       |       |       |
buffer:  0x10    0x32    0x54    0x76    0x98    0xba    0xdc    0xfe
pAddr:     7       6       5       4       3       2       1       0

-- so again we have to use pAddr 7 to get at BE0/0x10.

 Notice that this physical address adjustment is then cancelled by making 
a reverse `XOR BigEndianCPU' adjustment in calculating the byte offset for 
the sub-doubleword value to extract from the intermediate doubleword 
buffer used by the pseudocode (where `BigEndianCPU' is calculated as 
`BigEndianMem XOR ReverseEndian', as defined by Table 1.1 "Symbols Used in 
Instruction Operation Statements").  So referring to the examples above, 
the leftmost byte is extracted from the buffer in the reverse-endian mode 
rather than the rightmost one as it would in the native mode.  Again, this 
makes things work as intended, and makes any byte stream stored in memory 
endianness-agnostic.

 So I don't exactly know what you did with the Octeon implementation, but 
I do hope you did the sane thing.

  Maciej
