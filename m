Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Apr 2005 10:06:19 +0100 (BST)
Received: from smtp-out.hotpop.com ([IPv6:::ffff:38.113.3.61]:6346 "EHLO
	smtp-out.hotpop.com") by linux-mips.org with ESMTP
	id <S8225507AbVDAJGD>; Fri, 1 Apr 2005 10:06:03 +0100
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 3A186FC40C1
	for <linux-mips@linux-mips.org>; Fri,  1 Apr 2005 09:05:49 +0000 (UTC)
Received: from [192.168.0.85] (unknown [83.104.11.251])
	by smtp-1.hotpop.com (Postfix) with ESMTP
	id A03F11A0093; Fri,  1 Apr 2005 09:05:46 +0000 (UTC)
Subject: Re: Compressed Kernels
From:	JP <jaypee@hotpop.com>
To:	ppopov@embeddedalley.com
Cc:	"Robin H. Johnson" <robbat2@orbis-terrarum.net>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <424C2450.4030406@embeddedalley.com>
References: <1112258126.28438.16.camel@localhost.localdomain>
	 <20050331084207.GA8346@curie-int.orbis-terrarum.net>
	 <424C2450.4030406@embeddedalley.com>
Content-Type: text/plain
Date:	Fri, 01 Apr 2005 10:05:55 +0100
Message-Id: <1112346356.30390.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Return-Path: <jaypee@hotpop.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaypee@hotpop.com
Precedence: bulk
X-list: linux-mips

> Should be easy to update if if doesn't apply cleanly anymore. I think the 
> complaint about that patch is that it duplicates some code from other 
> architectures and a more common solution is needed. Since I don't have time to 
> work on something more common, the patch remains stand alone.

Fair enough I'd agree with that as the code I used was straight outta
i386. Other archs use the same arm sh etc. I'll apply your patch for our
boards rather than duplicate the effort. This I guess is a problem for
all arches and really should be addressed at the kernel.org level.

-- 
mailto:jaypee@hotpop.com
http://jaypee.org.uk
