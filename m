Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g27E8JI28449
	for linux-mips-outgoing; Thu, 7 Mar 2002 06:08:19 -0800
Received: from dea.linux-mips.net (a1as01-p99.stg.tli.de [195.252.185.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g27E88928445
	for <linux-mips@oss.sgi.com>; Thu, 7 Mar 2002 06:08:09 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g27D7sv02940;
	Thu, 7 Mar 2002 14:07:54 +0100
Date: Thu, 7 Mar 2002 14:07:54 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: Linux MIPS <linux-mips@oss.sgi.com>
Subject: Re: Questions?
Message-ID: <20020307140754.A1817@dea.linux-mips.net>
References: <1015435541.3714.33.camel@MCK_Linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1015435541.3714.33.camel@MCK_Linux>; from marc_karasek@ivivity.com on Wed, Mar 06, 2002 at 12:25:11PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Mar 06, 2002 at 12:25:11PM -0500, Marc Karasek wrote:

> 
> How many of you are involved with embedded linux development using a
> MIPS processor? 
> 
> What endianess have you chosen for your project and why? 
> 
> If you have not guessed it, I am involved with a MIPS/Linux embedded
> project and we are trying to determine if there are any pros or cons in
> one endianess over the other.  

The MIPS ABI only covers big endian systems - every "real" MIPS UNIX
system is big endian.  Everything else is a GNU extension.  There is
hardly any reason to choose a particular byteorder as usually endianess
swapping takes so little CPU time that it isn't even meassurable but so
I'm told there are exceptions.  If portability of software you're
going to write wrt. external data representation (disk or network) is
of any importance then I suggest you use a system of the opposite
endianess which trip problems much faster.

  Ralf
