Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2003 19:34:05 +0000 (GMT)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:451 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8226063AbTAHTeE>;
	Wed, 8 Jan 2003 19:34:04 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h08JXH67023968;
	Wed, 8 Jan 2003 11:33:17 -0800 (PST)
Received: from uhler-linux.mips.com (uhler-linux [192.168.11.222])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA15398;
	Wed, 8 Jan 2003 11:33:01 -0800 (PST)
Received: from uhler-linux.mips.com (uhler@localhost)
	by uhler-linux.mips.com (8.11.2/8.9.3) with ESMTP id h08JX1F09754;
	Wed, 8 Jan 2003 11:33:01 -0800
Message-Id: <200301081933.h08JX1F09754@uhler-linux.mips.com>
X-Authentication-Warning: uhler-linux.mips.com: uhler owned process doing -bs
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Dominic Sweetman <dom@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
cc: uhler@mips.com
Reply-To: uhler@mips.com
Subject: Re: [patch] Use XKPHYS for 64-bit TLB flushes 
In-reply-to: Your message of "Wed, 08 Jan 2003 20:18:46 +0100."
             <Pine.GSO.3.96.1030108200826.7872A-100000@delta.ds2.pg.gda.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Jan 2003 11:33:01 -0800
From: "Mike Uhler" <uhler@mips.com>
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips


> 
>  They do are different: KSEG0+entry*0x2000, likewise for XKPHYS -- see the
> patch. 

This is precisely what we use for our internal testing (which is also
exported to MIPS32 and MIPS64 architecture licensees) to initialize the
TLB.  I have not yet seen a case where this fails, and would be interested
in hearing about any case where it does fail.

/gmu

-- 

  =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
  Michael Uhler, VP, Systems, Architecture, and Software Products 
  MIPS Technologies, Inc.   Email: uhler@mips.com   Pager: uhler_p@mips.com
  1225 Charleston Road      Voice:  (650)567-5025   FAX:   (650)567-5225
  Mountain View, CA 94043   Mobile: (650)868-6870   Admin: (650)567-5085
