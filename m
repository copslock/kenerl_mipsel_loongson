Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA04662; Wed, 18 Jun 1997 19:08:38 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA23988 for linux-list; Wed, 18 Jun 1997 19:07:54 -0700
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA23976 for <linux@cthulhu.engr.sgi.com>; Wed, 18 Jun 1997 19:07:52 -0700
Received: from localhost (lm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via SMTP id TAA04619; Wed, 18 Jun 1997 19:07:51 -0700
Message-Id: <199706190207.TAA04619@neteng.engr.sgi.com>
To: linux@neteng.engr.sgi.com, os@neteng.engr.sgi.com
Subject: FYI - free Windows API
Date: Wed, 18 Jun 1997 19:07:51 -0700
From: Larry McVoy <lm@neteng.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


------- Forwarded Message

Date:    Wed, 18 Jun 1997 18:59:17 -0700
From:    gordoni@base.com (Gordon Irlam)
To:      achut@eng.sun.com, bruce_horton@hotmail.com, hsu@freebsd.org,
	 corbin@eng.sun.com, gnu@toad.com, lm@sgi.com, willey@purdue.edu,
	 kr@base.com, lpd@aladdin.com, rlm@transmeta.com, deraadt@theos.com,
	 tclayton@eng.sun.com
cc:      FoRK@pest.w3.org
Subject: Willows places Windows API under GNU (Library) GPL

Below is my boring corporatized summary of this.

My uncorporatized analysis is simpler, and reads:

    Fuckin cool!  -  http://www.willows.com/



                                                gordon

--------------------------------------------------------------------

Willows Software has decided to make the sources to their
Windows API technology freely available under the GNU Library GPL.

This is very significant.

Willows technology sounds has a long way to go before it catches
up to Microsoft, but much like the capacity of Linux to overtake
the existing Unix vendors, this possibility shouldn't be ruled
out.  A Linux magnitude net effort to create a free replacement
to Windows could certainly put a bound on Microsoft's ability to
increase the price it starts charging for it's operating systems
now that it thinks it has secured a monopoly.

While this technology is not perfect, it is probably the best
non-Microsoft licensed Windows API technology that presently exists
(alternatives being Wabi from Sun, and Wine written by Bob Amstead
and friends, freely available on the net).  Other technologies, such
as from Bristol, use code licensed by Microsoft.

Willows Software comprises both a set of Windows API compatible libraries
that presently run on top of Unix and Mac, and also an x86 machine code
simulator for running existing x86 binaries.  The option to simply
compile to native code on the appropriate processor also exists.
Only the Win16 API presently appears mature, and a lot of work is still
required to complete the Win32 APIs.  According to an earlier press
release, a lot of work will also be required to implement OLE.

Willows Software is a part of the Canopy Group which is a group of
companies owned by NFT Ventures.  NFT Ventures is run by Ray Norda.
I believe NFT stands for Norda Family Trust.  Another member of the
Canopy Group is Caldera, one of the leading Linux companies.  According
to the Canopy Group's own web site the mission of the Canopy Group is:

    "to enhance and support Novell's products with aggressive strategies
    and technologies"

This suprizes me given that Ray Norda is no longer involved with
Novell (I even checked recent SEC filings by Novell to confirm this).
I don't really understand the relationship between Novell and Willow,
nor whether Eric Schmidt's presence at Novell might also have played
a part in the decision to free the Willows Windows API (Schmidt is
one of the few senior people in the industry that appears to understand
the economic forces associated with free software).

See http://www.willows.com/ for further details, or to download the
complete sources.

A previous article on Willows follows.

                                                    gordon

----------------------------------------------------------------------------

      January 1996 article reporting plans by Willows to make the
      sources to their software freely available on the net, but
      to continue to charge money for it's commercial use.  (The
      new license that was just announced is royalty free)...

Subject: A not-quite-free Windows clone...
Date: Fri, 5 Jan 1996 18:25:15 -0800 (PST)

>From Unigram...

