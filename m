Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2003 01:30:04 +0100 (BST)
Received: from p508B5EC1.dip.t-dialin.net ([IPv6:::ffff:80.139.94.193]:49342
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225204AbTDWAaD>; Wed, 23 Apr 2003 01:30:03 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3N0Trm10084;
	Wed, 23 Apr 2003 02:29:53 +0200
Date: Wed, 23 Apr 2003 02:29:53 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: Jeff Baitis <baitisj@evolution.com>,
	Pete Popov <ppopov@mvista.com>, linux-mips@linux-mips.org,
	Matthew Dharm <mdharm@momenco.com>
Subject: Re: Improperly handled case in arch/mips/au1000/common/time.c
Message-ID: <20030423022953.B5843@linux-mips.org>
References: <20030422125450.E10148@luca.pas.lab> <20030422155625.E28544@mvista.com> <20030423010727.A8410@linux-mips.org> <20030422161338.H28544@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030422161338.H28544@mvista.com>; from jsun@mvista.com on Tue, Apr 22, 2003 at 04:13:38PM -0700
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 22, 2003 at 04:13:38PM -0700, Jun Sun wrote:

> If we were going to get rid of CONFIG_OLD_TIME_C, I propose
> to make CONFIG_NEW_TIME_C as the default and therefore removed as well.
> And make other boards using private time_init() functions to use 
> CONFIG_HAVE_PRIVATE_TIME. 
> 
> ... in the spirit of encouraging code sharing. :)

That's basically the old situation again, just in disguise this time.  In
practice I fear that's going to be used to keep inferior copies of some
code alive so let's see if we can avoid it.

  Ralf
