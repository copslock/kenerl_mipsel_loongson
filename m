Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2003 20:12:53 +0000 (GMT)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:57559 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8226378AbTAMUMw>;
	Mon, 13 Jan 2003 20:12:52 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h0DKCW67018435;
	Mon, 13 Jan 2003 12:12:32 -0800 (PST)
Received: from uhler-linux.mips.com (uhler-linux [192.168.11.222])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA07246;
	Mon, 13 Jan 2003 12:12:30 -0800 (PST)
Received: from uhler-linux.mips.com (uhler@localhost)
	by uhler-linux.mips.com (8.11.2/8.9.3) with ESMTP id h0DKCS631737;
	Mon, 13 Jan 2003 12:12:28 -0800
Message-Id: <200301132012.h0DKCS631737@uhler-linux.mips.com>
X-Authentication-Warning: uhler-linux.mips.com: uhler owned process doing -bs
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Mike Uhler <uhler@mips.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
cc: uhler@mips.com
Reply-To: uhler@mips.com
Subject: Re: unaligned load in branch delay slot 
In-reply-to: Your message of "Mon, 13 Jan 2003 19:04:36 +0100."
             <Pine.GSO.4.21.0301131901500.21279-100000@vervain.sonytel.be> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Jan 2003 12:12:28 -0800
From: "Mike Uhler" <uhler@mips.com>
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips


> 
> Thanks!
> 
> The following patch (against linux-mips-2.4.x CVS) cures my crash.
> 
> I don't know on which CPUs this may happen (need #ifdef CONFIG_CPU_VR41XX?),
> nor whether all branch and jump instructions are affected (I included
> everything that starts with a `b' or `j').

Since all MIPS jumps are unconditional, one can never have a non-taken
jump, so you can eliminate those from the patch.

/gmu

-- 

  =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
  Michael Uhler, VP, Systems, Architecture, and Software Products 
  MIPS Technologies, Inc.   Email: uhler@mips.com   Pager: uhler_p@mips.com
  1225 Charleston Road      Voice:  (650)567-5025   FAX:   (650)567-5225
  Mountain View, CA 94043   Mobile: (650)868-6870   Admin: (650)567-5085
