Received:  by oss.sgi.com id <S42247AbQFJSID>;
	Sat, 10 Jun 2000 11:08:03 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:9221 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42199AbQFJSHt>;
	Sat, 10 Jun 2000 11:07:49 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id LAA17718;
	Sat, 10 Jun 2000 11:07:22 -0700
Date:   Sat, 10 Jun 2000 11:07:22 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
Cc:     "J. Scott Kasten" <jsk@tetracon-eng.net>,
        Linux-MIPS Mailing List <linux-mips@oss.sgi.com>
Subject: Re: Linux on Indy
Message-ID: <20000610110722.A17647@chem.unr.edu>
References: <Pine.SGI.4.10.10006092319540.2700-100000@thor.tetracon-eng.net> <NAENLMKGGBDKLPONCDDOIEEGCMAA.mailinglist@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <NAENLMKGGBDKLPONCDDOIEEGCMAA.mailinglist@ichilton.co.uk>; from mailinglist@ichilton.co.uk on Sat, Jun 10, 2000 at 05:20:08PM +0100
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Jun 10, 2000 at 05:20:08PM +0100, Ian Chilton wrote:

> Jumping ahead a bit...when I get hardhat running, can I download the source
> for all the updated pacages, like GCC 2.95.2, GLIBC 2.1.3 and make, binutils
> etc etc, and compile them from source like you can with Linux on a PC, or
> won't that work with this platform?

You cannot use glibc 2.1 on mips. I'm pretty sure gcc 2.95.2 doesn't
work either. EGCS 1.1.2 with patches works mostly ok, as does 2.96
from cvs. Binutils, flip a coin. The 000425 snapshot works fine for me
with a patch you can get from oss.sgi.com or ftp.foobazco.org.
Somebody reported that they had 000524 mostly working as well.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
