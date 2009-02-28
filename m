Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Feb 2009 07:36:43 +0000 (GMT)
Received: from mx1.redhat.com ([66.187.233.31]:22191 "EHLO mx1.redhat.com")
	by ftp.linux-mips.org with ESMTP id S20808943AbZB1Hgj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Feb 2009 07:36:39 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n1S7a7N9023603;
	Sat, 28 Feb 2009 02:36:07 -0500
Received: from gateway.sf.frob.com (vpn-12-144.rdu.redhat.com [10.11.12.144])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n1S7a7Ka005577;
	Sat, 28 Feb 2009 02:36:08 -0500
Received: from magilla.sf.frob.com (magilla.sf.frob.com [198.49.250.228])
	by gateway.sf.frob.com (Postfix) with ESMTP
	id BE5B6357B; Fri, 27 Feb 2009 23:36:04 -0800 (PST)
Received: by magilla.sf.frob.com (Postfix, from userid 5281)
	id 84F3EFC3DA; Fri, 27 Feb 2009 23:36:04 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Roland McGrath <roland@redhat.com>
To:	Ingo Molnar <mingo@elte.hu>
X-Fcc:	~/Mail/linus
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
In-Reply-To: Ingo Molnar's message of  Saturday, 28 February 2009 08:31:54 +0100 <20090228073154.GG9351@elte.hu>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<20090228073154.GG9351@elte.hu>
Emacs:	the prosecution rests its case.
Message-Id: <20090228073604.84F3EFC3DA@magilla.sf.frob.com>
Date:	Fri, 27 Feb 2009 23:36:04 -0800 (PST)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Return-Path: <roland@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roland@redhat.com
Precedence: bulk
X-list: linux-mips

> btw., shouldnt is_compat_task() expand to 0 in the 
> !CONFIG_COMPAT case? That way we could remove this #ifdef too. 
> (and move the first #ifdef inside the array initialization so 
> that we always have a mode1_syscalls_32[] array.)

I guess you mean define it in linux/compat.h then?
Go right ahead.  Whatever you want is fine by me.


Thanks,
Roland
