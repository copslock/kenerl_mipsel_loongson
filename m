Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2003 21:17:52 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:24327 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225205AbTDJURv>;
	Thu, 10 Apr 2003 21:17:51 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP
	id 8350FB56B; Thu, 10 Apr 2003 22:17:46 +0200 (CEST)
Message-ID: <3E95D16D.1671BA5A@ekner.info>
Date: Thu, 10 Apr 2003 22:17:49 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: ext3 under MIPS?
References: <3E954651.C7AECB90@ekner.info> <20030410154050.GI5242@lug-owl.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

Jan-Benedict Glaw wrote:

> >
> > So can somebody tell me what the heck just happened? After the ext3 recovery done before the mount,
> > .autofsck is still on the disk, so the rc.sysinit script of course assumes the shutdown was unclean,
>
> This ".autofsck" file seems to be a userland approach to detect a system
> which wasn't shutted down completely. Even this is fine. What's *not*
> okay is that there are still errors remaining. It seems your filesystem
> has been damaged before (and in no means which could have been handled
> by the journal).
>
> > and pops the 5-second question. However, if I to be safe push "Y" here to get my filesystem check (which
> > I guess should be unnecessary, due to the ext3 recovery just run, right?), strange things happen and
> > fsck reports the "corrupted orphan list... " error.
>
> Wrong. The journal should prevent you from actually loosing things at
> hard-power-off situations. It does *not* cover things like silent data
> corruption, which may have lead to this breakage.
>
> > Is there something wrong here, or how should the system behave?
>
> Everything with journal recovery is fine here. The failing fsck is a
> different problem (a journal doesn't preven you to do a fsck at a
> regular basis. It's only to not be forced to to it if you don't have the
> time to do this *now* (on crash)).
>
> So there seems do be some corruption (caused by whatever) going on at
> your system:-(
>
> Watch out if this happens again soon after you've completed the fsck.
>

I can reproduce this anytime by just pushing the reset button and checking the filesystem
at reboot after ext3 recovery has run. However, if I just do regular fsck's (without unclean
shutdowns) nothing seems to be wrong. So I am pretty sure it is something which
goes wrong in conjunction with the unclean shutdowns.

Is ext3 journal recovery really supposed to recover everything to a state where fsck returns no
errors, or is it potentially leaving non-fatal errors in the filesystem (e.g. lost inodes which just
reduces capacity, but does not cause further corruption if the filesystem is used) which will then
be picked up by a later fsck when one has time to run it?

What does the error "Inodes that were part of a corrupted orphan linked list found." actually
mean? Is this a fatal error, or a non-critical error along the lines I described above (an error
which does not get any worse if the filesystem is used)?

Is there anybody with ext3 up and running who would volunteer to do a couple of unclean
shutdowns and see if the recovery works without any fsck errors present afterwards?

/Hartvig
