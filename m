Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6JEEwp25367
	for linux-mips-outgoing; Thu, 19 Jul 2001 07:14:58 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6JEEgV25359;
	Thu, 19 Jul 2001 07:14:42 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 9B8AB7F3; Thu, 19 Jul 2001 16:14:40 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 594594626; Thu, 19 Jul 2001 15:29:50 +0200 (CEST)
Date: Thu, 19 Jul 2001 15:29:50 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Daniel Jacobowitz <drow@mvista.com>, Carsten Langgaard <carstenl@mips.com>,
   linux-mips@oss.sgi.com
Subject: Re: Updates on RedHat 7.1/mips
Message-ID: <20010719152950.C2543@paradigm.rfc822.org>
References: <20010718152631.A1809@bacchus.dhis.org> <20010718094841.A24612@nevyn.them.org> <20010719002322.C1669@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010719002322.C1669@bacchus.dhis.org>; from ralf@oss.sgi.com on Thu, Jul 19, 2001 at 12:23:22AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 19, 2001 at 12:23:22AM +0200, Ralf Baechle wrote:
> On Wed, Jul 18, 2001 at 09:48:42AM -0700, Daniel Jacobowitz wrote:
> 
> > Although I'm pretty sure that Debian's Perl package builds without the
> > use of tcsh... I've no idea where this is coming from.
> 
> Anyway, Perl is calling csh internally for something but I forgot what it
> was; too long that I researched the details.

For path globbing perl uses csh or tcsh 

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
