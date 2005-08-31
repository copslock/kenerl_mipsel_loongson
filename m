Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2005 17:12:06 +0100 (BST)
Received: from smtp.seznam.cz ([IPv6:::ffff:212.80.76.43]:51870 "HELO
	smtp.seznam.cz") by linux-mips.org with SMTP id <S8225555AbVHaQLu>;
	Wed, 31 Aug 2005 17:11:50 +0100
Received: (qmail 14226 invoked from network); 31 Aug 2005 15:42:30 -0000
Received: from unknown (HELO orphique) (Ladislav.Michl@62.77.73.201)
  by cetus.go.seznam.cz with ESMTPA; 31 Aug 2005 15:42:30 -0000
Received: from ladis by orphique with local (Exim 3.36 #1 (Debian))
	id 1EAUjQ-0005pm-00; Wed, 31 Aug 2005 17:42:32 +0200
Date:	Wed, 31 Aug 2005 17:42:32 +0200
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Damian Dimmich <djd20@kent.ac.uk>, linux-mips@linux-mips.org
Subject: Re: compiling kernel 2.6.13
Message-ID: <20050831154232.GA22174@orphique>
References: <200508311459.47273.djd20@kent.ac.uk> <20050831151223.GV21717@hattusa.textio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831151223.GV21717@hattusa.textio>
User-Agent: Mutt/1.5.9i
From:	Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 31, 2005 at 05:12:23PM +0200, Thiemo Seufer wrote:
[snip]
> You could try the patch in http://people.debian.org/~ths/foo/ip22-eisa.diff
> which fixes that problem. I don't have the hardware to test it, and so far
> nobody else cared to tell me if works.

Yet another patch is laying here almost two years without any attention:
ftp://ftp.linux-mips.org/pub/linux/mips/people/ladis/eisa.diff

It is against some ancient 2.4 kernel (do we still about it?) and at least
shows how to use common 8259A code to handle interrupts. Perhaps we
could do the same in 2.6 and use new EISA code in drivers/eisa ?

	ladis
