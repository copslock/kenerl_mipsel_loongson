Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2004 20:08:58 +0000 (GMT)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:26083 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8224987AbUAUUI5>;
	Wed, 21 Jan 2004 20:08:57 +0000
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 21 Jan 2004 12:08:53 -0800
Message-ID: <400EDC24.3080309@avtrex.com>
Date: Wed, 21 Jan 2004 12:08:04 -0800
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Andrew Haley <aph@redhat.com>, Andreas Tobler <toa@pop.agri.ch>,
	Geoffrey Keating <geoffk@apple.com>,
	gcc-patches <gcc-patches@gcc.gnu.org>,
	Andrew Pinski <pinskia@physics.uc.edu>,
	Eric Christopher <echristo@redhat.com>,
	Richard Henderson <rth@redhat.com>, linux-mips@linux-mips.org
Subject: Re: [RFC]: MD_FALLBACK_FRAME_STATE_FOR macro for darwin PPC
References: <400D9173.7010508@pop.agri.ch>	<7809AEC4-4B8A-11D8-83EB-000A95B1F520@apple.com>	<400E3C5C.3060001@pop.agri.ch>	<400EC5B4.6020402@avtrex.com>	<400ED0D9.20704@pop.agri.ch>	<400ED4DE.6080601@avtrex.com> <16398.55568.933882.591110@cuddles.cambridge.redhat.com>
In-Reply-To: <16398.55568.933882.591110@cuddles.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2004 20:08:53.0074 (UTC) FILETIME=[6449C320:01C3E05A]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Andrew Haley wrote:

>David Daney writes:
> > Andreas Tobler wrote:
> > 
> > > David Daney wrote:
> > >
> > >
> > >> I know next to nothing about PPC ABIs, but are any of these floating 
> > >> point registers?
> > >
> > >
> > > There are, yes.
> > >
> > >> Are there any call saved FP registers in this ABI? and if so are you 
> > >> restoring them.  Although I don't think that the unwinder uses 
> > >> floating point, it seems that restoring call saved FP registers is a 
> > >> good idea if you are not already doing it.
> > >
> > >
> > > Well, here I expect the advise from the experts, I have floats around 
> > > and I may try to restore them.
> > >
> > > But, I need some guidance here.
> > 
> > When I did the MD_FALLBACK_FRAME_STATE_FOR for mips/linux I did not 
> > handle floating point either as the problem did not occur to me until 
> > after I checked in the code.
> > 
> > However after thinking about it and posting:
> > 
> > http://gcc.gnu.org/ml/gcc/2003-10/msg00972.html
> > 
> > I learned that this is a real issue.
> > 
> > I may be about ready to do some more mips/linux work soon and may 
> > revisit MD_FALLBACK_FRAME_STATE_FOR.  Because in its current state it 
> > seems to be incomplete.
>
>You only need to restore what has been saved.  Looking at
>/usr/src/linux-2.4/arch/mips/kernel/signal.c, it seems that there is a
>call to save_fp_context().  However, this is only executed if
>(current->used_math) is set; you mustn't restore any fp registers if
>the process hasn't saved the fp state.
>
>There is a field called sc_used_math in the sigcontext struct.  I
>think this tells you what you need to know.  But I am not a kernel
>hacker...
>
>Andrew.
>  
>
Ralf,

Is this all true?

Perhaps you could shed some light on what really needs to be done in the 
MIPS/linux case.

Also what should be done in the case of mips 4Kc core where there is 
only software floating point?

David Daney.
