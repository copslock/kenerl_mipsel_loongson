Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5EJtpH13540
	for linux-mips-outgoing; Thu, 14 Jun 2001 12:55:51 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5EJtoP13536
	for <linux-mips@oss.sgi.com>; Thu, 14 Jun 2001 12:55:50 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id C1B8D125BA; Thu, 14 Jun 2001 12:55:49 -0700 (PDT)
Date: Thu, 14 Jun 2001 12:55:49 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Richard Henderson <rth@redhat.com>
Cc: gcc@gcc.gnu.org, binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: DWARF2 exception doesn't work with gcc and gas on MIPS.
Message-ID: <20010614125549.A4375@lucon.org>
References: <20010613212940.A22683@lucon.org> <20010614101951.B28824@redhat.com> <20010614114117.A3092@lucon.org> <20010614120543.B28888@redhat.com> <20010614122550.B3668@lucon.org> <20010614124255.C28888@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010614124255.C28888@redhat.com>; from rth@redhat.com on Thu, Jun 14, 2001 at 12:42:55PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jun 14, 2001 at 12:42:55PM -0700, Richard Henderson wrote:
> On Thu, Jun 14, 2001 at 12:25:50PM -0700, H . J . Lu wrote:
> > 1. I see PIC_FUNCTION_ADDR_REGNUM be $25. gp is $28.  How does your
> > patch restore $28?
> 
> That should be pic_offset_table_rtx instead.
> 

I used

operands[0] = pic_offset_table_rtx;

It seems to work for me.

Thanks a lot.


H.J.
