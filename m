Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBUMPZT20804
	for linux-mips-outgoing; Sun, 30 Dec 2001 14:25:35 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBUMPWg20801
	for <linux-mips@oss.sgi.com>; Sun, 30 Dec 2001 14:25:32 -0800
Received: from uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA02744
	for <linux-mips@oss.sgi.com>; Thu, 27 Dec 2001 16:14:27 -0800 (PST)
	mail_from (ralf@linux-mips.net)
Received: from eddie (root@eddie.uni-koblenz.de [141.26.4.17])
	by uni-koblenz.de (8.9.3/8.9.3) with SMTP id BAA22818
	for <linux-mips@oss.sgi.com>; Fri, 28 Dec 2001 01:09:25 +0100 (MET)
Received: from dea.linux-mips.net by eddie (SMI-8.6/KO-2.0)
	id BAA18884; Fri, 28 Dec 2001 01:09:23 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBRLrYp01753;
	Thu, 27 Dec 2001 19:53:34 -0200
Date: Thu, 27 Dec 2001 19:53:34 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Signals
Message-ID: <20011227195334.C1553@dea.linux-mips.net>
References: <3C2B0093.3AFC80A9@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C2B0093.3AFC80A9@mips.com>; from carstenl@mips.com on Thu, Dec 27, 2001 at 12:05:55PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 27, 2001 at 12:05:55PM +0100, Carsten Langgaard wrote:

> Why is the signals definition (in include/asm-mips/signal.h) for MIPS
> different from everybody else ?
> For example:
> 
> Hdefine SIGBUS      10    (MIPS)
> Hdefine SIGBUS        7    (I386)
> 
> Hdefine SIGSTKFLT       16   (I386, doesn't exist on MIPS)
> 
> Is there any reason for this ?

Time to read the ABI :-)

  Ralf
