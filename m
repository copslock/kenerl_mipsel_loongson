Received:  by oss.sgi.com id <S553726AbQJRMqZ>;
	Wed, 18 Oct 2000 05:46:25 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:14340 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553717AbQJRMqF>;
	Wed, 18 Oct 2000 05:46:05 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A6C9AA72; Wed, 18 Oct 2000 14:46:02 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 6B37B900C; Wed, 18 Oct 2000 14:30:03 +0200 (CEST)
Date:   Wed, 18 Oct 2000 14:30:03 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Jun Sun <jsun@mvista.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: The initial results (Re: stable binutils, gcc, glibc ...
Message-ID: <20001018143003.C2354@paradigm.rfc822.org>
References: <39E7EB73.9206D0DB@mvista.com> <39ED2166.9B5F970@mvista.com> <20001018035719.F7865@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001018035719.F7865@bacchus.dhis.org>; from ralf@oss.sgi.com on Wed, Oct 18, 2000 at 03:57:19AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Oct 18, 2000 at 03:57:19AM +0200, Ralf Baechle wrote:
> 
> loop:
> 	[...]
> 	beq	r1, r2, loop
> 
> should be turned into:
> 
> loop:
> 	[...]
> 	bnez	r1, r2, 1f
> 	j	loop
> 1:
> 
> but of course only if the branch destination is outside the 16-bit range.
> Thanks to the ever increasing code size there are now several realworld
> examples which run into this problem.  Volunteers?

By thinking about this without any knowledge of the binutils code generation.

How does this work if loop is only an external symbol ? The distance
will than be relevant when linking but then the code will already be there
and one would need to insert an instruction.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
