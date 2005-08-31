Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2005 17:04:54 +0100 (BST)
Received: from mx01.qsc.de ([IPv6:::ffff:213.148.129.14]:2268 "EHLO
	mx01.qsc.de") by linux-mips.org with ESMTP id <S8225554AbVHaQEe>;
	Wed, 31 Aug 2005 17:04:34 +0100
Received: from port-195-158-167-225.dynamic.qsc.de ([195.158.167.225] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1EAVAj-00004z-00; Wed, 31 Aug 2005 18:10:45 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1EAVAl-0005jG-2D; Wed, 31 Aug 2005 18:10:47 +0200
Date:	Wed, 31 Aug 2005 18:10:47 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: compiling kernel 2.6.13
Message-ID: <20050831161046.GY21717@hattusa.textio>
References: <200508311459.47273.djd20@kent.ac.uk> <20050831151223.GV21717@hattusa.textio> <20050831152537.GE3377@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831152537.GE3377@linux-mips.org>
User-Agent: Mutt/1.5.10i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Aug 31, 2005 at 05:12:23PM +0200, Thiemo Seufer wrote:
> 
> > You could try the patch in http://people.debian.org/~ths/foo/ip22-eisa.diff
> > which fixes that problem. I don't have the hardware to test it, and so far
> > nobody else cared to tell me if works.
> 
> At least it looks like an improvment and since it's probably save to
> consider the current IP22 EISA code as broken I wouldn't mind if you want
> to check this one in ...

Committed.


Thiemo
