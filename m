Received:  by oss.sgi.com id <S42210AbQGMPH0>;
	Thu, 13 Jul 2000 08:07:26 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:58892 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42205AbQGMPHB>;
	Thu, 13 Jul 2000 08:07:01 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id HAA28484
	for <linux-mips@oss.sgi.com>; Thu, 13 Jul 2000 07:59:40 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id KAA20284; Thu, 13 Jul 2000 10:58:48 -0300
Date:   Thu, 13 Jul 2000 10:58:48 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Keith M Wesolowski <wesolows@foobazco.org>
cc:     linux-mips@oss.sgi.com
Subject: Re: Simple Linux/MIPS 0.2b
In-Reply-To: <20000713001601.A27565@foobazco.org>
Message-ID: <Pine.SGI.4.10.10007131037590.20247-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On Thu, 13 Jul 2000, Keith M Wesolowski wrote:
> Simple Linux/MIPS 0.2b ``Death on a Stick'' has been released.

Fantastic!  I've had great success with release 0.1 on an Indy.  Perhaps
it's almost too stable for my blood.  Need to go play with fire!  ;-)

Actually, I do have a question for any of you that have been doing builds.
I seem to be having some interesting problems with shared object
libraries.  I'm using S-L-M 0.1 on an Indy as a development/test bed for
code that will eventually end up in an embedded vrXXXX system.  (I've
already verified that the binaries are portable.)  However, I am having
difficulty on the Indy itself.  NONE of the shared objects that I build on
that box can be used by programs on that box.  Yes, I either placed them
in /lib or /usr/lib or built a proper ld.so.cache file for them.  The ldd
utility can resolve the libraries, etc...  However, every program built
on that box against libraries that I built on that box exits with an
immediate bus error.  It appears to be an issue with the libraries
themselves.  If I scavenge the equivalent libraries from the Hard Hat 5.1
distro and drop them in place, everything seems happy and works fine.
Thus, there's something funky about the so's I'm building myself.

I've tried building the XFree 4.0.1 libraries, Lesstiff libraries, and
libraries from our own code base.  All breaks the same way.

#1 What form of black magic are you guys using to do this?

#2 Are there specific compiler flags/phases that should/shouldn't be used
with MIPS arch so's that are different than what I'd normally do under
Linux?

#3 Should I be trying to cross compile the so's them selves instead of
native builds?

#4 Are you using different flavors of gcc/binutils to do different jobs
because of known breakages?

Any tips appreciated here.  In the mean, I'm going to start playing with
flags.

Sincerely,

-JSK-
