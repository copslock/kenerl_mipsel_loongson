Received:  by oss.sgi.com id <S554063AbQLBNOn>;
	Sat, 2 Dec 2000 05:14:43 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:38411 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S554060AbQLBNOb>;
	Sat, 2 Dec 2000 05:14:31 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 736DF804; Sat,  2 Dec 2000 14:14:26 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8E5E78F74; Sat,  2 Dec 2000 14:14:05 +0100 (CET)
Date:   Sat, 2 Dec 2000 14:14:05 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     "Juan J. Quintela" <quintela@fi.udc.es>
Cc:     linux-mips@oss.sgi.com
Subject: Re: [PATCH] DEC init_cycle_counter
Message-ID: <20001202141405.A2442@paradigm.rfc822.org>
References: <20001202132748.A2002@paradigm.rfc822.org> <yttwvdjj7r8.fsf@serpe.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <yttwvdjj7r8.fsf@serpe.mitica>; from quintela@fi.udc.es on Sat, Dec 02, 2000 at 02:02:51PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Dec 02, 2000 at 02:02:51PM +0100, Juan J. Quintela wrote:
> You delete the definition of cyclecounter_available and you mantain
> one of its uses ..... that is a no-no, I will bet that with that
> patch, this don't compile (and less it works .....).
> 

It actually compiles but i cant test due to the TLB and swapping stuff.

This whole cyle_counter stuff has moved to the generic mips time.c
in arch/mips/kernel/time.c and seemed to be a complete code duplication.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
