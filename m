Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g6237wnC024302
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 20:07:58 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g6237wM4024301
	for linux-mips-outgoing; Mon, 1 Jul 2002 20:07:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from potter.sfbay.redhat.com (IDENT:root@potter.sfbay.redhat.com [205.180.83.107])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g6237qnC024291
	for <linux-mips@oss.sgi.com>; Mon, 1 Jul 2002 20:07:52 -0700
Received: from localhost.localdomain (remus.sfbay.redhat.com [172.16.27.252])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id g623CnQ14285;
	Mon, 1 Jul 2002 20:12:49 -0700
Subject: Re: MIPS GOT overflow in gcc 3.2.
From: Eric Christopher <echristo@redhat.com>
To: Eric Christopher <echristo@redhat.com>
Cc: "H. J. Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com,
   GNU C Library
	 <libc-alpha@sources.redhat.com>,
   binutils@sources.redhat.com
In-Reply-To: <1025575632.30577.64.camel@ghostwheel.cygnus.com>
References: <20020701184640.A2043@lucon.org> 
	<1025575632.30577.64.camel@ghostwheel.cygnus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Jul 2002 20:09:59 -0700
Message-Id: <1025579401.1785.0.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
X-Spam-Status: No, hits=-3.5 required=5.0 tests=IN_REP_TO,FROM_AND_TO_SAME version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> AFAIK it happens to mozilla as well.
> 
> Guh.

There are a few different possible solutions, one is to do the
-fPIC/-fpic split, another is to copy to SGI multigot, I'm sure there
are other solutions as well...

-eric

-- 
I will not carve gods
