Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0I7k0T13135
	for linux-mips-outgoing; Thu, 17 Jan 2002 23:46:00 -0800
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0I7jtP13131
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 23:45:55 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.11.6/8.9.3) with ESMTP id g0I6jq518635;
	Fri, 18 Jan 2002 07:45:52 +0100
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id HAA14403;
	Fri, 18 Jan 2002 07:45:52 +0100 (MET)
Message-Id: <200201180645.HAA14403@sparta.research.kpn.com>
X-Mailer: exmh version 1.6.5 12/11/95
To: Florian Lohoff <flo@rfc822.org>
cc: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>,
   karsten@excalibur.cologne.de, linux-mips@oss.sgi.com,
   karel@sparta.research.kpn.com
Subject: Re: DECStation debian CD's 
In-reply-to: Your message of "Thu, 17 Jan 2002 20:49:13 +0100."
             <20020117194913.GB26395@paradigm.rfc822.org> 
Reply-to: vhouten@kpn.com
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 18 Jan 2002 07:45:52 +0100
From: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi Flo,

> On Thu, Jan 17, 2002 at 10:37:30AM +0100, Houten K.H.C. van (Karel) wrote:
> > - delo doesn't work in combination with th 5000/200 PROM ???
> >   (the systems just resets)
> 
> Thats correct - The /200 should ne a REX (non-REX?) prom which is
> basically not supported yet - I havent got a running /200 
> 
> loader/main.c
>      30         /* FIXME We only check for REX but dont handle it right
> now */
>      31         if (magic == DEC_REX_MAGIC) {
>      32                 /* Store Call Vector */
>      33                 callv=cv;
>      34                 rex_prom=1;
>      35         }
> 
> Somebody would need to actually tune a bit for the prom calls for
> read/write of disks and the command line parameters.

Is there any documentation about those PROM's available?

Regards,
-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
