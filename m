Received:  by oss.sgi.com id <S554130AbRA0H1u>;
	Fri, 26 Jan 2001 23:27:50 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:46845 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553804AbRA0H1g>;
	Fri, 26 Jan 2001 23:27:36 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id IAA29682;
	Sat, 27 Jan 2001 08:28:05 +0100 (MET)
Date:   Sat, 27 Jan 2001 08:28:05 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Joe deBlaquiere <jadb@redhat.com>, Florian Lohoff <flo@rfc822.org>,
        linux-mips@oss.sgi.com
Subject: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
In-Reply-To: <20010126131503.H869@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010127082028.29150B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 26 Jan 2001, Ralf Baechle wrote:

> Afaik the only user of MIPS_ATOMIC_SET ever running on Linux/MIPS is the
> Linuxthreads code you wrote, so no.  Aside of that the semantics of this
> syscall were defined by older MIPS operating systems such as Risc/OS and
> I think we should follow their example.

 I still haven't seen a definite spec for the call.  Since you suggest the
Linuxthreads code is the only user of the code (also remember the
_test_and_set library function as specified by the ABI), we might abandon
MIPS_ATOMIC_SET and write a _test_and_set syscall instead.  No
compatibility issues would be involved and the definition is clear in the
ABI (the library function would become a simple wrapper). 

 I'm still uncertain if wasting a syscall number is that great idea, but
we would be free from any compatibility problems.  And yes, I still think
an ll/sc emulation could be done independently anyway. 

 Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
