Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49J47d05667
	for linux-mips-outgoing; Wed, 9 May 2001 12:04:07 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49J43F05663;
	Wed, 9 May 2001 12:04:03 -0700
Received: from cotw.com (dhcp-050.inter.net [192.168.10.50])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id OAA27355;
	Wed, 9 May 2001 14:04:02 -0500
Message-ID: <3AF997CE.E2885B9@cotw.com>
Date: Wed, 09 May 2001 14:17:34 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre17-idepci i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Andreas Jaeger <aj@suse.de>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Florian Lohoff <flo@rfc822.org>, Tom Appermont <tea@sonycom.com>,
   linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
References: <Pine.GSO.3.96.1010509144913.2489C-100000@delta.ds2.pg.gda.pl> <ho7kzqd5kb.fsf@gee.suse.de> <20010509150934.B2073@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> It's only modutils which for correct functionality depends on the trad-
> format, so I don't see any real reason for raising version requirements
> for libc.
> 
I can see your point...but...if we are trying fix the MIPS/Linux target
from this point forward we should at least make people aware of what
is going on. I propose spitting out a warning message when 'configure'
is ran that if an older version of binutils/ld is found, then we warn
the user that they may be unable to correctly use Linux kernel features
or something like that. Comments?

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
