Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GG4tH00599
	for linux-mips-outgoing; Thu, 16 Aug 2001 09:04:55 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GG4sj00594
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 09:04:54 -0700
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id DDDC0125C4; Thu, 16 Aug 2001 09:04:52 -0700 (PDT)
Received: by lucon.org (Postfix, from userid 1000)
	id 06AB7EFC0; Thu, 16 Aug 2001 09:04:51 -0700 (PDT)
Date: Thu, 16 Aug 2001 09:04:51 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Brian Murphy <brian.murphy@eicon.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: glibc
Message-ID: <20010816090451.A3094@lucon.org>
References: <E15X7kU-000416-00@the-village.bc.nu> <3B7B8951.B666A175@eicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B7B8951.B666A175@eicon.com>; from brian.murphy@eicon.com on Thu, Aug 16, 2001 at 10:50:25AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 16, 2001 at 10:50:25AM +0200, Brian Murphy wrote:
> 
> We use 2.0.6 here because it is half the size of the newer glibcs and it seems
> 
> to work fine for us.
> 

I am working on sglibc. It has a smaller size by disabling selective
features.


H.J.
