Received:  by oss.sgi.com id <S553720AbQKRSUh>;
	Sat, 18 Nov 2000 10:20:37 -0800
Received: from pobox.sibyte.com ([208.12.96.20]:57870 "HELO pobox.sibyte.com")
	by oss.sgi.com with SMTP id <S553671AbQKRSU1>;
	Sat, 18 Nov 2000 10:20:27 -0800
Received: from baton.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP
	id E2AD0205FA; Sat, 18 Nov 2000 10:20:06 -0800 (PST)
Received: from SMTP agent by mail gateway 
 Sat, 18 Nov 2000 10:16:13 -0800
Received: by baton.sibyte.com (Postfix, from userid 1017)
	id 71ECE56FF; Sat, 18 Nov 2000 10:20:06 -0800 (PST)
From:   Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To:     Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: CVS Update@oss.sgi.com: linux
Date:   Sat, 18 Nov 2000 10:13:34 -0800
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
Cc:     linux-cvs@oss.sgi.com, linux-mips@oss.sgi.com, linux-mips@fnet.fr
References: <20001118132233Z553804-494+838@oss.sgi.com> <XFMail.001118180639.Harald.Koerfgen@home.ivm.de> <20001118182114.A19710@bacchus.dhis.org>
In-Reply-To: <20001118182114.A19710@bacchus.dhis.org>
MIME-Version: 1.0
Message-Id: <0011181020063F.11653@baton.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 18 Nov 2000, Ralf Baechle wrote:
> > Log message:
> >       New configuration option CONFIG_MIPS_UNCACHED.  Not yet selectable due
> >       to the manuals documenting ll/sc operation as undefined for uncached
> >       memory.
> 
> > Wouldn't it make sense then to disable CONFIG_CPU_HAS_LLSC as well?
> 
> I'm waiting for authoritative answer from silicon guys before I deciede.
> In the past I ran kernel entirely uncached and they seemed to work even
> though the documentation made me assume the opposite.
> 

I'd be very, VERY surprised if ll-sc were guaranteed to work in uncached space,
for any implementation.  It certainly wouldn't in the SB1.

The easiest way to implement the ops on a cache-coherent system is to keep track
of whether or not you've lost a line in the cache between  the ll and the sc. 
Then, in the sc, you convert the line to dirty (if necessary), do the write,
and go on your merry way.  Or, if you've lost the line at some point between the
ll and the sc, you fail the sc.

I've never heard of anyone implementing it in a significantly different manner,
on MIPS or on Alpha.  To keep track of who's written what in an uncached space
would be nightmarish at best, in hardware. 

Doesn't mean someone hasn't done it, but it would certainly be news to me.

-Justin
