Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8SH6bJ16926
	for linux-mips-outgoing; Fri, 28 Sep 2001 10:06:37 -0700
Received: from dea.linux-mips.net (lt200001.hrz.uni-oldenburg.de [134.106.156.150])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8SH6YD16923
	for <linux-mips@oss.sgi.com>; Fri, 28 Sep 2001 10:06:35 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8SH5ci32044;
	Fri, 28 Sep 2001 19:05:38 +0200
Date: Fri, 28 Sep 2001 19:05:38 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Keith Owens <kaos@melbourne.sgi.com>
Cc: Kjeld Borch Egevang <kjelde@mips.com>,
   linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: Re: gcc crash
Message-ID: <20010928190538.B31094@dea.linux-mips.net>
References: <Pine.LNX.4.30.0109271657250.1742-100000@coplin19.mips.com> <19900.1001680672@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <19900.1001680672@ocs3.intra.ocs.com.au>; from kaos@melbourne.sgi.com on Fri, Sep 28, 2001 at 10:37:52PM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Sep 28, 2001 at 10:37:52PM +1000, Keith Owens wrote:

> On Thu, 27 Sep 2001 16:59:47 +0200 (CEST), 
> Kjeld Borch Egevang <kjelde@mips.com> wrote:
> >When I compile the following function with "gcc -O2" the compiler crashes.
> >static float sp_f2l(float x)
> >{
> >    long l, *xl;
> >    float y;
> >
> >    xl = (void *)&y;
> >    l = x;
> >    *xl = l;
> >    return y;
> >}
> 
> You are breaking the C rules for data accesses.  Compile with
> -fno-strict-aliasing if you want to break the rules.  Or, and this is
> much better, use a union of long and float to "convert" one
> representation to another.

Yes said the compiler is crashing so that's definately a gcc bug.  Aside
of course of the code itself being buggy also.

  Ralf
