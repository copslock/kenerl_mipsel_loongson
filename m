Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BLAl512189
	for linux-mips-outgoing; Mon, 11 Feb 2002 13:10:47 -0800
Received: from dea.linux-mips.net (a1as09-p62.stg.tli.de [195.252.189.62])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BLAd912186
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 13:10:42 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1ABBZX12654;
	Sun, 10 Feb 2002 12:11:35 +0100
Date: Sun, 10 Feb 2002 12:11:34 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: gcc include strangeness
Message-ID: <20020210121134.B2018@dea.linux-mips.net>
References: <20020209150155.GA853@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020209150155.GA853@paradigm.rfc822.org>; from flo@rfc822.org on Sat, Feb 09, 2002 at 04:01:55PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Feb 09, 2002 at 04:01:55PM +0100, Florian Lohoff wrote:

> i just stumbled when i tried to compile a program (bootloader) with
> gcc which uses varargs. I got the error that "sgidefs.h" was missing.
> sgidefs.h is contained in the glibc which gets included by va-mips.h
> from stdarg.h - I dont think this is correct as i should be able
> to compile programs without glibc.
> 
> Shouldnt sgidefs.h or its content be included in the gcc ?

There should be a copy of sgidefs.h in /usr/include rsp. for crosscompilers
in <prefix>/<target>/include/sgidefs.h.  However the gcc varargs stuff
has been rewritten completely; the new implementation does no longer try
to include sgidefs.h.

 Ralf
