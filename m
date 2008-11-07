Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2008 21:38:08 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:39379 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S23362598AbYKGViF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Nov 2008 21:38:05 +0000
Date:	Fri, 7 Nov 2008 21:38:05 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 18/29] MIPS: Add SMP_ICACHE_FLUSH for the Cavium CPU
 family.
In-Reply-To: <491481E9.1090203@ru.mvista.com>
Message-ID: <alpine.LFD.1.10.0811072118210.29448@ftp.linux-mips.org>
References: <491358F5.7040002@caviumnetworks.com> <1226004875-27654-18-git-send-email-ddaney@caviumnetworks.com> <49137EEE.5040004@ru.mvista.com> <49138650.1060901@caviumnetworks.com> <49146C7F.9010903@ru.mvista.com> <491479FD.9020402@caviumnetworks.com>
 <491481E9.1090203@ru.mvista.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 7 Nov 2008, Sergei Shtylyov wrote:

> > If you would like me to move the Kconfig patch to the end, I can do that.
> > That way you wouldn't have any breakage for octeon if you were to only apply
> > a subset of the patches.  Other than that, there are currently no plans to
> > restructure this patch set to try to maintain rigorous define before use
> > ordering.
> 
>    Maybe it's just me, but IMHO first using the macro and then, 15 patches
> after that, having a patch that just adds that macro, is going against the
> common sense...

 Hmm, I smell the set has been created by splitting a large diff that adds 
this new platform in one go.  If so, I have been through such things in 
the past and I understand how painful and difficult it may be and how much 
effort it requires -- the more the bigger the change.  I think common 
sense should apply here.  I agree this is not a very good practice.  But 
what would be the gain to justify all this extra effort needed to verify 
there are no forward references within the set?  I gather there would be 
no gain at all except from purity.  Well, I am a well-known purist as 
well, but you have to draw a line somewhere.

 On the other hand the idea to only add the Kconfig option at the end so 
that none of the changes are enabled in the limbo state is in my opinion a 
very good one.  For example some people use random config generators -- I 
am not sure if for the MIPS port too, but I cannot exclude that either -- 
so I think it would be good to make sure a broken configuration is not 
created accidentally by one of such automata.  Please consider this option 
seriously, David.

  Maciej
