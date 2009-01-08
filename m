Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2009 20:57:10 +0000 (GMT)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:3496 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S21365037AbZAHU5I (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Jan 2009 20:57:08 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n08Kv08T031699
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Jan 2009 12:57:01 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n08Kux7v032239;
	Thu, 8 Jan 2009 12:56:59 -0800
Date:	Thu, 8 Jan 2009 12:56:59 -0800 (PST)
From:	Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@localhost.localdomain
To:	David Daney <ddaney@caviumnetworks.com>
cc:	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] cpumask fallout: Initialize irq_default_affinity
 earlier.
In-Reply-To: <496666CE.3050205@caviumnetworks.com>
Message-ID: <alpine.LFD.2.00.0901081256170.3283@localhost.localdomain>
References: <1231446081-8448-1-git-send-email-ddaney@caviumnetworks.com> <alpine.LFD.2.00.0901081227360.3283@localhost.localdomain> <496666CE.3050205@caviumnetworks.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <torvalds@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips



On Thu, 8 Jan 2009, David Daney wrote:
> 
> The 'inline' seems gratuitous to me.  Since it is static GCC should do 
> the Right Thing.  However since you suggested it, I am testing it that 
> way.

Trust me, gcc very seldom does the Right Thing(tm) when it comes to 
inlining. 

			Linus
