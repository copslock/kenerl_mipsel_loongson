Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5DEGRO03023
	for linux-mips-outgoing; Wed, 13 Jun 2001 07:16:27 -0700
Received: from ocs4.ocs-net (firewall.ocs.com.au [203.34.97.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5DEGNP03004;
	Wed, 13 Jun 2001 07:16:23 -0700
Received: from ocs4.ocs-net (kaos@localhost)
	by ocs4.ocs-net (8.11.2/8.11.2) with ESMTP id f5DE7Cs10109;
	Thu, 14 Jun 2001 00:07:12 +1000
X-Authentication-Warning: ocs4.ocs-net: kaos owned process doing -bs
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@melbourne.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Ralf Baechle <ralf@oss.sgi.com>, Florian Lohoff <flo@rfc822.org>,
   Raoul Borenius <borenius@shuttle.de>, linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays) 
In-reply-to: Your message of "Wed, 13 Jun 2001 15:44:28 +0200."
             <Pine.GSO.3.96.1010613153740.9854H-100000@delta.ds2.pg.gda.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Jun 2001 00:07:12 +1000
Message-ID: <10108.992441232@ocs4.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 13 Jun 2001 15:44:28 +0200 (MET DST), 
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
> The point is whether addresses should be extended at all if a 32-bit
>target is selected.  IMHO -- not ...
> I'm not sure we need to work it around in ksymoops until BFD is fixed --
>`cut -c8- < System.map' works as a charm.

ksymoops also reads the output from nm and objdump internally, it is
just a little difficult to run cut -c8- on that data ;).
