Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6SFVQRw011137
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 28 Jul 2002 08:31:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6SFVQfn011136
	for linux-mips-outgoing; Sun, 28 Jul 2002 08:31:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc51.attbi.com (rwcrmhc51.attbi.com [204.127.198.38])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6SFVLRw011127
	for <linux-mips@oss.sgi.com>; Sun, 28 Jul 2002 08:31:21 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc51.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020728153234.YYSH24728.rwcrmhc51.attbi.com@ocean.lucon.org>;
          Sun, 28 Jul 2002 15:32:34 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id D955B125D2; Sun, 28 Jul 2002 08:32:33 -0700 (PDT)
Date: Sun, 28 Jul 2002 08:32:33 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: renwei <renwei@huawei.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: mipsel-gcc sick with #pragma?
Message-ID: <20020728083233.A25490@lucon.org>
References: <001b01c2360d$07aabd20$690d6e0a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <001b01c2360d$07aabd20$690d6e0a@huawei.com>; from renwei@huawei.com on Sun, Jul 28, 2002 at 04:01:41PM +0800
X-Spam-Status: No, hits=-3.9 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK,TO_LOCALPART_EQ_REAL version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jul 28, 2002 at 04:01:41PM +0800, renwei wrote:
> my cross gcc is :
> `    
>  mipsel-linux-gcc -v
> 
> gcc version 2.95.3 19991030 (prerelease)
> 

Works fine with gcc 2.96-110.1 and gcc 3.1.1 20020717.


H.J.
