Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6H0OGRw014168
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Jul 2002 17:24:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6H0OG6f014166
	for linux-mips-outgoing; Tue, 16 Jul 2002 17:24:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6H0OBRw014114
	for <linux-mips@oss.sgi.com>; Tue, 16 Jul 2002 17:24:12 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g6H0T1v06120;
	Wed, 17 Jul 2002 02:29:01 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g6H0T1TF023401;
	Wed, 17 Jul 2002 02:29:02 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17Ucgf-0001ra-00; Wed, 17 Jul 2002 02:29:01 +0200
Date: Wed, 17 Jul 2002 02:29:01 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Pete Popov <ppopov@mvista.com>
cc: linux-mips@oss.sgi.com
Subject: Re: PATCH
In-Reply-To: <1026842416.15665.199.camel@zeus.mvista.com>
Message-ID: <Pine.LNX.4.21.0207170219280.19074-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 16 Jul 2002, Pete Popov wrote:

> > But Vivien Chappelier said it fixed his X server problem in mips64.
> I think the upper 32 bits get zeroed out.  The fact that it fixed Vivien's
> problem confirms this (he was running oss, right?)

Well.. sorry guys, it seems it works with the old version as well
now.. don't know what I messed up..
Anyway, on mips64, pte_t is an unsigned long, which is 64 bit, but
PAGE_MASK in PAGE_CHG_MASK is 1UL << something, so it's 64 bit as
well. Thus I guess there no problem with the old implementation in
fact. (the problem was with me..)

Sorry,
Vivien Chappelier.
