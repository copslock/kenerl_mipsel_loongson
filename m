Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6UJJjRw001277
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Jul 2002 12:19:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6UJJjhp001276
	for linux-mips-outgoing; Tue, 30 Jul 2002 12:19:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms3.broadcom.com (mms3.broadcom.com [63.70.210.38])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6UJJWRw001266
	for <linux-mips@oss.sgi.com>; Tue, 30 Jul 2002 12:19:32 -0700
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS-3 SMTP Relay (MMS v4.7)); Tue, 30 Jul 2002 12:20:58 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id MAA26197; Tue, 30 Jul 2002 12:20:58 -0700 (PDT)
Received: from dt-sj3-118.sj.broadcom.com (dt-sj3-118 [10.21.64.118]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 g6UJKwER027935; Tue, 30 Jul 2002 12:20:58 -0700 (PDT)
Received: (from cgd@localhost) by dt-sj3-118.sj.broadcom.com (
 8.9.1/SJ8.9.1) id MAA22509; Tue, 30 Jul 2002 12:20:57 -0700 (PDT)
To: dant@mips.com
cc: "Carsten Langgaard" <carstenl@mips.com>, hjl@lucon.org,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com,
   binutils@sources.redhat.com
Subject: Re: PATCH: Update E_MIP_ARCH_XXX (Re: [patch] linux: RFC:
 elf_check_arch() rework)
References: <3D44F31D.55155E24@mips.com>
 <Pine.LNX.4.44.0207301606350.31951-100000@coplin18.mips.com>
 <mailpost.1028038253.3155@news-sj1-1>
From: cgd@broadcom.com
Date: 30 Jul 2002 12:20:57 -0700
In-Reply-To: dant@mips.com's message of
 "Tue, 30 Jul 2002 14:10:53 +0000 (UTC)"
Message-ID: <yov5n0s9koo6.fsf@broadcom.com>
X-Mailer: Gnus v5.7/Emacs 20.4
MIME-Version: 1.0
X-WSS-ID: 115838901176872-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-3.7 required=5.0 tests=IN_REP_TO,NO_REAL_NAME,PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

At Tue, 30 Jul 2002 14:10:53 +0000 (UTC), "Dan Temple" wrote:
> I've now heard a bit of the history from Nigel at Algorithmics, and
> to summarize, they chose the 6 and 7 values for MIPS32/64 after
> Cygnus, who were also producing a MIPS32/64 toolchain, had chosen
> these. (Algor had originally used the value of 5 for MIPS32, but had
> to changed when both SGI (who assigned it to something else) and
> Cygnus chose otherwise). Hence ARCH_ALGOR_32.

Uh, i believe i've seen a snapshot of the Cygnus MIPS32/64 toolchain
you describe.  It was described to me as an "alpha" snapshot.  I have
no reason to believe it was ever released as a commercial-quality
product.

I've made an inquiry, and my understanding is that Cygnus/RedHat
internally use the same values as the public tools
(i.e. EF_MIPS_ARCH_MIPS32 == 5, ..._MIPS64 == 6).


> My personal take on this is that the two main commercial providers
> (Cygnus and Algor) of MIPS32/64-capable GNU toolchains have been
> using 6 & 7 for quite a while,

As noted above, at least for Cygnus, I believe this assertion is
not correct.


> SGI "agree",

with the current master binutils sources.  8-)

As noted in the message:

	http://sources.redhat.com/ml/binutils/2002-07/msg00681.html

SGI is using the same values as the master public GNU binutils,
i.e. MIPS32 == 5, MIPS64 == 6.  It sounds like it wouldn't hurt them
much to switch, but following your suggestion _would_ involve them
switching.


> and that this is quite a
> precedent.

The precedent that I see here is:

* the public master GNU tool sources use EF_MIPS_ARCH_32 == 5,
  EF_MIPS_ARCH_64 == 6.

* Cygnus/RedHat uses those same values.

* SGI also uses those same values.

* A fair number of other GNU tool or OS support houses have also
  picked up those values and use them.

* Algorithmics uses different values.  The meaning of their 'ALGOR_32'
  arch value hasn't been mentioned here, I don't know what it is.
  But, given that everybody else uses the values that the current GNU
  tools do, well, they should probably provide some backward
  compatibility for their users if they want it, and switch.  (Heck, I
  don't even know that 'ALGOR_32' should be different than '32' to
  begin with.)


> Hopefully the ABI process will soon shake any other
> issues out too.

Indeed.  I look forward to seeing a published ABI proposal.

I strongly encourage you to announce the proposal to other groups than
just the Linux MIPS folks, by the way.  For instance, NetBSD is likely
to want to adopt the same ABI for MIPS platforms, and it would be good
if they were able to participate in the process as well.  I'd
recommend contacting <port-mips@netbsd.org> (the NetBSD/mips
platform-independent development list), and specifically Simon Burge
<simonb@wasabisystems.com> who I believe personally has an interest in
this stuff.


cgd
--
Chris Demetriou                                            Broadcom Corporation
Senior Staff Design Engineer                  Broadband Processor Business Unit
  Any opinions expressed in this message are mine, not necessarily Broadcom's.
