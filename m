Received:  by oss.sgi.com id <S553760AbQJXMcn>;
	Tue, 24 Oct 2000 05:32:43 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:62219 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553751AbQJXMcS>;
	Tue, 24 Oct 2000 05:32:18 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B47CA807; Tue, 24 Oct 2000 14:31:51 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 2A856900C; Tue, 24 Oct 2000 14:25:26 +0200 (CEST)
Date:   Tue, 24 Oct 2000 14:25:26 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: Re: process lockups
Message-ID: <20001024142526.A4162@paradigm.rfc822.org>
References: <20001024032232.A3426@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001024032232.A3426@excalibur.cologne.de>; from karsten@excalibur.cologne.de on Tue, Oct 24, 2000 at 03:22:32AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 24, 2000 at 03:22:32AM +0200, Karsten Merker wrote:
> Hallo everyone,
> 
> I am running Kernel 2.4.0-test9 on a DECstation 5000/150. I am
> experiencing a strange behaviour when having strong I/O-load, such as
> running a "tar xvf foobar.tgz" with a large archive. After some time of
> activity the process (in this case tar) is stuck in status "D". There is
> neither an entry in the syslog nor on the console that would give me a
> hint what is happening. Is anyone else experiencing this?

I have not seen this on my /150 although i have not been running -test9. I
got that machine @home right now so ill check if i can reproduce this.

> Another thing I see on my 5000/150 (and only there - this is my only
> R4K-machine, so I do not know whether this is CPU- or machine-type-bound)
> is "top" going weird, eating lots of CPU cycles and spitting messages
> "schedule_timeout: wrong timeout value fffbd0b2 from 800900f8; Setting
> flush to zero for top". I know Florian also has this on his 5000/150.
> Anyone else with the same behavoiur or any idea about the cause for this?

I guess this is Decstation specific as i cant seem to be able
to reproduce this on the I2 - I have seen this too.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
