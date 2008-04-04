Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2008 08:41:41 +0200 (CEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36517 "EHLO
	smtp1.linux-foundation.org") by lappi.linux-mips.net with ESMTP
	id S525092AbYDDGlg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 4 Apr 2008 08:41:36 +0200
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m346euVd013763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 3 Apr 2008 23:40:57 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m346Yejc009935;
	Thu, 3 Apr 2008 23:34:40 -0700
Date:	Thu, 3 Apr 2008 23:34:40 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alchemy: move UART platform code to its proper place
Message-Id: <20080403233440.9b920466.akpm@linux-foundation.org>
In-Reply-To: <20080404062924.GA12086@linux-mips.org>
References: <200804040002.53757.sshtylyov@ru.mvista.com>
	<20080404062924.GA12086@linux-mips.org>
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
X-archive-position: 18803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Fri, 4 Apr 2008 07:29:25 +0100 Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Apr 04, 2008 at 12:02:53AM +0400, Sergei Shtylyov wrote:
> 
> > Move the code registering the Alchemy UART platform devices from drivers/serial/
> > to its proper place, into the Alchemy platform code.  Fix the related Kconfig
> > entry, while at it...
> > 
> > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > 
> > ---
> > Ralf, could you take this patch thru your queue -- it ahould apply atop of my
> > former #include /extern cleanup?
> > 
> > I don't know how the platform code ended up accepted into the serial drivers in
> > the first place -- it's high time to amend this.
> 
> Andrew, I'd like to queue this patch, ok?

Sure..
