Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7KZVn21983
	for linux-mips-outgoing; Fri, 7 Dec 2001 12:35:31 -0800
Received: from ux11.sp.cs.cmu.edu (UX11.SP.CS.CMU.EDU [128.2.198.38])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7KZSo21980
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 12:35:28 -0800
Received: from GLOVEBOX.AHS.RI.CMU.EDU by ux11.sp.cs.cmu.edu id aa11732;
          7 Dec 2001 14:34 EST
Subject: Re: PATCH: io.h remove detrimental do {...} whiles, add sequence
	points, add const modifiers
From: Justin Carlson <justinca@ri.cmu.edu>
To: jim@jtan.com
Cc: linux-mips@oss.sgi.com
In-Reply-To: <20011207131521.A3942@neurosis.mit.edu>
References: <20011207121416.A9583@dev1.ltc.com>
	<Pine.GSO.4.21.0112071830000.29896-100000@mullein.sonytel.be>
	<20011207123833.A23784@nevyn.them.org>
	<20011207160636.B23798@dea.linux-mips.net> 
	<20011207131521.A3942@neurosis.mit.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 14:36:28 -0500
Message-Id: <1007753789.1680.1.camel@GLOVEBOX.AHS.RI.CMU.EDU>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> So Brad's way allows things that weren't allowed before.  But does
> it break anything that works with the do/while construct?
> 
> You can take care of attempts to use the return type by voiding it:
> 
> #define set_io_port_base(base)		\
> 	(void)(*(unsigned long *)&mips_io_port_base = (base))
> 

Maybe I missed this, but is there any reason for the patch, other then 
a personal preference of how to do macros that look like functions? 
I've seen gcc do strange non-optimal things with functions declared
inlines, but I've never seen it generate bad code WRT to do{}while(0)
constructs.

Unless I'm missing something, this patch looks like a solution in search
of a problem...

-Justin
