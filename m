Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3D0dZ8d030952
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Apr 2002 17:39:35 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3D0dZG4030951
	for linux-mips-outgoing; Fri, 12 Apr 2002 17:39:35 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from buzz.ichilton.co.uk (pc1-stocb3-0-cust156.mid.cable.ntl.com [80.4.62.156])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3D0dW8d030948
	for <linux-mips@oss.sgi.com>; Fri, 12 Apr 2002 17:39:32 -0700
Received: by buzz.ichilton.co.uk (Postfix, from userid 100)
	id A34151CE3CA; Sat, 13 Apr 2002 01:40:09 +0100 (BST)
Date: Sat, 13 Apr 2002 01:40:09 +0100
From: Ian Chilton <mailinglist@ichilton.co.uk>
To: Stuart Hughes <stuarth@zentropix.com>
Cc: Scott A McConnell <samcconn@cotw.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Can modules be stripped?
Message-ID: <20020413004009.GE897@buzz.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mail-Followup-To: Stuart Hughes <stuarth@zentropix.com>,
	Scott A McConnell <samcconn@cotw.com>,
	"MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
References: <3CB71C48.B768A40D@cotw.com> <3CB711CD.83F65C13@zentropix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CB711CD.83F65C13@zentropix.com>
User-Agent: Mutt/1.3.28i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

> Be careful what you strip.  I found the safest thing was to use 'strip
> -g'

I always use strip --strip-debug


Bye for Now,

Ian


-----------------------------
 Ian Chilton
 E-Mail: ian@ichilton.co.uk
-----------------------------
