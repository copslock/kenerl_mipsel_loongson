Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3ILAbI21993
	for linux-mips-outgoing; Wed, 18 Apr 2001 14:10:37 -0700
Received: from the-village.bc.nu (router-100M.swansea.linux.org.uk [194.168.151.17])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3ILAZM21990
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 14:10:35 -0700
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 14pzEm-0005jl-00; Wed, 18 Apr 2001 22:11:44 +0100
Subject: Re: Linux on LSI EZ4102
To: wesolows@foobazco.org (Keith M Wesolowski)
Date: Wed, 18 Apr 2001 22:11:42 +0100 (BST)
Cc: rjkm@convergence.de (Ralph Metzler), jensenq@Lineo.COM (Quinn Jensen),
   linux-mips@oss.sgi.com
In-Reply-To: <20010418132323.A25356@foobazco.org> from "Keith M Wesolowski" at Apr 18, 2001 01:23:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pzEm-0005jl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Any -ac kernel contains at most the same changes that are in the oss
> tree.  Trees other than the oss one, including ac, are likely to
> contain more bugs.

-ac has all the stuff Ralf has sent me. Linus has most of that. In some
ways -ac has less bugs (eg the oss tree has serious disk corruption bugs -ac
doesnt) but I certainly cant guarantee -ac will always build on mips, and 
right now with the sem changes it quite probably wont.

Alan
