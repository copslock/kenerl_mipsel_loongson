Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6JAL4Rw020894
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 19 Jul 2002 03:21:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6JAL40k020893
	for linux-mips-outgoing; Fri, 19 Jul 2002 03:21:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from holly.csn.ul.ie (holly.csn.ul.ie [136.201.105.4])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6JAKtRw020879
	for <linux-mips@oss.sgi.com>; Fri, 19 Jul 2002 03:20:56 -0700
Received: from skynet.ie (orac [136.201.105.3])
	by holly.csn.ul.ie (Postfix) with SMTP
	id 223E12B352; Fri, 19 Jul 2002 11:21:28 +0100 (IST)
Received: from 63.84.187.40
        (SquirrelMail authenticated user airlied)
        by www.csn.ul.ie with HTTP;
        Fri, 19 Jul 2002 11:21:28 +0100 (IST)
Message-ID: <62037.63.84.187.40.1027074088.squirrel@www.csn.ul.ie>
Date: Fri, 19 Jul 2002 11:21:28 +0100 (IST)
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card?
From: "Dave Airlie" <airlied@skynet.ie>
To: <macro@ds2.pg.gda.pl>
In-Reply-To: <Pine.GSO.3.96.1020718160853.14993C-100000@delta.ds2.pg.gda.pl>
References: <200207171830.UAA04138@sparta.research.kpn.com>
        <Pine.GSO.3.96.1020718160853.14993C-100000@delta.ds2.pg.gda.pl>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <vhouten@kpn.com>, <linux-mips@oss.sgi.com>
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

about 30 mins coding should be able to hack around the two cards in one
system issue :-) (Flo did some work already).

only esp_virt_buffer and  scsi_current_length globals are used for the
PMAZ-A as far as I know, and only in the read path between
pmaz_dma_init_read and pmaz_dma_drain, also maybe the pmaz_cmd_buffer when
I look at it.

if there is nowhere in the esp to place them perhaps a priv void * needs
to be added to the NCR core code and used to store this stuff, I meant to
do it at the time, but twas 2 years ago and at the moment I'm nearly as
far away from my DecStation as physically possible and not getting any
closer for the forseeable :-)

My reason of course was I didn't really know much about TC and that such a
card existed orignally, and the original code only handled one IO-ASIC
(which I think is okay)...

Dave. in Laos.

> Hi Karel,
>
>> Sorry, same result. See attached log.
>
>  Thanks for the report.  Apart from missing WB flushing, there is
> nothing
> obviously broken in the PMAZ-A code -- I'll look at the problem more
> deeply later.  The driver seems to work to some extent as it was able to
> retrieve inquiry data, so it's not broken in principle.
>
>  It would be great if you could check if the driver works for the /200's
> onboard PMAZ-A.  If it worked there, I'd suspect a bug in the NCR53C8x
> support core.  But please don't put a second PMAZ-A into your /200 --
> for an unclear reason the driver only supports a single I/O ASIC-based
> HBA and a single additional PMAZ-A board.  All PMAZ-A boards share
> operational variables with one another, so using more than a single one
> leads to data corruption.
>
>   Maciej
>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
