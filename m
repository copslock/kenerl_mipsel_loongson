Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2003 20:38:00 +0100 (BST)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:39103 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225205AbTDJTh4>;
	Thu, 10 Apr 2003 20:37:56 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h3AJbkUe015552;
	Thu, 10 Apr 2003 12:37:46 -0700 (PDT)
Received: from uhler-linux.mips.com (uhler-linux [192.168.11.222])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA00407;
	Thu, 10 Apr 2003 12:37:48 -0700 (PDT)
Received: from uhler-linux.mips.com (uhler@localhost)
	by uhler-linux.mips.com (8.11.2/8.9.3) with ESMTP id h3AJbl211418;
	Thu, 10 Apr 2003 12:37:47 -0700
Message-Id: <200304101937.h3AJbl211418@uhler-linux.mips.com>
X-Authentication-Warning: uhler-linux.mips.com: uhler owned process doing -bs
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Ralf Baechle <ralf@linux-mips.org>
cc: Mike Uhler <uhler@mips.com>, Jun Sun <jsun@mvista.com>,
	linux-mips@linux-mips.org
cc: uhler@mips.com
Reply-To: uhler@mips.com
Subject: Re: way selection bit for multi-way cache 
In-reply-to: Your message of "Thu, 10 Apr 2003 21:24:30 +0200."
             <20030410212430.A519@linux-mips.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 Apr 2003 12:37:47 -0700
From: "Mike Uhler" <uhler@mips.com>
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

> On Thu, Apr 10, 2003 at 11:50:53AM -0700, Mike Uhler wrote:
> 
> > I can't comment on anything but MIPS32 and MIPS64 CPUs, but the
> > MIPS32 and MIPS64 standard is to use the bits above the index field
> > to specify the way.  See the figure entitled "Usage of Address Fields
> > to Select Index and Way" in the CACHE instruction description of the
> > MIPS32 and MIPS64 Architecture for Programmer's manuals.
> 
> The question came up between Jun and me when revising the way of handling
> multi-way caches.  There is the MIPS32 / MIPS64 way of selecting the
> cache way - but that scheme was originally already introduced by the
> R4600.  The second somewhat less common scheme is using the lowest bits
> of the address.  That was originally introduced with the R10000 but a
> few other processors such as the R5432 and the TX49 series are using it
> as well.  Unfortunately there has been way to much creativity (usually
> a positive property but ...) among designers so this posting is an
> attempt to achieve completeness.
> 
>   Ralf

Exactly why we made it a standard in MIPS32 and MIPS64.
-- 

  =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
  Michael Uhler, VP, Systems, Architecture, and Software Products 
  MIPS Technologies, Inc.   Email: uhler@mips.com   Pager: uhler_p@mips.com
  1225 Charleston Road      Voice:  (650)567-5025   FAX:   (650)567-5225
  Mountain View, CA 94043   Mobile: (650)868-6870   Admin: (650)567-5085
