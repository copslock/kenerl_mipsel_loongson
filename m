Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f42KtLF31922
	for linux-mips-outgoing; Wed, 2 May 2001 13:55:21 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f42KtKF31913
	for <linux-mips@oss.sgi.com>; Wed, 2 May 2001 13:55:20 -0700
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f42Ksb032765;
	Wed, 2 May 2001 13:54:37 -0700
Message-ID: <3AF07385.22E94902@mvista.com>
Date: Wed, 02 May 2001 13:52:21 -0700
From: Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Matthew Dharm <mdharm@momenco.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Endianness...
References: <NEBBLJGMNKKEEMNLHGAIGEEFCBAA.mdharm@momenco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Matthew Dharm wrote:
> 
> What's the preferred endianness for Linux-MIPS?  I can't really go
> into why I'm asking (sensitive NDA information), but I'm basically
> faced with a group that wants to work in LE.  However, my
> understanding was that Linux-MIPS generally ran BE.
> 
> Or can it be built either way?  I know OpenBSD runs LE.... not like
> that means anything to this group, tho.

I saw some of the replies.  I don't think it's true that BE is "the" way
to go. mips-linux runs both, le and be. We have three different LE
boards and our partners have shipped our LE port to many of their
customers. The Alchemy board I'm working on runs both, LE and BE and
I've tested both.   Depending on the peripherals you want to support,
like USB, PCMCIA, etc, little endian might be a lot easier to port to.
If on the other hand you're interested in a mips64 smp port, then BE is
probably the easiest way to go because of the current support of
mips64.  As far as binary completeness, the RedHat 7.0 port is, I think,
BE. But our HardHat Linux 2.0 will offer the same completeness for both,
LE and BE (should be on the ftp site by the end of the month).

Pete
