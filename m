Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 20:36:41 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:59077 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225253AbTCGUgk>;
	Fri, 7 Mar 2003 20:36:40 +0000
Received: (qmail 11800 invoked by uid 6180); 7 Mar 2003 20:36:37 -0000
Date: Fri, 7 Mar 2003 12:36:37 -0800
From: Jeff Baitis <baitisj@evolution.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Kernel Debugging on the DBAu1500
Message-ID: <20030307123637.Y20129@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <20030306185345.W20129@luca.pas.lab> <1047043427.30914.432.camel@zeus.mvista.com> <1047043677.6389.436.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1047043677.6389.436.camel@zeus.mvista.com>; from ppopov@mvista.com on Fri, Mar 07, 2003 at 05:27:58AM -0800
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Pete wrote wrote:
> > Take a look at the board and remind me if the second serial port is
> > actually uart2, where the first is uart0. 
Pete wrote:
> Sorry, I meant uart3, which would be a reason why the UART2_ADDR define
> below wouldn't work.

Hrm. The DBAu1500 seems to lock up when I execute:
    echo "please, no freeze" > /dev/ttyS2
I can't even get SysRq to work after that command.

/dev/ttyS3 works fine, though.

> > I think it might be. If that's
> > the case, arch/mips/au1000/common/dbg_io.c has this define if kgdb is
> > defined:
> > 
> > #define DEBUG_BASE  UART2_ADDR

I changed it to:
#define  DEBUG_BASE  UART3_ADDR

Debugging seems to work great now! Thanks!


-JB


-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
