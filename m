Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1SI6oc17069
	for linux-mips-outgoing; Thu, 28 Feb 2002 10:06:50 -0800
Received: from dea.linux-mips.net (a1as05-p107.stg.tli.de [195.252.187.107])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1SI6j917063
	for <linux-mips@oss.sgi.com>; Thu, 28 Feb 2002 10:06:46 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1SBYua25814;
	Thu, 28 Feb 2002 12:34:56 +0100
Date: Thu, 28 Feb 2002 12:34:56 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: santhosh <ps.santhosh@gdatech.co.in>
Cc: linux-mips@oss.sgi.com
Subject: Re: compiler error
Message-ID: <20020228123456.A25783@dea.linux-mips.net>
References: <3C7E68ED.93B565AB@gdatech.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7E68ED.93B565AB@gdatech.co.in>; from ps.santhosh@gdatech.co.in on Thu, Feb 28, 2002 at 10:59:17PM +0530
X-Accept-Language: de,en,fr
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g1SI6l917064
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Feb 28, 2002 at 10:59:17PM +0530, santhosh wrote:

>      i am working  on MIPS64 based (SB1250) board.
> when i tried to compile the kernel i am getting the following
> error messages
> 
> Assembler messages:
> Error: invalid architecture -mcpu=sb1
> cc1: bad value (sb1) for -mcpu= switch
> init/main.c:198: output pipe has been closed
> cpp: output pipe has been closed
> make: *** [init/main.o] Error 1

You should use the gcc variant from Sibyte or a recent Montavista compiler
for the SB1250 SOC.

> To: santhosh <ps.santhosh@gdatech.co.in>
               ^^^

And please finally remove that damn control character from your email
address in your headers or I'm going to unsubscribe you from the list.
I'm fedup of dealing with the bounces caused by that.

  Ralf
