Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g67EY7Rw030693
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 7 Jul 2002 07:34:07 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g67EY7lm030692
	for linux-mips-outgoing; Sun, 7 Jul 2002 07:34:07 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc52.attbi.com (rwcrmhc52.attbi.com [216.148.227.88])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g67EY3Rw030683
	for <linux-mips@oss.sgi.com>; Sun, 7 Jul 2002 07:34:03 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc52.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020707143814.CIZX8262.rwcrmhc52.attbi.com@ocean.lucon.org>;
          Sun, 7 Jul 2002 14:38:14 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id E92A3125D5; Sun,  7 Jul 2002 07:38:13 -0700 (PDT)
Date: Sun, 7 Jul 2002 07:38:13 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
Cc: linux-mips@oss.sgi.com
Subject: Re: more on my slab problem
Message-ID: <20020707073813.B23481@lucon.org>
References: <Pine.LNX.4.21.0207071125420.645-100000@melkor> <Pine.LNX.4.21.0207071144000.747-100000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0207071144000.747-100000@melkor>; from vivien.chappelier@enst-bretagne.fr on Sun, Jul 07, 2002 at 11:44:56AM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jul 07, 2002 at 11:44:56AM +0200, Vivien Chappelier wrote:
> > This was with binutils 2.11.92.0.10.
> 
> Sorry, this was actually binutils 2.9.5
> 

That binutils is broken. The binutils in my RedHat/mips 7.1/7.3 should
be ok. If not, I'd like to see a testcase.


H.J.
