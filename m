Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Feb 2009 17:24:27 +0000 (GMT)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:30110 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20809009AbZB1RYY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 28 Feb 2009 17:24:24 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1SHNcCr017887
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 Feb 2009 09:23:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1SHNan3025069;
	Sat, 28 Feb 2009 09:23:36 -0800
Date:	Sat, 28 Feb 2009 09:23:36 -0800 (PST)
From:	Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@localhost.localdomain
To:	Roland McGrath <roland@redhat.com>
cc:	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
In-Reply-To: <20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
Message-ID: <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com> <20090228030413.5B915FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902271932520.3111@localhost.localdomain> <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
 <20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <torvalds@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips



On Fri, 27 Feb 2009, Roland McGrath wrote:
> 
> I don't know any other arch well enough to be sure that TIF_32BIT isn't the
> wrong test there too.  I'd like to leave that worry to the arch maintainers.

Agreed - it may be that others will want to not use TIF_32BIT too. It 
really does make much more sense to have it as a thread-local status flag 
than as an atomic (and thus expensive to modify) thread-flag, not just on 
x86.

But I think other architectures will find it easier to see what's going on 
if the code is straightforward and they can just fix their 
'is_compat_task()' function. And:

> But here is the patch you asked for.

Yes, this looks much more straightforward. 

And I guess the seccomp interaction means that this is potentially a 
2.6.29 thing. Not that I know whether anybody actually _uses_ seccomp. It 
does seem to be enabled in at least Fedora kernels, but it might not be 
used anywhere.

		Linus
