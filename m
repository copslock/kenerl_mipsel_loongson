Received:  by oss.sgi.com id <S42332AbQHAX5C>;
	Tue, 1 Aug 2000 16:57:02 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:46386 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42236AbQHAX4a>;
	Tue, 1 Aug 2000 16:56:30 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA20020
	for <linux-mips@oss.sgi.com>; Tue, 1 Aug 2000 16:48:18 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id QAA44641 for <linux-mips@oss.sgi.com>; Tue, 1 Aug 2000 16:54:04 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA33429
	for <linux@engr.sgi.com>;
	Tue, 1 Aug 2000 16:52:32 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03734
	for <linux@engr.sgi.com>; Tue, 1 Aug 2000 16:52:31 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id QAA12032;
	Tue, 1 Aug 2000 16:52:26 -0700
Message-ID: <398762B9.D8507860@mvista.com>
Date:   Tue, 01 Aug 2000 16:52:25 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr, ralf@oss.sgi.com
Subject: PROPOSAL : multi-way cache support in Linux/MIPS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf,

I have got NEC DDB5476 running stable enough that I am comfortable to
check in
my code.  Will you take it?

Assuming the answer is yes, there are several issues regarding checking
in.
I will bring them up one by one.

The first issue is multi-way cache support.  DDB5476 uses R5432 CPU
which
has two-way set-associative cache.  The problematic part is the
index-based cache operations in r4xxcache.h does not cover all ways in a
set.

I think this is a problem in general.  So far I have seen MIPS
processors with
2-way, 4-way and 8-way sets.  And I have seen them using ether least-
significant-addressing-bits or most-significant-addressing-bits
within a cache line to select ways.

Here is my proposal :

. introduce two variables,
        cache_num_ways - number of ways in a set
        cache_way_selection_offset - the offset added to the address to
select
                next cache line in the same set.  For LSBs addressing,
it is
                equal to 1.  For MSBs addressing, it is equal to
                cache_line_size / cache_num_ways.  (It can potentially
take
                care of some future weired way-selection scheme as long
as
                the offset is uniform)

. These variables are initialized in cpu_probe().

  (Alternatively, I think we should have cpu_info table, that contains
all
   these cpu information.  Then a general routine can fill in the based
on
   the cpu id.  This can get rid of a bunch of ugly switch/case
statements.)

. in the include/asm/r4kcache.h file, all Index-based cache operation
needs
  to changed like the following (for illustration only; need
optimization) :

-----
        while(start < end) {
                cache16_unroll32(start,Index_Writeback_Inv_D);
                start += 0x200;
        }
+++++
        while(start < end) {
                for (i=0; i< cache_num_ways; i++) {
                        cache16_unroll32(start +
i*cache_way_selection_offset,
                                         Index_Writeback_Inv_D);
                }
                start += 0x200;
        }
=====

What do you think?  If it is OK, I can do the patch.  The cpu_info table
is a nice wish, but I don't think I know enough to do that job yet.

Jun
