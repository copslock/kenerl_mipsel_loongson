Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0I799p12627
	for linux-mips-outgoing; Thu, 17 Jan 2002 23:09:09 -0800
Received: from hlubocky.del.cz (hlubocky.del.cz [212.27.221.67])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0I795P12624
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 23:09:05 -0800
Received: from ladis (helo=localhost)
	by hlubocky.del.cz with local-esmtp (Exim 3.12 #1 (Debian))
	id 16RSCN-0002Qj-00; Fri, 18 Jan 2002 07:08:23 +0100
Date: Fri, 18 Jan 2002 07:08:23 +0100 (CET)
From: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
To: James Mclean <james@adam.com.au>
cc: linux-mips@oss.sgi.com
Subject: Re: IndyCam software
In-Reply-To: <1011332340.3c47b4f4a4416@thunder.adam.com.au>
Message-ID: <Pine.LNX.4.21.0201180655520.8504-100000@hlubocky.del.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 18 Jan 2002, James Mclean wrote:

> I am interested in dual booting with Irix also, but first would like to 
> establish if there is any preliminary support for the IndyCam before installing 
> linux-mips.

hi James,

you should follow these steps:
* install linux anyway :)
* get linux kernel from cvs
* download stuff from ftp.psi.cz/pub/ladis/vino/ and see README
* happy hacking ;)

note for those who are waiting for vino support: yes, i'll start to work
on driver again. i wrote audio driver meanwhile and learned many usefull
things (many thanks to dwmw2 for patience), now i know that vino driver
have to be rewritten and i'll do so when audio driver appears in cvs.

regards,
ladis
