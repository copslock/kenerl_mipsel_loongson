Received:  by oss.sgi.com id <S553683AbRAUNbG>;
	Sun, 21 Jan 2001 05:31:06 -0800
Received: from [194.73.73.138] ([194.73.73.138]:8075 "EHLO ruthenium")
	by oss.sgi.com with ESMTP id <S553673AbRAUNas>;
	Sun, 21 Jan 2001 05:30:48 -0800
Received: from [213.1.70.188] (helo=tardis)
	by ruthenium with esmtp (Exim 3.03 #83)
	id 14KKZx-0003b1-00; Sun, 21 Jan 2001 13:30:46 +0000
Date:   Sun, 21 Jan 2001 13:27:12 +0000 (GMT)
From:   Dave Gilbert <gilbertd@treblig.org>
X-Sender: gilbertd@tardis.home.dave
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Trying to boot an Indy
In-Reply-To: <20010121023721.D853@bacchus.dhis.org>
Message-ID: <Pine.LNX.4.10.10101211325270.964-100000@tardis.home.dave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, 21 Jan 2001, Ralf Baechle wrote:

> On Sun, Jan 21, 2001 at 02:01:15AM +0000, Dave Gilbert wrote:
> 
> > 2) So I ftp'd the file over under Irix, gzip -d'd it and then rebooted and
> > from sash did boot indyvmlinux - this immediatly after starting gave
> > 'Exception: <vector=UTLB Miss>' plus details (available on request).
> > (This is kernel vmlinux=001027-test9-r4x00.gz off
> > download.ichilton.co.uk/pub/ichilton/linux-mips/kernels).
> > 
> > This is an Indy R4600PC with 64MB RAM.
> 
> You may have become a victim of a sash bug which makes the firmware report
> used memory as free memory and in the end results in the kernel overwriting
> itself.  The solution is easy; don't use sash.  This means you either
> have to boot the kernel via ``bootp() -f ...'' from the network or you
> use IRIX's dvhtool to write it into the volume header, then boot it from
> the kernel prompt by just entering the kernel name.

Well the bootp() stuff still won't respond so that is out, and dvhtool is
saying there isn't enough room for my linux image. Hmph.

Running bootpc under Irix seems to give sensible results.

Is there any other mechanism for loading other than bootp ?

Dave

-- 
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert      | Running GNU/Linux on m68k, |  Happy  \ 
\   gro.gilbert @ treblig.org |  Alpha, x86, ARM and SPARC |  In Hex /
 \ ___________________________|___ http://www.treblig.org  |________/
