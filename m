Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2QJPfG00583
	for linux-mips-outgoing; Mon, 26 Mar 2001 11:25:41 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2QJPfM00578
	for <linux-mips@oss.sgi.com>; Mon, 26 Mar 2001 11:25:41 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f2QJLK015199;
	Mon, 26 Mar 2001 11:21:20 -0800
Message-ID: <3ABF9683.1D08617B@mvista.com>
Date: Mon, 26 Mar 2001 11:20:35 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: carlson@sibyte.com, Matthew Dharm <mdharm@momenco.com>,
   linux-mips@oss.sgi.com
Subject: Re: Multiple processor support?
References: <NEBBLJGMNKKEEMNLHGAIKELLCAAA.mdharm@momenco.com> <01032316143609.00779@plugh.sibyte.com> <01b801c0b3fb$1770b740$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Kevin D. Kissell" wrote:
> 
> (Software cache coherency) It is possible,
> but tricky, and at times unavoidably inefficient to build a
> software-coherent SMP system.  I have not heard of anyone
> doing so with MIPS/Linux.
>

How would it be possible?  Any reference to the previous implementations?

I imagine you would need at least some kind of atomic operation (like ll/sc)
working reliably (which itself may require cache coherency).  Also, any such
scheme should not require massive change in the programming.

I am very curious....

Jun
