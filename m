Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA1Mopt23700
	for linux-mips-outgoing; Thu, 1 Nov 2001 14:50:51 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA1Mon023697
	for <linux-mips@oss.sgi.com>; Thu, 1 Nov 2001 14:50:49 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fA1MqSB08371;
	Thu, 1 Nov 2001 14:52:28 -0800
Message-ID: <3BE1D1C0.E32905BA@mvista.com>
Date: Thu, 01 Nov 2001 14:50:40 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Scott A McConnell <samcconn@cotw.com>
CC: linux-mips@oss.sgi.com
Subject: Re: [Fwd: Kernel panic: Caught reserved exception - should not happen.]
References: <3BE15781.73CE64DD@cotw.com> <20011101093158.C26148@mvista.com> <3BE1C8F4.ECEDC840@cotw.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Scott A McConnell wrote:
> 
> Jun Sun wrote:
> 
> > Try the following patch.  It is outdated, and it may not apply cleanly.
> > But you should get an idea about the intention of the fix.
> >
> > Please let me know the result.
> 
> It looks like a winner to me.

*sigh* We need another ugly #ifdef in the head.S file.

> You wouldn't happen to have knowledge of some patches that fix pthreads?

glibc 2.2 does not have pthread problems, at least not the one in monta vista
journeyman distribution.

There are several problems in glibc 2.0.6.  But I hope you are not looking for
them. :-)

Jun
