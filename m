Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 01:57:35 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:28422 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133658AbWCAB5Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 01:57:24 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 5C09F64D3D; Wed,  1 Mar 2006 02:05:09 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 153A381F5; Wed,  1 Mar 2006 03:04:38 +0100 (CET)
Date:	Wed, 1 Mar 2006 02:04:38 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Re: Non-fatal oops on SGI IP22 when doing: md5sum /dev/mem
Message-ID: <20060301020438.GA22131@deprecation.cyrius.com>
References: <20060228114137.GA3087@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228114137.GA3087@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-02-28 11:41]:
> I get the following non-fatal oops on SGI IP22 (2.6.16-rc5) when
> running "md5sum /dev/mem".  I know it's not very smart to run this
> command but nevertheless we shouldn't oops.  FWIW, i386 reports
> "md5sum: /dev/mem: Bad address".

Right, so we had a fun discussion about this on IRC today... The
bottom line is that the kernel cannot to anything about it and root
should know what they're doing.


12:39 < ladis> tbm: you cannot read from /dev/mem randomly ;-)
12:46 < tbm> ladis: yeah, but my point is that it shouldn't oops/segfault
12:48 < ladis> tbm: Well, you acessed GIO space and MC asserted BERR interrupt. That's pretty valid behaviour.
12:50 < tbm> ladis: a oops and segfault doesn't seem like valid behaviour from the perspective of an end user.  Why cannot it catch such an access and return "Bad address" like i386 does
12:51 < p2-mate> tbm: if you do hw access in userland, you're on your own :)
12:53 < tbm> p2-mate: I still maintain that an oops is not an acceptable behaviour from a user POV
12:56 < Bacchus> tbm: I'm missing some context here - what is oopsing?
12:57 < p2-mate> tbm: rm /dev/mem
12:57 < p2-mate> tbm: problem solved :)
12:57 < tbm> p2-mate: so why does /dev/mem exist in the first place...
12:57 < tbm> Bacchus: print a traceback
12:57 < p2-mate> tbm: otherwise the X server does not work
12:58 < Bacchus> tbm: Doesn't work very well but I've never seen a traceback oopsing.
12:59 < tbm> well, isn't this thing called an oops?  Or what's the right terminiology?
12:59 < tbm> Data bus error, epc == ffffffff881b0cf0, ra == ffffffff881c9ab4
12:59 < tbm> Oops[#8]:
12:59 < tbm> Cpu 0
12:59 < tbm> $ 0   : 0000000000000000 0000000000000004 ffffffff80090000 0000000000000000
12:59 < tbm> $ 4   : 00000000100023a8 ffffffff80090000 0000000000001000 ffffffff8a6dfe88
12:59 < tbm> ..
12:59 < tbm> Call Trace:
12:59 < tbm>  [<ffffffff880902bc>] vfs_read+0xfc/0x1b8
12:59 < tbm> ..
12:59 < ladis> p2-mate: That's problem of bloody crappy random number generator in xdm
12:59 < ladis> tbm: Right, it is Data bus error and I implemented it ;-)
12:59 < tbm> p2-mate: right, but my point is that the file is there and so it can be expected that some users try to read it
13:00 < Bacchus> Okay - and a DBE when doing what?
13:00 < tbm> so either we shouldn't ship the file, or we should handle reading from it gracefully
13:00 < p2-mate> tbm: well, perhapd it should not be there ?
13:00 < ladis> tbm: There was long debate about acesing /dev/mem on debian-mips archive few years ago
13:00 < tbm> Bacchus: doing "md5sum /dev/mem"
13:00 < ladis> tbm: search for xdm
13:00 < p2-mate> BERR is imprecise ?
13:00 < Bacchus> tbm: You're kidding?
13:00 < tbm> Bacchus: which may be a stupid thing, but still shouldn't oops and segfault
13:00 < ladis> tbm: It *will* always segfault on certain machines
13:01 < tbm> so why does i386 manage to produce a nice "Bad address" error?
13:01 < tbm> why is that not possible on mips?
13:01 < Bacchus> tbm: FOr this operation even formatting your hard disk would be ok.
13:01 < geoman> heh, I can confirm the oops on 2.6.16-rc4
13:01 < ladis> aiiie ;-)
13:01 < tbm> Bacchus: well, that's what i disagree with.  If /dev/mem is so dangerous, it shouldn't exist.
13:02 < Bacchus> Welcome to UNIX :)
13:02 < ladis> tbm: No. It is very powerfull. And only root can cope with that...
13:02 < ladis> tbm: Remember userspace drivers
13:03 < geoman> hmm, speaking of display managers and oopses
13:03 < Bacchus> tbm: /dev/mem gives free access to any and all devices in the system just like the kernel.  No safety net.
13:03 < ladis> tbm: And even removing /dev/mem doesn't prevent you from writing program that does mmap
13:03 < geoman> I seem to recall that wdm causes a non-fatal oops on ip22
13:04 < geoman> perhaps it is related
13:04 < ladis> geoman: sure it is
13:05 < ladis> display managers authors are insane i386 centric idiots thinking that reading enough /dev/mem gives you enough randomness for security purposes
13:05 < ladis> I never got this point...
13:05 < Bacchus> tbm: And yes, there are many that argue that /dev/mem should be deprecated.
13:11 < geoman> yep, wdm causes an identical oops
13:12 < tbm> ok, at least my O2 boots again
13:13 < tbm> anyway, I do agree with you that /dev/mem is dangerous and that root should know what they're doing
13:13 < tbm> however, the tiny bit I don't understand is that if the kernel manages to recognize this wrong access and issue a BERR, why cannot it simply return an error to the userland program
13:13 < tbm> but anyway, I guess there are more important things to worry about
13:14 < geoman> well, my understanding is that the kernel should never oops
13:15 < Bacchus> tbm: By the time we receive a bus error we're dead in the water.  Game over.  Tilt.  Insert coin to continue ;-)
13:18 < geoman> heh, doing "md5sum /dev/mem" on my O2 doesn't return any error at all
13:18 < geoman> I think it is really trying to take the md5sum of all that random crud ;)
13:19 < Bacchus> A bus error just doesn't have enough knowledge about what went wrong, aside of a few
                 carefully controlled scenarios like hw probing.
...
13:37 < Bacchus> geoman: So how does wdm trigger it?
13:38 < ladis> Bacchus: Read above
13:38 < ladis> Bacchus: <ladis> display managers authors are insane i386 centric idiots thinking that
               reading enough /dev/mem gives you enough randomness for security purposes
13:39 < Bacchus> ladis: Eh...  You meant you were serious?!?
13:39 < ladis> Bacchus: They are indeed doing that.
13:39 < ths> Bacchus: Sure. Wdm dies on my Indy.
13:39 < geoman> Bacchus: by simply tring to start it
13:39 < ladis> ...and the reason is above..
13:48  * Bacchus googles for wdm ...
13:50 < Bacchus> Btw, wtf does wdm work for non-root then?
13:50 < geoman> nope
13:51 < geoman> if you try to run it non-root, it returns a message that "Only root wants to run wdm"
13:55 < ladis> Bacchus: http://lists.debian.org/debian-mips/2002/08/msg00060.html
13:55 < ladis> Bacchus: That's start of pretty nice discussion. Read on your own risc ;-)

-- 
Martin Michlmayr
http://www.cyrius.com/
