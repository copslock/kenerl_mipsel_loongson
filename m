Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g09CZnB03779
	for linux-mips-outgoing; Wed, 9 Jan 2002 04:35:49 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g09CZig03775
	for <linux-mips@oss.sgi.com>; Wed, 9 Jan 2002 04:35:45 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g09BZKR01813;
	Wed, 9 Jan 2002 09:35:20 -0200
Date: Wed, 9 Jan 2002 09:35:20 -0200
From: Ralf Baechle <ralf@conectiva.com.br>
To: machael thailer <dony.he@huawei.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@oss.sgi.com,
   Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: limited Memory question...
Message-ID: <20020109093519.B1468@dea.linux-mips.net>
References: <E16O9BM-0008W9-00@the-village.bc.nu> <004101c198bb$988a6ec0$9b6e0b0a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <004101c198bb$988a6ec0$9b6e0b0a@huawei.com>; from dony.he@huawei.com on Wed, Jan 09, 2002 at 11:13:22AM +0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jan 09, 2002 at 11:13:22AM +0800, machael thailer wrote:

> "24M" contains some debugging information. I compile it using "-g".
> code+data sections is only about 7.4M.
> 
> Can you describe your solutions in more details?

No way to load such a module into such little memory.  The only possible
solution is to drastically rewrite your module and move everything
possible into a userspace process.  For userspace processes swapping is
possible ...

  Ralf

--
"Embrace, Enhance, Eliminate" - it worked for the pope, it'll work for Bill.
