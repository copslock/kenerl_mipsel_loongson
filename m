Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f92GENo19311
	for linux-mips-outgoing; Tue, 2 Oct 2001 09:14:23 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f92GELD19308
	for <linux-mips@oss.sgi.com>; Tue, 2 Oct 2001 09:14:21 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 4BBF1125C8; Tue,  2 Oct 2001 09:14:20 -0700 (PDT)
Date: Tue, 2 Oct 2001 09:14:19 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Robin Humble <rjh@groucho.maths.monash.edu.au>
Cc: linux-mips@oss.sgi.com, roger_twede@hp.com
Subject: Re: Bug in pthread glibc 7.0 & 7.1
Message-ID: <20011002091419.B32338@lucon.org>
References: <20011001171003.A18883@lucon.org> <200110021209.MAA23706@groucho.maths.monash.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110021209.MAA23706@groucho.maths.monash.edu.au>; from rjh@groucho.maths.monash.edu.au on Tue, Oct 02, 2001 at 10:09:25PM +1000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Oct 02, 2001 at 10:09:25PM +1000, Robin Humble wrote:
> Also I found I could only build X natively on the Indy by disabling the
> pthreads parts; and maybe it's a similar 'Illegal Instruction' error in
> the 'conftest' program that seems to be stopping mozilla from building??
> (at least under kernel 2.4.3 which otherwise seems more stable than 2.4.8)
> 

My impression is 2.4.3 is more stable than 2.4.5. I haven't tried
2.4.8 yet.


H.J.
