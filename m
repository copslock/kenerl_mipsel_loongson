Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4ECG6f11023
	for linux-mips-outgoing; Mon, 14 May 2001 05:16:06 -0700
Received: from ninigret.metatel.office ([63.148.55.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4ECG5F11018
	for <linux-mips@oss.sgi.com>; Mon, 14 May 2001 05:16:05 -0700
Received: from ninigret.metatel.office (IDENT:rafal@localhost.metatel.office [127.0.0.1])
	by ninigret.metatel.office (8.9.3/8.8.8) with ESMTP id IAA19297;
	Mon, 14 May 2001 08:15:48 -0400
Message-Id: <200105141215.IAA19297@ninigret.metatel.office>
From: Rafal Boni <rafal.boni@eDial.com>
To: mjpento <mjpento@mediaone.net>
Cc: peter.zijlstra@chello.nl, linux-mips@oss.sgi.com
Subject: Re: Where to start with a R4000 Indigo 
In-reply-to: Your message of "Sat, 12 May 2001 15:39:24 EDT."
             <p05001900b7233ce422ce@[192.168.1.3]> 
X-Mailer: NMH 1.0 / EXMH 2.0.3
Date: Mon, 14 May 2001 08:15:48 -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

In message <p05001900b7233ce422ce@[192.168.1.3]>, Mike writes: 

-> 	I am in the same boat as you essentially, only I am a little 
-> worse off. I own 2 Indigo R3000's and would love to see a port of 
-> Linux or NetBSD or something of that nature done for the machine, but 
-> alas, I fear that if I don't start one on my architecture there may 
-> never be a port to the R3000.

Quick note re: NetBSD: If you get the hardware support going, there is
already R3000 support in the tree, so the port to the R3000 Indigo should
be no harder than the one to the R4000 Indigo.

-> 	There is also the Plan 9 effort, which is an OS that is/was 
-> being developed by AT&T that supports the R4000 and maybe even the 
-> R3000. You may be able to get information about the architecture of 
-> the Indigo from this code. I have been unsuccessful in this respect, 
-> but, maybe you will have better luck than I. Here are some Plan 9 
-> links to get you started:
-> 
-> http://www.vitanuova.com/plan9/
-> http://www.fywss.com/plan9/plan9faq.html

If you've been unsuccessful in finding the Plan9 Indigo code, I have
been told it's only available on CD, and if any/either of you is interested
in it, I will try and track down the info for ordering it and/or confirming
that it contains useful info (I know someone who just ordered it to help
with a NetBSD port to the Indigo).

-> 	As far as getting information from SGI, I wouldn't bother 
-> with that, as anyone else in here would agree. The chances of them 
-> giving you any information are slim to none. The expense of having 
-> someone at SGI pull documentation for the Indigo (if it even still 
-> exists) is too high. So, architecture information and specifications 
-> are very hard to come by.

Agreed.  I've been told (and have no reason to disbelieve) that the primary
issue is making sure the docs are unencumbered by third-party IPR before 
being released and since this involves both technical people and lawyers,
it can't be cheap. 

--rafal

----
Rafal Boni                                              rafal.boni@eDial.com
 PGP key C7D3024C, print EA49 160D F5E4 C46A 9E91  524E 11E0 7133 C7D3 024C
    Need to get a hold of me?  http://800.edial.com/rafal.boni@eDial.com
