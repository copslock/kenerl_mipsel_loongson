Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34BKg711678
	for linux-mips-outgoing; Wed, 4 Apr 2001 04:20:42 -0700
Received: from the-village.bc.nu (router-100M.swansea.linux.org.uk [194.168.151.17])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34BKdM11675
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 04:20:40 -0700
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 14klMh-0001kx-00; Wed, 4 Apr 2001 12:22:19 +0100
Subject: Re: Dumb Question on Cross-Development
To: flo@rfc822.org (Florian Lohoff)
Date: Wed, 4 Apr 2001 12:22:16 +0100 (BST)
Cc: jsun@mvista.com (Jun Sun), kevink@mips.com (Kevin D. Kissell),
   linux-mips@oss.sgi.com ("MIPS/Linux List (SGI)")
In-Reply-To: <20010404120211.C11161@paradigm.rfc822.org> from "Florian Lohoff" at Apr 04, 2001 12:02:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14klMh-0001kx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> We already had the discussion on parts of that implementation. Honestly - 
> I dont like the stuff - Rolling out mips packages as "noarch" is
> simply broken - And the argument that one would want to install
> it on a i386 nfs root is simply an excuse for a broken rpm or missing
> installer.

Or a flawed packaging tool. RPM allows you to force noarch and you can use it
to get around this precise problem. Its also useful when you want to force
an x86 package onto an Alpha with em86.

I find it hard to believe dpkg lacks such a feature.
