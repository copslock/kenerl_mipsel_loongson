Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jul 2004 10:46:30 +0100 (BST)
Received: from mx1.redhat.com ([IPv6:::ffff:66.187.233.31]:3781 "EHLO
	mx1.redhat.com") by linux-mips.org with ESMTP id <S8224916AbUG0JqZ>;
	Tue, 27 Jul 2004 10:46:25 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i6R9kMe1008195;
	Tue, 27 Jul 2004 05:46:22 -0400
Received: from localhost (mail@vpnuser5.surrey.redhat.com [172.16.9.5])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i6R9kLa11419;
	Tue, 27 Jul 2004 05:46:21 -0400
Received: from rsandifo by localhost with local (Exim 3.35 #1)
	id 1BpOXM-0002Rh-00; Tue, 27 Jul 2004 10:46:20 +0100
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix gcc-3.4.x compilation
References: <200407261237.09965.thomas.koeller@baslerweb.com>
From: Richard Sandiford <rsandifo@redhat.com>
Date: Tue, 27 Jul 2004 10:46:20 +0100
In-Reply-To: <200407261237.09965.thomas.koeller@baslerweb.com> (Thomas
 Koeller's message of "Mon, 26 Jul 2004 12:37:09 +0200")
Message-ID: <87fz7dvl3n.fsf@redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rsandifo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rsandifo@redhat.com
Precedence: bulk
X-list: linux-mips

Thomas Koeller <thomas.koeller@baslerweb.com> writes:
> Since the meaning of 'accum' used to be 'hi' and 'lo', all its uses
> were clearly redundant.

For the record, that isn't quite true.  GCC internally treated
"accum" as an entirely separate register (which is why it became
such a headache).  In theory, if you have an instruction that
clobbers lo and hi, but doesn't clobber "accum", gcc might think
that a value in "accum" will still be valid.

Richard