NOORDA's WILLOWS TO PUT ITS WINDOWS-ON-UNIX SOURCE ON TO NET

Fresh from its victory over Microsoft Corp last month at 
ECMA, the European Computer Manufacturers Association (UX No 
569), the tiny Ray Noorda-financed start-up Willows Software 
has changed gears, plowing ahead with a move that is bound 
to irk the mighty Redmond empire. This week it'll detail a 
plan to distribute the source code to its ersatz Win32s 
operating environment, described as a subset of Windows 95, 
free on the Internet. It will also make its anticipated 
software development kit, the Twin Cross Platform Developers 
Kit (XPDK), similarly available for personal use. Noorda 
himself will brief the press. The source code will allow 
users of any flavour of Unix - followed in turn by Apple 
Macintosh, Novell NetWare and ultimately IBM OS/2 users - to 
run Windows binaries, particularly Microsoft's own highly 
popular Word, Excel and PowerPoint programs, on their 
systems. They will not have to pay any operating systems 
"taxes" to Microsoft. 

Saratoga, California-based Willows claims the move will 
create something of a paradigm shift - at least within the 
narrow confines of Unix - and spell the end of Sun 
Microsystems Inc's like-minded but limited product, Wabi, as 
well as Motif. Officially, Wabi only runs two dozen of the 
thousands of Windows programs available and to run some of 
them, like PowerPoint, requires the real Windows underneath, 
defeating one of Sun's purposes - to wit, depriving 
Microsoft of its revenue stream. Willows chief Rob Farnum 
says he will spend the next few weeks lobbying Wabi's 
greatest adherents, Sun and IBM, to abandon Wabi and license 
the Willows solution on favourable terms. He has utter 
confidence such an appeal will succeed and make Willows 
money. (Sun and IBM Corp did after all sit on the ECMA 
technical committee TC37 with Willows pushing the technology 
as a standard.) Farnum never wanted to distribute the source 
code, he says, because Willows doesn't have the financial 
wherewithal to support it. The decision to do it anyway was 
made over the holidays by Microsoft's old nemesis Ray Noorda 
and his henchmen. Farnum now believes that despite the fact 
the source code won't be supported it will attract tens of 
thousands of users. 

Outside interest in Willows technology, he said, has always 
focused almost exclusively on its ability to run binaries. 
It is unclear whether Noorda will also try to tie it in 
somehow with the Linux freeware-based Corsair Internet 
desktop his Caldera operation is pushing. Willows is also 
now willing to forego carving out what it estimates would be 
a modest little $10m business selling its XPDK toolkit to a 
couple of thousand Unix developers a year. Any real money to 
be made, it figures, lies in what it calls "professional 
services," porting applications for people with its 
technology or helping them port them. It intends to announce 
such a program this week. It also intends to announce 
licensing schemes whereby pieces of its technology can be 
bundled with third-party programs. 

Willows will support its technology when applied to 
commercial purposes and apparently charge modest licensing 
fees of $250 a platform despite the number of developers 
using it or run-times created. Farnum claims that when 
Willows this week announces the imminent arrival of its XPDK 
for the Mac - which like its NetWare kit is at the alpha 
stage - it will bring pressure to bear on Microsoft's new 
$1,600 Visual C++ tool for the platform. Still he remains 
diffident, or perhaps cautious, about Willows impact on 
Microsoft - at one point calling it "mouse nuts" - and 
Microsoft's reaction to Willows' moves. He apparently 
expects Microsoft to denigrate Willows technology out of a 
perceived loss of control, loss of revenue and threat to 
Win95. At the same time, he admits it would take Willows 50 
man-years just to catch up with Microsoft's OLE work which 
he knows he must emulate. Farnum leaves unarticulated or 
unadmitted - despite direct questions - Willows long-term 
purposes respecting Microsoft though perhaps he and Noorda 
now feel they will make more daunting foes by using the 
Internet to evolve their schemes. 

------- End of Forwarded Message
