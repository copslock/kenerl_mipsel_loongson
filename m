Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6J17aRw011734
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Jul 2002 18:07:36 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6J17asZ011733
	for linux-mips-outgoing; Thu, 18 Jul 2002 18:07:36 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc51.attbi.com (rwcrmhc51.attbi.com [204.127.198.38])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6J17WRw011723
	for <linux-mips@oss.sgi.com>; Thu, 18 Jul 2002 18:07:32 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc51.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020719010803.OIGA24728.rwcrmhc51.attbi.com@ocean.lucon.org>;
          Fri, 19 Jul 2002 01:08:03 +0000
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id A8B93125D8; Thu, 18 Jul 2002 18:08:00 -0700 (PDT)
Received: by lucon.org (Postfix, from userid 1000)
	id 02289EC62; Thu, 18 Jul 2002 18:07:59 -0700 (PDT)
Date: Thu, 18 Jul 2002 18:07:59 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Malta bus error
Message-ID: <20020718180759.A2091@lucon.org>
References: <3D375B4C.9000403@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D375B4C.9000403@mvista.com>; from jsun@mvista.com on Thu, Jul 18, 2002 at 05:20:28PM -0700
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 18, 2002 at 05:20:28PM -0700, Jun Sun wrote:
> I got the following bus error on Malta.  Does anybody know what causes the 
> fault?  Is there anyway to disable the error?  Or we should install a malta 
> bus_error_handler() to discard this kind of error?
> 
> Apparently the error has something to do with the code layout as it only 
> happens when I start to modify an unrelated function( do_ri()).
> 
> I am using the latest linux_2_4 branch from oss.sgi.com CVS tree.
> 

I got zero problems with 2.4 kernel on oss as of Jul 11 08:18.


H.J.
