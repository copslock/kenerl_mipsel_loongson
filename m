Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5DBkdp15302
	for linux-mips-outgoing; Wed, 13 Jun 2001 04:46:39 -0700
Received: from ocs4.ocs-net (firewall.ocs.com.au [203.34.97.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5DBkXP15285;
	Wed, 13 Jun 2001 04:46:34 -0700
Received: from ocs4.ocs-net (kaos@localhost)
	by ocs4.ocs-net (8.11.2/8.11.2) with ESMTP id f5DBkKA08068;
	Wed, 13 Jun 2001 21:46:20 +1000
X-Authentication-Warning: ocs4.ocs-net: kaos owned process doing -bs
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@melbourne.sgi.com>
To: borenius@shuttle.de (Raoul Borenius)
cc: Florian Lohoff <flo@rfc822.org>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays) 
In-reply-to: Your message of "Wed, 13 Jun 2001 13:37:51 +0200."
             <20010613133751.A18749@bunny.shuttle.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Jun 2001 21:46:20 +1000
Message-ID: <8067.992432780@ocs4.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 13 Jun 2001 13:37:51 +0200, 
borenius@shuttle.de (Raoul Borenius) wrote:
>Unable to handle kernel paging request at virtual address 00000000, epc == 8800e                               e5c, ra == 8800ee5c
>Call Trace: [<88124dc0>] [<88124dd8>] [<8800eb84>] [<88063810>] [<880647f4>] [<8                               8063670>] [<880640f0>] [<880640b8>] [<8805f7f4>] [<88052a88>] [<88052b74>] [<880
>537c0>] [<88053768>] [<88052294>] [<8804ef14>] [<8800fc28>] [<8800c638>] [<c013d                               686>]

The epc line and the call trace have embedded spaces and newlines which
are preventing ksymoops from doing a full conversion.  Try again with
the extra characters removed, i.e.

Unable to handle kernel paging request at virtual address 00000000, epc == 8800e5c, ra == 8800ee5c
....
Call Trace: [<88124dc0>] [<88124dd8>] [<8800eb84>] [<88063810>]
[<880647f4>] [<88063670>] [<880640f0>] [<880640b8>] [<8805f7f4>]
[<88052a88>] [<88052b74>] [<880537c0>] [<88053768>] [<88052294>]
[<8804ef14>] [<8800fc28>] [<8800c638>] [<c013d686>]
Code: ...
