Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2003 19:51:21 +0100 (BST)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:50619 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225205AbTDJSvM>;
	Thu, 10 Apr 2003 19:51:12 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h3AIosUe015186;
	Thu, 10 Apr 2003 11:50:54 -0700 (PDT)
Received: from uhler-linux.mips.com (uhler-linux [192.168.11.222])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA27842;
	Thu, 10 Apr 2003 11:50:53 -0700 (PDT)
Received: from uhler-linux.mips.com (uhler@localhost)
	by uhler-linux.mips.com (8.11.2/8.9.3) with ESMTP id h3AIorK11089;
	Thu, 10 Apr 2003 11:50:53 -0700
Message-Id: <200304101850.h3AIorK11089@uhler-linux.mips.com>
X-Authentication-Warning: uhler-linux.mips.com: uhler owned process doing -bs
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Jun Sun <jsun@mvista.com>
cc: linux-mips@linux-mips.org
Reply-To: uhler@mips.com
Subject: Re: way selection bit for multi-way cache 
In-reply-to: Your message of "Thu, 10 Apr 2003 11:05:27 PDT."
             <20030410110527.E9002@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 Apr 2003 11:50:53 -0700
From: "Mike Uhler" <uhler@mips.com>
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

> 
> If a cache is multi-way set associative cache, one must
> select the way for indexed cache operations.
> 
> The most common way selection is to use MSBs in the addressing
> range of the whole cache size.  In other word, a two-way
> cache of size d would use bit (log(d)-1) to select the way.
> 
> Some other CPUs often the LSB(s) in the address to select
> ways.  Examples include R5432, R5500, TX49, TX39.  Does
> anybody know other such CPUs?
> 
> And I think I have seen a third kind way selection, but I
> can't remember which CPU it is.  Does anybody know any
> other way selection schemes?
> 
> Thanks.
> 
> Jun
> 

I can't comment on anything but MIPS32 and MIPS64 CPUs, but the
MIPS32 and MIPS64 standard is to use the bits above the index field
to specify the way.  See the figure entitled "Usage of Address Fields
to Select Index and Way" in the CACHE instruction description of the
MIPS32 and MIPS64 Architecture for Programmer's manuals.

/gmu

-- 

  =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
  Michael Uhler, VP, Systems, Architecture, and Software Products 
  MIPS Technologies, Inc.   Email: uhler@mips.com   Pager: uhler_p@mips.com
  1225 Charleston Road      Voice:  (650)567-5025   FAX:   (650)567-5225
  Mountain View, CA 94043   Mobile: (650)868-6870   Admin: (650)567-5085
