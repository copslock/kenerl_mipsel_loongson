Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2N1t9L03398
	for linux-mips-outgoing; Fri, 22 Mar 2002 17:55:09 -0800
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2N1t6q03395
	for <linux-mips@oss.sgi.com>; Fri, 22 Mar 2002 17:55:06 -0800
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id CAA23331;
	Sat, 23 Mar 2002 02:08:41 -0800
Subject: Re: [Linux-mips-kernel]io.h patch
From: Pete Popov <ppopov@mvista.com>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <04c901c1d20d$bfb061e0$5601010a@prefect>
References: <1016845916.24217.298.camel@zeus> 
	<04c901c1d20d$bfb061e0$5601010a@prefect>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 22 Mar 2002 18:02:12 -0800
Message-Id: <1016848932.24387.317.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2002-03-22 at 17:55, Bradley D. LaRonde wrote:
> 
> ----- Original Message -----
> From: "Pete Popov" <ppopov@mvista.com>
> To: "sforge" <linux-mips-kernel@lists.sourceforge.net>
> Sent: Friday, March 22, 2002 8:11 PM
> Subject: [Linux-mips-kernel]io.h patch
> 
> 
> > Some of the macros in io.h cause compile problems in some of the drivers
> > because of the do while syntax.  I don't see any good reason why we
> > can't make those macros inline functions.  Any objections to this patch?
> 
> I pester Ralf about this from time to time.  The standing objection is that
> some older gccs don't do inline well.

That's all true and, in fact, I had run into a compiler problem some
time ago.  However, even then I was able to simply rearrange my C
routine a bit and then the compiler was happy.

Having pci-cardbus support on mips is kind of cool. Running wireless
cards off of it is even better.  Not being able to compile the drivers
because of io.h isn't.

Pete
