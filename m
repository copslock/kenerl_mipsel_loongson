Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAB1jiM02591
	for linux-mips-outgoing; Sat, 10 Nov 2001 17:45:44 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAB1jf002586
	for <linux-mips@oss.sgi.com>; Sat, 10 Nov 2001 17:45:42 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fA978MI00860;
	Fri, 9 Nov 2001 18:08:22 +1100
Date: Fri, 9 Nov 2001 18:08:22 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] wrong EF_CP0_CAUSE offset
Message-ID: <20011109180821.A655@dea.linux-mips.net>
References: <3BEB171C.CF7949C2@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BEB171C.CF7949C2@mvista.com>; from jsun@mvista.com on Thu, Nov 08, 2001 at 03:37:00PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Nov 08, 2001 at 03:37:00PM -0800, Jun Sun wrote:

> reg.h has the wrong offset EF_CP0_CAUSE and the wrong pt_regs size.
> 
> This seems to be a problem only for mips (32bit) tree.
> 
> Drow found this bug, BTW.

Thanks, patch applied to both 2.2 and 2.4.  Fortunately the consequences of
this bug should hardly bite any user.

  Ralf
