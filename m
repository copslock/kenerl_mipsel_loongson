Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g23Mux324715
	for linux-mips-outgoing; Sun, 3 Mar 2002 14:56:59 -0800
Received: from dea.linux-mips.net (a1as07-p52.stg.tli.de [195.252.188.52])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g23Mus924712
	for <linux-mips@oss.sgi.com>; Sun, 3 Mar 2002 14:56:54 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g23LuVh17022;
	Sun, 3 Mar 2002 22:56:31 +0100
Date: Sun, 3 Mar 2002 22:56:31 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Rani Assaf <rani@paname.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Changes to head.S
Message-ID: <20020303225630.A16898@dea.linux-mips.net>
References: <20020303185049.A1788@paname.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020303185049.A1788@paname.org>; from rani@paname.org on Sun, Mar 03, 2002 at 06:50:49PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Mar 03, 2002 at 06:50:49PM +0100, Rani Assaf wrote:

> /*
>  * Align to 8kb boundary for init_task_union which follows in the
>  * .text segment.
>  */
> 		.text
>                 .align  13
> 
> Any idea why they have been removed?

init_task_union lives in it's own section which has 8kB alignment.  So if
you're observing an alignment problem I suspect you're using a too old
egcs 1.1.2 variant.

> BTW,  print_memory_map()  (in  kernel.c)  now uses  long  long  format
> without casting (which obviously gives wrong numbers on 32bits archs).

Yes and we preferably want to get rid of long long anyway.

  Ralf
