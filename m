Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2003 19:03:36 +0100 (BST)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:21995 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225211AbTEOSDe>;
	Thu, 15 May 2003 19:03:34 +0100
Received: (qmail 25263 invoked by uid 6180); 15 May 2003 18:03:30 -0000
Date: Thu, 15 May 2003 11:03:30 -0700
From: Jeff Baitis <baitisj@evolution.com>
To: Lyle Bainbridge <lyle@zevion.com>
Cc: 'Linux MIPS mailing list' <linux-mips@linux-mips.org>
Subject: Re: Power On Self Test and testing memory
Message-ID: <20030515110330.C5897@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <000001c31a8b$c3406720$0a01a8c0@RADIUM> <000001c31aef$9b2624a0$0a01a8c0@RADIUM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000001c31aef$9b2624a0$0a01a8c0@RADIUM>; from lyle@zevion.com on Thu, May 15, 2003 at 09:38:07AM -0500
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Oh yeah, I forgot about that!  I feel very stupid right now.

Thanks for the help!


-Jeff


On Thu, May 15, 2003 at 09:38:07AM -0500, Lyle Bainbridge wrote:
> 
> 
> > Where is does your stack start?  Seems to me that your
> > stack pointer might start at around 0x80010000 and of
> 
> I meant 0xa0010000 (kseg1).  Of course that is still physically
> at 0x80010000.
> 
> 

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
