Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7Kcj022191
	for linux-mips-outgoing; Fri, 7 Dec 2001 12:38:45 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7Kcio22188
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 12:38:44 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id fB7JcfA04410;
	Fri, 7 Dec 2001 14:38:41 -0500
Date: Fri, 7 Dec 2001 14:38:41 -0500
From: Jim Paris <jim@jtan.com>
To: balaji.ramalingam@philips.com
Cc: linux-mips@oss.sgi.com
Subject: Re: not getting the kernel prompt
Message-ID: <20011207143841.A4403@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <OFBC8C65B4.81E473E6-ON08256B1B.006A7240@diamond.philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFBC8C65B4.81E473E6-ON08256B1B.006A7240@diamond.philips.com>; from balaji.ramalingam@philips.com on Fri, Dec 07, 2001 at 11:36:43AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Warning:  unable to open an initial console.

Make sure you have a valid /dev/console (or just use devfs)

-jim
