Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3IGVD8d031500
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Apr 2002 09:31:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3IGVDSm031499
	for linux-mips-outgoing; Thu, 18 Apr 2002 09:31:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc53.attbi.com (rwcrmhc53.attbi.com [204.127.198.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3IGVB8d031495
	for <linux-mips@oss.sgi.com>; Thu, 18 Apr 2002 09:31:11 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc53.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020418163209.SIWC12144.rwcrmhc53.attbi.com@ocean.lucon.org>;
          Thu, 18 Apr 2002 16:32:09 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 9B007125C2; Thu, 18 Apr 2002 09:32:08 -0700 (PDT)
Date: Thu, 18 Apr 2002 09:32:08 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc: linux-mips@oss.sgi.com
Subject: Re: Update of RedHat 7.1/mips
Message-ID: <20020418093208.B20868@lucon.org>
References: <20020417210843.A10182@lucon.org> <3CBE96CD.43620756@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3CBE96CD.43620756@niisi.msk.ru>; from raiko@niisi.msk.ru on Thu, Apr 18, 2002 at 01:50:05PM +0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Apr 18, 2002 at 01:50:05PM +0400, Gleb O. Raiko wrote:
> Hi,
> 
> "H . J . Lu" wrote:
> > 
> > FYI, I updated a few packages in RedHat 7.1/mips. It has new gcc,
> > glibc, binutils and gdb.
> 
> Will your glibc work on r3k (w/o ll, sc, double word instructions)? Or
> you just don't care about 3rd class processors? 
> 

I didn't compile anything with -mipsN. But I don't have a r3k to test.


H.J.
