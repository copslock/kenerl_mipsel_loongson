Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g23NsOl30378
	for linux-mips-outgoing; Sun, 3 Mar 2002 15:54:24 -0800
Received: from darth.paname.org (root@ns0.paname.org [212.27.32.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g23NsI930372;
	Sun, 3 Mar 2002 15:54:18 -0800
Received: from darth.paname.org (localhost [127.0.0.1])
	by darth.paname.org (8.12.1/8.12.1/Debian -2) with ESMTP id g23MsGZB003387;
	Sun, 3 Mar 2002 23:54:16 +0100
Received: (from rani@localhost)
	by darth.paname.org (8.12.1/8.12.1/Debian -2) id g23MsGxi003386;
	Sun, 3 Mar 2002 23:54:16 +0100
From: Rani Assaf <rani@paname.org>
Date: Sun, 3 Mar 2002 23:54:16 +0100
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Changes to head.S
Message-ID: <20020303235416.D3190@paname.org>
References: <20020303185049.A1788@paname.org> <20020303225630.A16898@dea.linux-mips.net> <20020303230449.K1788@paname.org> <20020303231906.A17147@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020303231906.A17147@dea.linux-mips.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux darth 2.4.17-pre8 
X-NCC-RegID: fr.proxad
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Mar 03, 2002 at 11:19:06PM +0100, Ralf Baechle wrote:
> these two lines in the linker script arch/mips/ld.script.in:
> 
>   . = ALIGN(8192);
>   .data.init_task : { *(.data.init_task) }

Yep, I was just  looking at it. So the problem  is in init_task.c. The
following line should be changed from:

        __attribute__((__section__(".text"))) =

to:
	__attribute__((__section__(".data.init_task"))) =

Right?

Regards,
Rani
