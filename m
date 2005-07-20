Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jul 2005 10:16:25 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:53916 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8224904AbVGTJQK>;
	Wed, 20 Jul 2005 10:16:10 +0100
Received: from port-195-158-170-19.dynamic.qsc.de ([195.158.170.19] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1DvAi3-00046G-00; Wed, 20 Jul 2005 11:17:47 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1DvAhT-000175-Fv; Wed, 20 Jul 2005 11:17:11 +0200
Date:	Wed, 20 Jul 2005 11:17:06 +0200
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Pete Popov <ppopov@embeddedalley.com>,
	Kishore K <hellokishore@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: bal instruction in gcc 3.x
Message-ID: <20050720091706.GJ2071@hattusa.textio>
References: <f07e6e05071909301c212ab4@mail.gmail.com> <20050719164427.GB8758@linux-mips.org> <f07e6e05071910194bab9b16@mail.gmail.com> <1121802786.7285.88.camel@localhost.localdomain> <Pine.LNX.4.61L.0507200955390.30702@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507200955390.30702@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Tue, 19 Jul 2005, Pete Popov wrote:
> 
> > Try the attached patch instead.
> 
>  Apart from other changes why not simply s/bal/jal/?  Your proposed code 
> is bad if ever to be built to a 64-bit object.

Non-PIC jal isn't relocateable, the PIC jal wants a regular stack
frame, and the end of the patch shows the 32bit assumption was
already made earlier. :-)


Thiemo
