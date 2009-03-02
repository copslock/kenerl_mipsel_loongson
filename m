Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Mar 2009 01:44:54 +0000 (GMT)
Received: from mx1.redhat.com ([66.187.233.31]:64708 "EHLO mx1.redhat.com")
	by ftp.linux-mips.org with ESMTP id S21103416AbZCBBow (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 2 Mar 2009 01:44:52 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n221iSZa010435;
	Sun, 1 Mar 2009 20:44:28 -0500
Received: from gateway.sf.frob.com (vpn-13-15.rdu.redhat.com [10.11.13.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n221iRTj003095;
	Sun, 1 Mar 2009 20:44:29 -0500
Received: from magilla.sf.frob.com (magilla.sf.frob.com [198.49.250.228])
	by gateway.sf.frob.com (Postfix) with ESMTP
	id B1AE5357B; Sun,  1 Mar 2009 17:44:23 -0800 (PST)
Received: by magilla.sf.frob.com (Postfix, from userid 5281)
	id 22A6FFC3C6; Sun,  1 Mar 2009 17:44:23 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Roland McGrath <roland@redhat.com>
To:	Linus Torvalds <torvalds@linux-foundation.org>
X-Fcc:	~/Mail/linus
Cc:	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
In-Reply-To: Linus Torvalds's message of  Saturday, 28 February 2009 09:23:36 -0800 <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
X-Fcc:	~/Mail/linus
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Message-Id: <20090302014423.22A6FFC3C6@magilla.sf.frob.com>
Date:	Sun,  1 Mar 2009 17:44:23 -0800 (PST)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Return-Path: <roland@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roland@redhat.com
Precedence: bulk
X-list: linux-mips

> And I guess the seccomp interaction means that this is potentially a 
> 2.6.29 thing. Not that I know whether anybody actually _uses_ seccomp. It 
> does seem to be enabled in at least Fedora kernels, but it might not be 
> used anywhere.

I have no idea who uses it.  I just assume that anyone who is using it
might be expecting it to be reliable for security purposes as advertised.


Thanks,
Roland
