Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Sep 2002 00:36:04 +0200 (CEST)
Received: from father.pmc-sierra.bc.ca ([216.241.224.13]:35062 "HELO
	father.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S1122958AbSIFWgD>; Sat, 7 Sep 2002 00:36:03 +0200
Received: (qmail 4883 invoked by uid 104); 6 Sep 2002 22:35:53 -0000
Received: from Manoj_Ekbote@pmc-sierra.com by father with qmail-scanner-1.00 (uvscan: v4.1.40/v4218. . Clean. Processed in 0.51649 secs); 06 Sep 2002 22:35:53 -0000
Received: from unknown (HELO hymir.pmc-sierra.bc.ca) (134.87.114.120)
  by father.pmc-sierra.bc.ca with SMTP; 6 Sep 2002 22:35:52 -0000
Received: from bby1exi01.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by hymir.pmc-sierra.bc.ca (jason/8.11.6) with ESMTP id g86MZqw13439;
	Fri, 6 Sep 2002 15:35:52 -0700 (PDT)
Received: by bby1exi01 with Internet Mail Service (5.5.2653.19)
	id <P6AX15DL>; Fri, 6 Sep 2002 15:37:40 -0700
Message-ID: <71690137A786F7428FF9670D47CB95ED18AD48@SJE4EXM01>
From: Manoj Ekbote <Manoj_Ekbote@pmc-sierra.com>
To: "'Matthew Dharm'" <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: RE: LOADADDR and low physical addresses?
Date: Fri, 6 Sep 2002 15:35:25 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Manoj_Ekbote@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Manoj_Ekbote@pmc-sierra.com
Precedence: bulk
X-list: linux-mips


-----Original Message-----
From: Matthew Dharm [mailto:mdharm@momenco.com]
Sent: Friday, September 06, 2002 2:13 PM
To: Jun Sun
Cc: Linux-MIPS
Subject: RE: LOADADDR and low physical addresses?


Yes, the having two devices at the same physical address might be a
problem, but one I _might_ be able to work around.  Not only do I have
a large bank of SDRAM, but I also have a small bank of on-chip SRAM.

So I'm thinking that the map will go (starting from 0) like this:
on-chip SRAM, control registers, main memory

And this is where I think the add_memory_region() magic might need to
happen.  Do I need to add the on-chip SRAM and control registers using
add_memory_region()?  


--I am pretty sure you don't have to do that.You just need to tell Linux 
--where the main memory starts at.

Manoj
