Received:  by oss.sgi.com id <S553838AbQJNQJo>;
	Sat, 14 Oct 2000 09:09:44 -0700
Received: from chmls06.mediaone.net ([24.147.1.144]:58052 "EHLO
        chmls06.mediaone.net") by oss.sgi.com with ESMTP id <S553831AbQJNQJn>;
	Sat, 14 Oct 2000 09:09:43 -0700
Received: from decoy (h00a0cc39f081.ne.mediaone.net [24.218.248.129])
	by chmls06.mediaone.net (8.8.7/8.8.7) with SMTP id MAA08609;
	Sat, 14 Oct 2000 12:09:41 -0400 (EDT)
From:   "Jay Carlson" <nop@nop.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>, "Jay Carlson" <nop@place.org>
Cc:     <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>,
        "Mike Klar" <mfklar@ponymail.com>
Subject: RE: stable binutils, gcc, glibc ...
Date:   Sat, 14 Oct 2000 12:11:38 -0400
Message-ID: <KEEOIBGCMINLAHMMNDJNEECBCAAA.nop@nop.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20001014170928.B6499@bacchus.dhis.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle writes:

> On Sat, Oct 14, 2000 at 10:51:37AM -0400, Jay Carlson wrote:
>
> > Hey, don't blame me for the 2.0.6->2.0.7 version bump.  I just
> grabbed the
> > biggest version number on oss.sgi.com at the time and made my *trivial*
> > patches to add softfloat to the build.
> >
> > Let me say that again: 2.0.7 is NOT MY FAULT.
>
> I didn't blame you - I didn't even know how came up with
> 2.0.7-mips.  When I
> receive bug reports against the various 2.0.7 incarnations I just usually
> find that they're that particular 2.0.7 version has bugs which were fixed
> eternities ago.

Yeah.  You weren't blaming me, and I don't think Jun was blaming me, but my
name was attached to 2.0.7, and I wanted to escape....

> 2.0.7 as used by the distributors is probably a reasonably sane libc.

See, another naming issue...

> Do your softfp patches somehow cause problems with hardware fp machines?
> If not we could throw all things together.

No, no problems at all.  They're just conditional on __HAVE_FPU__.  Consider
ftp://ftp.place.org/pub/nop/linuxce/glibc-2.0.7-mips-softfloat.patch
submitted for the 2.0.6 branch.

I'm not really the head toolchain builder for linux-vr these days---Mike
Klar has a set of unified patches he's been working on.

> Actually I'm trying to kill this entire naming problem by getting all
> patches back to the respective maintainers.  Result:  no pending patches
> for cvs binutils, only tiny ones for glibc-current and egcs-current.

Yes.  This is very good.  This reduces the problem by one dimension---the
unique specification of a source version can be reduced to a date
(preferably the exact date you give to cvs checkout).  Given success
reports, other people can come along behind you and build tarballs and RPMs
given just that information.

Speaking of egcs-current---I hadn't looked at it in some time.  It appears
not to multilib for softfloat.

Could somebody who already has signatures on file with the FSF add multilib
softfloat for mips-linux targets?  I mean, we (linux-vr) *think* we're going
to be switching over to the FP emulator soon, but it hasn't happened yet.
Adding multilib is pretty harmless---I can't think of how it could screw up
the build for hardfp machines.

The biggest reason I can think of *not* to make such a change is because
there are already plans in the works to create a mipselnofp-linux target to
more closely describe the situation.  But I don't see any momentum behind
it, and I'd rather have either multilib or mipselnofp than the default case
of "linux-vr must ship patches and maintain separate .debs and .rpms that
contain a proper superset of mainline functionality".

> Naming the patches is a nice idea but frequently I find my own patches
> again on some server with creativly changed names.  There is just nobody
> who controls the namespace for those patches.

True :-(  We do have the big hammer of linuxmips.org/linux-mips.org as a way
of handing out namespace if people actually want to cooperate on naming.

Jay
