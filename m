Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9D5slc06448
	for linux-mips-outgoing; Fri, 12 Oct 2001 22:54:47 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9D5seD06445
	for <linux-mips@oss.sgi.com>; Fri, 12 Oct 2001 22:54:40 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 14936125C0; Fri, 12 Oct 2001 22:54:33 -0700 (PDT)
Date: Fri, 12 Oct 2001 22:54:33 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Jun Sun <jsun@mvista.com>
Cc: Dan Aizenstros <dan@quicklogic.com>, Hanks Li <hli@quicklogic.com>,
   linux-mips@oss.sgi.com
Subject: Re: Big endian problem
Message-ID: <20011012225433.A10523@lucon.org>
References: <APEOLACBIPNAFKJDDFIIIEBLCBAA.hli@quicklogic.com> <3BC72CCC.3604FEC8@mvista.com> <3BC74EFE.9020109@quicklogic.com> <20011012173552.B3689@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011012173552.B3689@mvista.com>; from jsun@mvista.com on Fri, Oct 12, 2001 at 05:35:52PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Oct 12, 2001 at 05:35:52PM -0700, Jun Sun wrote:
> On Fri, Oct 12, 2001 at 04:13:50PM -0400, Dan Aizenstros wrote:
> > Hello Jun,
> > 
> > The file is the common time.c from linux/arch/mips/kernel as you
> > can see from the third to last line of Hanshi's email.  The tools
> > he is using are from H. J. Lu's RedHat 7.1 RPMs on the oss.sgi.com
> > ftp site.  The file compiles just fine with the little endian version
> > of the same tools from the same place.
> > 
> > Hanshi and I will look at the USECS_PER_JIFFY_FRAC macro.  Thanks for
> > the pointer.
> > 
> > -- Dan A.
> >
> 
> It is indeed a strange problem as it only shows up in BE tools.  
> Some tool gurus want to look into it?
> 
> Meanwhile the following patch seems to fix it (and a couple of other
> time.c files)
> 
> Jun 

This is what I sent out in July.


H.J.
----
From hjl@lucon.org Tue Jul 24 13:25:34 2001
Date: Tue, 24 Jul 2001 13:25:34 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: GCC and Modules
Message-ID: <20010724132534.A25416@lucon.org>
References: <25369470B6F0D41194820002B328BDD27D2E@ATLOPS> <20010724085544.A20610@lucon.org> <995995907.1331.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <995995907.1331.5.camel@localhost.localdomain>; from marc_karasek@ivivity.com on Tue, Jul 24, 2001 at 01:31:41PM -0400
Status: RO
Content-Length: 954
Lines: 29

On Tue, Jul 24, 2001 at 01:31:41PM -0400, Marc Karasek wrote:
> The way to see this bug is just try to compile the MIPS kernel (either
> 2.4.1 or 2.4.3) as follows:
> 
> 1) make distclean
> 2) copy linux/arch/mips/defconfig-malta linux/.config
> 3) make oldconfig
> 4) make menuconfig
> 5) change the endianess from little to big
> 6) make dep 
> 7) make zImage 
> 

That is a kernel bug. The code only works on littl endian by accident
Here is a patch.


H.J.
--- arch/mips/mips-boards/generic/time.c.int64	Tue Jul 24 13:21:21 2001
+++ arch/mips/mips-boards/generic/time.c	Tue Jul 24 13:22:02 2001
@@ -275,7 +275,7 @@ void __init time_init(void)
 
 /* This is for machines which generate the exact clock. */
 #define USECS_PER_JIFFY (1000000/HZ)
-#define USECS_PER_JIFFY_FRAC (0x100000000*1000000/HZ&0xffffffff)
+#define USECS_PER_JIFFY_FRAC ((long) (0x100000000*1000000/HZ&0xffffffff))
 
 /* Cycle counter value at the previous timer interrupt.. */
 
