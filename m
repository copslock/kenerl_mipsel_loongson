Received:  by oss.sgi.com id <S42435AbQIFFtr>;
	Tue, 5 Sep 2000 22:49:47 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:9719 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42305AbQIFFtd>;
	Tue, 5 Sep 2000 22:49:33 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id WAA09387;
	Tue, 5 Sep 2000 22:48:43 -0700
Message-ID: <39B5DABB.7FB85B09@mvista.com>
Date:   Tue, 05 Sep 2000 22:48:43 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-fbdev@vuser.vu.union.edu, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: mmap() frame buffer causes bus error on MIPS ...
References: <39B5BD14.A8D2F467@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Jun Sun wrote:
> 
> With the help from Attila, I got the latest tdfx framebuffer driver
> working on my NEC DDB5476 board.   I have console working based on this
> driver.
> 
> However, when I try to mmap frame buffer into user land, the mapping is
> succesful, but trying to read the buffer causes a bus error.
> 
> I tried to trace the kernel using gdb.  fb_mmap() seems to do the right
> thing :
> 
> 1) it calls fb->fb_get_fix() to get the buffer address, size, etc.  The
> values all look fine.  The address is physical address, pointing a
> mapped PCI memory block.  I verified that I can access that address in
> gdb.
> 
> 2) for MIPS, fb_mmap() turns off CACHE bit for the page.
> 
> I would imagine when the app tries to read the buffer, a TLB miss is
> generated.  TLB refill routine probably sets up the right TLB entry, and
> the app will try to read again, and get the content.  I really can't
> think of where the Bus error might occur.
> 
> Does anybody have a clue here?  Thanks a lot.
> 
> Jun

Did more probing on this.  It appears the TLB entry that gets filled is
not right, even though the original page entry is generated correctly. 
See below TLB dump.

The original page table still has the same value (not corrupted), and
the only explanation is that tlb_refill actually gets the entry from a
wrong place.  I then tried to decode tlb_refill code but really got lost
there.  (Is there an explanation about the page table setup?)

How could this be? Maybe the pte's are put in the wrong place to begin
with?  Ralf, please help ...

Jun

P.S., even though tlb entry is wrong, it does not explain the bus error,
because the wrong tlb entry does point to a physical memory area.  Hmm,
more questions ...

----------------

dump tlb for 0x2ac3d000 :
Entry 37 maps address 0x2ac3d000
Index: 37 pgmask=00000000 va=2ac3c000 asid=0000007b  [pa=000000 c=0 d=0
v=0 g=0]  [pa=2300000 c=2 d=0 v=1 g=0]
dump all tlb :
Index:  4 pgmask=00000000 va=2abbc000 asid=0000007b  [pa=0ff000 c=3 d=0
v=1 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 10 pgmask=00000000 va=7fffe000 asid=0000007b  [pa=000000 c=0 d=0
v=0 g=0]  [pa=0f2000 c=3 d=1 v=1 g=0]
Index: 11 pgmask=00000000 va=10052000 asid=0000007b  [pa=000000 c=0 d=0
v=0 g=0]  [pa=0f0000 c=3 d=1 v=1 g=0]
Index: 30 pgmask=00000000 va=00424000 asid=0000007b  [pa=0f0000 c=3 d=0
v=1 g=0]  [pa=0f0000 c=3 d=0 v=1 g=0]

------------------

Where the pte's are :

(gdb) x/32 0x83ca30f0
0x83ca30f0:     0x00000000      0x8c00048f      0x8c001407     
0x8c002407
0x83ca3100:     0x8c003407      0x8c004407      0x8c005407     
0x8c006407
0x83ca3110:     0x8c007407      0x8c008407      0x8c009407     
0x8c00a407
0x83ca3120:     0x8c00b407      0x8c00c407      0x8c00d407     
0x8c00e407
0x83ca3130:     0x8c00f407      0x8c010407      0x8c011407     
0x8c012407
0x83ca3140:     0x8c013407      0x8c014407      0x8c015407     
0x8c016407
0x83ca3150:     0x8c017407      0x8c018407      0x8c019407     
0x8c01a407
0x83ca3160:     0x8c01b407      0x8c01c407      0x8c01d407     
0x8c01e407
