Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Mar 2003 07:24:43 +0000 (GMT)
Received: from web41511.mail.yahoo.com ([IPv6:::ffff:66.218.93.94]:44394 "HELO
	web41511.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225073AbTCIHYm>; Sun, 9 Mar 2003 07:24:42 +0000
Message-ID: <20030309072432.19644.qmail@web41511.mail.yahoo.com>
Received: from [81.218.92.190] by web41511.mail.yahoo.com via HTTP; Sat, 08 Mar 2003 23:24:32 PST
Date: Sat, 8 Mar 2003 23:24:32 -0800 (PST)
From: Tinga Shilo <tingashilo@yahoo.com>
Subject: Re: static variables access and gp
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
In-Reply-To: <20030306094034.A26071@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <tingashilo@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tingashilo@yahoo.com
Precedence: bulk
X-list: linux-mips

Thx. Got it.
Any other solution to speed up the access to this
variable ? It's location never changes from kernel
init to shutdown if I haven't made that clear.

--- Jun Sun <jsun@mvista.com> wrote:
> On Wed, Mar 05, 2003 at 11:30:17PM -0800, Tinga
> Shilo wrote:
> > Hi,
> > I am implementing a kernel mechanism which is 
> > very performance oriented. Along my long critical
> > path,
> > there is a static variable that needs to be
> accessed
> > quite a few times. This variable is a structure
> which
> > is approximately 60 bytes big.
> > In there any way I can "convince" my kernel
> (compiled
> > with gcc) to access this variable using gp ?
> > Is gp usually used for this purpose in mips-linux
> ?
> > Can it be ?
> >
> 
> No.  gp is used by kernel to hold current process in
> 2.4
> and current thread in 2.5.  Don't mess with it
> unless
> you are absolutely sure what you are doing.
> 
> Jun


__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - forms, calculators, tips, more
http://taxes.yahoo.com/
