Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQF83c06913
	for linux-mips-outgoing; Mon, 26 Nov 2001 07:08:03 -0800
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQF7uo06909
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 07:07:56 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.9.3/8.9.3) with ESMTP id PAA23894;
	Mon, 26 Nov 2001 15:07:54 +0100
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id PAA11348;
	Mon, 26 Nov 2001 15:07:54 +0100 (MET)
Message-Id: <200111261407.PAA11348@sparta.research.kpn.com>
X-Mailer: exmh version 1.6.5 12/11/95
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>, linux-mips@oss.sgi.com
Subject: Re: FPU interrupt handler 
In-reply-to: Your message of "Mon, 26 Nov 2001 14:50:13 +0100."
             <Pine.GSO.3.96.1011126142508.21598H-100000@delta.ds2.pg.gda.pl> 
Reply-to: vhouten@kpn.com
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Nov 2001 15:07:54 +0100
From: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi Maciej,

>  Hmm, for R3k gcc 2.95.3 + binutils 2.11.2 as available at my site seem to
> be rock solid.
> 
>  For R4k you need binutils 2.11.92, as there is a problem with dla/la
> expansion in the Ulf's patch for .mips3+.  That actually can be fixed in
> 2.11.2 easily but I was going to switch to 2.11.92 anyway, as it has more
> MIPS/Linux support integrated and 2.12 is supposedly soon to be released.
> Unfortunately 2.11.92 is not as stable as 2.11.2 due to generic ELF code
> problems, but I'm trying to track changes and spot a more stable snapshot.

I'm using the RedHat 7.1 packages from oss:
binutils-2.11.92.0.10-1.mips.rpm
gcc-2.96-99.1.mips.rpm


> > Some kernels don't start-up, others hang just before forking init,
> > and all have problems with my serial console.
> 
>  Well, I'm very happy with a /240 running a 2.4.14 snapshot dated
> 20011123.  For a /260 I need a small, but critical bugfix I'm sending to
> the list right now.  I wonder how was it possible for the bug to remain
> uncovered for so long as it's absolutely lethal and often triggered (I've
> only got my /260 recently and it wasn't even running a few minutes
> continuously before the fix). 
My 'main' mips box at home is a /260. I sometimes test things out on
a /240, but I don't have access to other boxes.
 
>  I can't comment other models.
> 
> > When I get a recent kernel running again, I would love to update my
> > DECStation Linux Website with newer instructions and a new root FS.
> 
>  I may upload binaries of my kernels to my site if they are to be useful
> -- they are fully monolithic (but with kmod support) due to historical
> reasons.  Only IPv6 is modular due to its unstability -- it freezes the
> system immediately on my /240 and splashes a bunch of suspicious messages
> on my /260 (weird, but no time to debug).  They only support /240 and /260
> due to CONFIG_CPU_HAS_WB unset.

Yes please. I hope to get a new disk this week, so I can build a
stable development server...

Thanks a lot,


-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
