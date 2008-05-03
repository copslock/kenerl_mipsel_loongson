Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2008 19:41:08 +0100 (BST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:31920 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S28791051AbYECSlA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 3 May 2008 19:41:00 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m43IeKJ0001044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 May 2008 11:40:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m43IeIqL026803;
	Sat, 3 May 2008 11:40:19 -0700
Date:	Sat, 3 May 2008 11:40:18 -0700 (PDT)
From:	Linus Torvalds <torvalds@linux-foundation.org>
To:	Ulrich Drepper <drepper@redhat.com>
cc:	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2] unify sys_pipe implementation
In-Reply-To: <200805031801.m43I109q032242@devserv.devel.redhat.com>
Message-ID: <alpine.LFD.1.10.0805031138450.5994@woody.linux-foundation.org>
References: <200805031801.m43I109q032242@devserv.devel.redhat.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <torvalds@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips



On Sat, 3 May 2008, Ulrich Drepper wrote:
> 
> Some arch maintainers might want to take a look at their remaining
> special versions.  The cris version, for instance, only differs from
> the generic version in that it takes the BKL.  Is this still needed
> these days?

No, definitely not.

That said, I think that in order to not break other architectures, and to 
make it even easier to do this transformation, how about we just mark the 
generic version with __weak?

That way, odd architectures can just continue to call their own versions 
"sys_pipe()", and we don't break them unnecessarily.

		Linus
