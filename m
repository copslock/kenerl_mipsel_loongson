Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 07:45:12 +0100 (CET)
Received: from miranda.se.axis.com ([193.13.178.8]:55772 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491878AbZKKGpF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 07:45:05 +0100
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id nAB6iuIx026346;
	Wed, 11 Nov 2009 07:44:56 +0100
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Wed, 11 Nov 2009 07:44:56 +0100
From:	Mikael Starvik <mikael.starvik@axis.com>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
CC:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	Jesper Nilsson <Jesper.Nilsson@axis.com>
Date:	Wed, 11 Nov 2009 07:44:54 +0100
Subject: RE: SMTC lookup in smtc_distribute_timer
Thread-Topic: SMTC lookup in smtc_distribute_timer
Thread-Index: AcpiQjZd25j6RSwjTPGwAcqgdIhspQAWAbIw
Message-ID: <4BEA3FF3CAA35E408EA55C7BE2E61D0546A586E886@xmail3.se.axis.com>
References: <4BEA3FF3CAA35E408EA55C7BE2E61D0546A586E7EA@xmail3.se.axis.com>
 <4AF9C2EA.3090205@paralogos.com>
In-Reply-To: <4AF9C2EA.3090205@paralogos.com>
Accept-Language: sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage:	sv-SE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <mikael.starvik@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mikael.starvik@axis.com
Precedence: bulk
X-list: linux-mips

Yes, I thought of that variant after I sent the email yesterday.
I'll change our local implementation. If you don't hear anything
it works as expected in our case (it was pretty easy for us to
repeat).

/Mikael 

-----Original Message-----
From: Kevin D. Kissell [mailto:kevink@paralogos.com] 
Sent: den 10 november 2009 20:46
To: Mikael Starvik
Cc: linux-mips@linux-mips.org; Jesper Nilsson
Subject: Re: SMTC lookup in smtc_distribute_timer

Your failure scenario looks plausible. Mea culpa.  However, I think that
a more elegant and slightly smaller (depending on just how good
the optimizer is) fix would be:

diff --git a/arch/mips/kernel/cevt-smtc.c b/arch/mips/kernel/cevt-smtc.c
index 98bd7de..b102e4f 100644
--- a/arch/mips/kernel/cevt-smtc.c
+++ b/arch/mips/kernel/cevt-smtc.c
@@ -173,11 +173,12 @@ void smtc_distribute_timer(int vpe)
        unsigned int mtflags;
        int cpu;
        struct clock_event_device *cd;
-       unsigned long nextstamp = 0L;
+       unsigned long nextstamp;
        unsigned long reference;
 
 
 repeat:
+       nextstamp = 0L;
        for_each_online_cpu(cpu) {
            /*
             * Find virtual CPUs within the current VPE who have



I don't have access to SMTC-capable hardware just now, but
I guess the way to test this would be to have a test program
or kernel test stub program two events separated by the smallest
possible increment, so that the second will have passed by the
time interrupt services for the first.

          Regards,

          Kevin K.

Mikael Starvik wrote:
> Ok, my guess is something like this:
>
> 1. At the end of smtc_distribute_timer, nextstamp is valid and has already 
> passed so we goto repeat. 
> 2. Nothing updates nextstamp (only updated if the timeout is in the future 
> And we just decided it is in the past)
> 3. At the end nextstamp still has the same value so it is still valid and
> in the past.
> 4. This repeats until read_c0_count has a value which causes nextstamp to
> be in the future.
>
> One possible patch that seams to solve it for me below. This is probably 
> not the correct solution so I'll need help from the SMTC experts to review
> it and come up with the correct solution.
>
> Best Regards
> /Mikael
>
> Index: cevt-smtc.c
> ===================================================================
> RCS file: /usr/local/cvs/linux/os/linux-2.6/arch/mips/kernel/cevt-smtc.c,v
> retrieving revision 1.2
> diff -u -r1.2 cevt-smtc.c
> --- cevt-smtc.c	2 Sep 2009 10:07:51 -0000	1.2
> +++ cevt-smtc.c	10 Nov 2009 11:40:31 -0000
> @@ -223,8 +223,10 @@
>  		write_c0_compare(nextstamp);
>  		ehb();
>  		if ((nextstamp - (unsigned long)read_c0_count())
> -			> (unsigned long)LONG_MAX)
> +			> (unsigned long)LONG_MAX) {
> +				nextstamp = 0L;  
>  				goto repeat;
> +			}
>  	}
>  }
>
>
>   
