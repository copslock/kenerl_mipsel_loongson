Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2009 20:18:55 +0100 (BST)
Received: from one.firstfloor.org ([213.235.205.2]:40786 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025597AbZEHTSs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2009 20:18:48 +0100
Received: from basil.firstfloor.org (p5B3CB324.dip0.t-ipconnect.de [91.60.179.36])
	by one.firstfloor.org (Postfix) with ESMTP id B7E321AB0002;
	Fri,  8 May 2009 21:23:43 +0200 (CEST)
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id 5A6F31D0286; Fri,  8 May 2009 21:18:44 +0200 (CEST)
To:	=?iso-8859-1?Q?Markus_Gutschke_=28=DC=D2=D0=29?= 
	<markus@google.com>
Cc:	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Roland McGrath <roland@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
From:	Andi Kleen <andi@firstfloor.org>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
	<904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
	<20090506212913.GC4861@elte.hu>
	<904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
	<20090506215450.GA9537@elte.hu>
	<904b25810905061508n6d9cb8dbg71de5b1e0332ede7@mail.gmail.com>
Date:	Fri, 08 May 2009 21:18:44 +0200
In-Reply-To: <904b25810905061508n6d9cb8dbg71de5b1e0332ede7@mail.gmail.com> (Markus Gutschke's message of "Wed, 6 May 2009 15:08:40 -0700")
Message-ID: <878wl7o12j.fsf@basil.nowhere.org>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <andi@firstfloor.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andi@firstfloor.org
Precedence: bulk
X-list: linux-mips

"Markus Gutschke (мва)" <markus@google.com> writes:
>
> There are a large number of system calls that "normal" C/C++ code uses
> quite frequently, and that are not security sensitive. A typical
> example would be gettimeofday().

At least on x86-64 gettimeofday() (and time(2)) work inside seccomp because 
they're vsyscalls that run in ring 3 only.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
