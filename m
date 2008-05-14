Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2008 02:03:43 +0100 (BST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57573 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20030512AbYENBDk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 May 2008 02:03:40 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4E12U9o031051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 13 May 2008 18:02:31 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m4E12Pdx009236;
	Tue, 13 May 2008 18:02:27 -0700
Date:	Tue, 13 May 2008 18:02:25 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH RESEND] [MIPS]: multi-statement if() seems to be missing
 braces
Message-Id: <20080513180225.194f400b.akpm@linux-foundation.org>
In-Reply-To: <20080513232507.GA24102@linux-mips.org>
References: <Pine.LNX.4.64.0805131444360.15369@wrl-59.cs.helsinki.fi>
	<20080513232507.GA24102@linux-mips.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Wed, 14 May 2008 00:25:07 +0100 Ralf Baechle <ralf@linux-mips.org> wrote:

> On Tue, May 13, 2008 at 02:50:50PM +0300, Ilpo J__rvinen wrote:
> 
> > In case this is a genuine bug, somebody else more familiar
> > with that stuff should evaluate it's effects (I just found it
> > by some shell pipeline and it seems suspicious looking).
> 
> Should be fairly as proven by practice; it's there since day of of 64-bit
> pagetable for 32-bit hw support which was November 29, 2004.
> 

It's unlikely that anyone would notice an error in pte_mkyoung().  It
will affect page reclaim behaviour and _might_ be demonstrable with a
carefully set up test.  But an error in here won't cause crashes or
lockups or anything.

What this needs is someone who understands the architecture (ie: you
;)) to take a look, please.
