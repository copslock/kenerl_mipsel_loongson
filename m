Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Sep 2002 02:33:17 +0200 (CEST)
Received: from [66.120.210.133] ([66.120.210.133]:43014 "EHLO
	kabul.ad.skymv.com") by linux-mips.org with ESMTP
	id <S1122960AbSIIAdQ> convert rfc822-to-8bit; Mon, 9 Sep 2002 02:33:16 +0200
Received: from kabul.ad.skymv.com ([192.168.1.70]) by kabul.ad.skymv.com with Microsoft SMTPSVC(5.0.2195.5329); Sun, 8 Sep 2002 17:33:00 -0700
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Importance: normal
Priority: normal
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: 64-bit and N32 kernel interfaces - a bit of history
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Date: Sun, 8 Sep 2002 17:33:00 -0700
Message-ID: <A23DE7A325D23B49A76B54080E0BCB9E1B11E5@kabul.skymv.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 64-bit and N32 kernel interfaces
thread-index: AcJVDbqwfYPJa+/sR2+IM9Ia9NnvcgCipNDA
From: "Jeff Broughton" <jeff@keyresearch.com>
To: <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 09 Sep 2002 00:33:00.0542 (UTC) FILETIME=[739279E0:01C25798]
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam.  Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Return-Path: <jeff@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@keyresearch.com
Precedence: bulk
X-list: linux-mips

After the discussion on this list about data type sizes, I asked
Jim Dehnert, who was the person at SGI charged with creating N32, what 
drove them to development N32 in addition to O32 and N64.  Here is his
reply:


Performance was almost all of the reason.  I don't think we ever
quantified it well, but that was partially because we were speculating
about future usage as much as worrying about the present.  I'll try to
dredge up some of the reasons from memory...

Relative to the original 32-bit ABI and what could be done compatibly,
N32 passed FP parameters much more efficiently (because it could do so
in single registers instead of pairs, which I vaguely recall sometimes
even required copies to memory and back), allowed the same for 64-bit
integers, and passed 8 instead of 4 in registers.  We felt that the FP
parameter issues were particularly important in our markets.

A less obvious issue had to do with 64-bit integers and floats in
temporaries across calls.  The old 32-bit ABI defined adequate sets of
callee-saved registers, but of course the standard for save/restore
was just that 32 bits be saved and restored.  That meant fundamentally
that there were _no_ 64-bit callee-saved registers.  Again, this was
not a big problem in most existing code, but we expected it to become
more important, and thought we had just one chance to fix it.  This
may have been more the deciding issue than the parameter-passing ones,
but of course once you decide on anything incompatible, everything
more or less becomes fair game.

The secondary motivation, after performance, was simplicity, on two
levels.  All of the situations I described above can be handled in
the old 32-bit ABI (and in fact they were, though we didn't release
all the capabilities), but it makes parameter passing and temporary
management much more complex.  As a wild guess, I would say that in
the first compiler for the R8000 (our first supported 64-bit
processor, though the R4000 had 64-bit capabilities we didn't support),
which supported the 64-bit ABI and both 32-bit ABIs, at least 3/4 of
the complexity for parameter passing was present just for the 32-bit
ABI, and we didn't even support everything we might have.

The second level was that we needed to be supporting the 64-bit ABI,
and there was never much question in our minds that it needed to be
different.  All of the reasons above apply, with the additional
observation that now 64-bit addresses/pointers are everywhere, so the
issues regarding 64-bit parameters and temporaries are immediately
important.  (Again, an extension of the old 32-bit ABI was defined,
but it was _ugly_.)  Given this, and looking some years into the
future, supporting a 32-bit ABI that was essentially the same except
for data type sizes was a much more attractive prospect than having
two completely incompatible ones.

Now at this point you're thinking, "but I wanted to know why you had
a 32-bit ABI at all instead of just the 64-bit ABI."  So I'll take a
shot at that too.

Again performance was an issue.  Most data is small.  32-bit ints are
adequate almost always, and most programs are small enough that
32-bit pointers are too.  A program compiled with a 32-bit ABI is
generally significantly smaller than one compiled for a 64-bit ABI,
and the difference shows up in cache behavior.  This we did quantify
to some extent, because we had easily comparable ABIs.  Though I don't
recall the real data, I think we found that the average benefit was a
few percent.  Often it was zero, but occasionally it was much larger,
corresponding to programs poised at the cache-size cliff.  So there
was a performance benefit to programs that didn't need the address
space afforded to 64-bit programs, a shrinking but still large
percentage.

But for this case, the more important issue was porting effort.  The
vast majority of existing applications were written for 32-bit ABIs.
Many, even most, are written cleanly enough to be easily ported to a
64-bit ABI.  But there are usually a few issues (e.g. someone saves
a pointer value in an int), and sometimes they are a big deal.  And
it's something customers dread even if it eventually turns out not
to be so bad.  So we believed that we needed to continue to support
a 32-bit ABI even on 64-bit systems, and that its use would continue
to be widespread enough that its performance was still important.
(You probably recall that DEC, which preceded MIPS/SGI by a bit in
the 64-bit world, initially attempted to support only 64-bit software,
but ended up backing off.  So there's evidence besides SGI's biases.)

The downside to each distinct supported ABI was that they fragmented
the available library base (from 3rd-party vendors), since many of them
resisted supporting more than one (or two) ABIs on a platform.  That
turns out to be a significant issue for a company like SGI, and it's
not clear to me in retrospect that the new 32-bit ABI was the right
thing to do overall, though it was clearly technically superior.
There were enough other issues during that period that we'll probably
never be sure.


Anyway, that's the view of the person responsible. Hopefully, a bit of
history can aid the discussion. 

-Jeff Broughton
