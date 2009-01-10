Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jan 2009 05:11:34 +0000 (GMT)
Received: from ozlabs.org ([203.10.76.45]:11197 "EHLO ozlabs.org")
	by ftp.linux-mips.org with ESMTP id S21103489AbZAJFLb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 10 Jan 2009 05:11:31 +0000
Received: from vivaldi.localnet (unknown [150.101.102.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPSA id 6D9AADE0B4;
	Sat, 10 Jan 2009 16:11:26 +1100 (EST)
From:	Rusty Russell <rusty@rustcorp.com.au>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] cpumask fallout: Initialize irq_default_affinity earlier.
Date:	Sat, 10 Jan 2009 15:41:13 +1030
User-Agent: KMail/1.10.3 (Linux/2.6.27-9-generic; KDE/4.1.3; i686; ; )
Cc:	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
References: <1231446081-8448-1-git-send-email-ddaney@caviumnetworks.com> <496666CE.3050205@caviumnetworks.com> <alpine.LFD.2.00.0901081256170.3283@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.0901081256170.3283@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901101541.15192.rusty@rustcorp.com.au>
Return-Path: <rusty@rustcorp.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rusty@rustcorp.com.au
Precedence: bulk
X-list: linux-mips

On Friday 09 January 2009 07:26:59 Linus Torvalds wrote:
> 
> On Thu, 8 Jan 2009, David Daney wrote:
> > 
> > The 'inline' seems gratuitous to me.  Since it is static GCC should do 
> > the Right Thing.  However since you suggested it, I am testing it that 
> > way.
> 
> Trust me, gcc very seldom does the Right Thing(tm) when it comes to 
> inlining. 
> 
> 			Linus

Note that there's a downside: with inline funcs in .c files you don't get
a warning should they become unused in future cleanups.

Cheers,
Rusty.
