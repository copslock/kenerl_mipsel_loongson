Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0M1GSA19941
	for linux-mips-outgoing; Mon, 21 Jan 2002 17:16:28 -0800
Received: from cygnus.com (runyon.sfbay.redhat.com [205.180.230.5] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0M1GKP19936;
	Mon, 21 Jan 2002 17:16:21 -0800
Received: from myware.mynet (fiendish.sfbay.redhat.com [205.180.231.146])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id QAA21566;
	Mon, 21 Jan 2002 16:16:10 -0800 (PST)
Received: (from drepper@localhost)
	by myware.mynet (8.11.6/8.11.6) id g0M0G9H24788;
	Mon, 21 Jan 2002 16:16:09 -0800
X-Authentication-Warning: myware.mynet: drepper set sender to drepper@redhat.com using -f
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: "Ralf Baechle" <ralf@oss.sgi.com>, "Mike Uhler" <uhler@mips.com>,
   <linux-mips@oss.sgi.com>, "H . J . Lu" <hjl@lucon.org>
Subject: Re: thread-ready ABIs
References: <m3elkoa5dw.fsf@myware.mynet> <20020118101908.C23887@lucon.org>
	<01b801c1a081$3f6518e0$0deca8c0@Ulysses>
	<20020119162415.B31028@dea.linux-mips.net>
	<m3d703thl6.fsf@myware.mynet> <01be01c1a2d7$6ec299c0$0deca8c0@Ulysses>
Reply-To: drepper@redhat.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 21 Jan 2002 16:16:09 -0800
In-Reply-To: <01be01c1a2d7$6ec299c0$0deca8c0@Ulysses>
Message-ID: <m3zo37s0ja.fsf@myware.mynet>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (asparagus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Kevin D. Kissell" <kevink@mips.com> writes:

> As MIPS "owns" the ABI, whether or not the thread register
> becomes a part of it is not something that anyone outside
> of MIPS can simply decree.

Well, MIPS might define the "official" ABI but nobody is forced to use
it and if nobody uses it it's nor worth anything.

> I'd very much appreciate it if someone would explain to me just what
> this register is used for, and why a register needs to be permantly
> allocated for this purpose.

Simply look at the ABIs for some less-backward processors.  Read the
thread-local storage section in the IA-64 ABI specification.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
