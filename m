Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1QIZOB30294
	for linux-mips-outgoing; Tue, 26 Feb 2002 10:35:24 -0800
Received: from dea.linux-mips.net (a1as04-p167.stg.tli.de [195.252.186.167])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1QIZJ930290
	for <linux-mips@oss.sgi.com>; Tue, 26 Feb 2002 10:35:20 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1QHMV725531;
	Tue, 26 Feb 2002 18:22:31 +0100
Date: Tue, 26 Feb 2002 18:22:31 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jay Carlson <nop@nop.com>
Cc: Hartvig Ekner <hartvige@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Setting up of GP in static, non-PIC version of glibc?
Message-ID: <20020226182231.A25493@dea.linux-mips.net>
References: <20020226125532.B7497@dea.linux-mips.net> <E0CB6130-2AC8-11D6-AB38-0030658AB11E@nop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E0CB6130-2AC8-11D6-AB38-0030658AB11E@nop.com>; from nop@nop.com on Tue, Feb 26, 2002 at 09:55:30AM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 26, 2002 at 09:55:30AM -0500, Jay Carlson wrote:

> Right.  In my ideal world, here's how it would work:
> 
> cc1 defaults to -G0.  I think we have that now.
> 
> gas defaults to -G0.  Messing with SUBTARGET_ASM_SPEC has that effect 
> for people who use the gcc driver, but anybody invoking gas directly 
> will still hit this problem, but too bad.
> 
> So I think the primary constituency for gas defaulting to -G8 are 
> existing cygnuhhhh I mean redhat embedded MIPS customers, outside of 
> Linux; that's who we should check with before we change the default.

So far we've been following the MIPS-UNIX tradition more than anything
else.

  Ralf
