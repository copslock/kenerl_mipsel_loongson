Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2007 04:25:45 +0100 (BST)
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57732 "EHLO
	smtp2.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20021520AbXFTDZm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Jun 2007 04:25:42 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5K3PYRf017852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 Jun 2007 20:25:35 -0700
Received: from box (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l5K3PNmb027048;
	Tue, 19 Jun 2007 20:25:28 -0700
Date:	Tue, 19 Jun 2007 20:25:23 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org,
	Brian Oostenbrink <Brian_Oostenbrink@pmc-sierra.com>,
	Dan Doucette <Dan_Doucette@pmc-sierra.com>
Subject: Re: [PATCH 7/12] drivers: PMC MSP71xx GPIO char driver
Message-Id: <20070619202523.b0a2f9f0.akpm@linux-foundation.org>
In-Reply-To: <4678748B.8090403@pmc-sierra.com>
References: <4678748B.8090403@pmc-sierra.com>
X-Mailer: Sylpheed 2.4.1 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Tue, 19 Jun 2007 17:27:55 -0700 Marc St-Jean <Marc_St-Jean@pmc-sierra.com> wrote:

> Andrew Morton wrote:
> > On Fri, 15 Jun 2007 14:46:03 -0600
> > Marc St-Jean <stjeanma@pmc-sierra.com> wrote:
> > 
> >  > [PATCH 7/12] drivers: PMC MSP71xx GPIO char driver
> >  >
> >  > Patch to add a GPIO char driver for the PMC-Sierra MSP71xx devices.
> > 
> 
> >  > ...
> >  >
> >  > +/* Maps 'basic' pins to relative offset from 0 per register */
> >  > +static int const MSP_GPIO_OFFSET[] = {
> >  > +     /* GPIO 0 and 1 on the first register */
> >  > +     0, 0,
> >  > +     /* GPIO 2, 3, 4, and 5 on the second register */
> >  > +     2, 2, 2, 2,
> >  > +     /* GPIO 6, 7, 8, and 9 on the third register */
> >  > +     6, 6, 6, 6,
> >  > +     /* GPIO 10, 11, 12, 13, 14, and 15 on the fourth register */
> >  > +     10, 10, 10, 10, 10, 10,
> >  > +};
> > 
> > This shouldn't be in a header file.  Because each compilation unit which
> > includes this header will (potentially) get its own copy of the data.
> > 
> > That includes any userspace apps which include this header(!)
> 
> There are other drivers which use these macros irrespective of the char
> driver being compiled in or not. I can't move this to the driver .c file
> as all the macros will become useless.

In that case this storage should be placed into a separate .c file which
the others can link against.  Creating a separate copy of this table
per-driver is bad practice.

> > inlined functions are preferred over macros.  Only use macros when for some
> > reason you *must* use macros.
> 
> Even for simple macros that have a single +, - or << ?

Sure, why not?  There's rarely any reason to use macros.

> I thought there was an advantage to using macros, allowing the compiler to
> combine a series of simple macro calls into a single constant.

It will easily do that with inlines too.
