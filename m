Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OF97nC032434
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 08:09:07 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OF97IL032433
	for linux-mips-outgoing; Mon, 24 Jun 2002 08:09:07 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ocean.lucon.org (12-234-143-38.client.attbi.com [12.234.143.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OF92nC032430
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 08:09:02 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id E1D4D125D1; Mon, 24 Jun 2002 08:12:21 -0700 (PDT)
Date: Mon, 24 Jun 2002 08:12:21 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Carsten Lange <Carsten.Lange@detewe.de>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: mipsel-linux-gdb(5.2): DW_FORM_strp pointing outside of .debug_str section
Message-ID: <20020624081221.C30482@lucon.org>
References: <3D171ECB.28F566C1@detewe.de> <20020624150001.GA5373@branoic.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020624150001.GA5373@branoic.them.org>; from dan@debian.org on Mon, Jun 24, 2002 at 11:00:01AM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 24, 2002 at 11:00:01AM -0400, Daniel Jacobowitz wrote:
> On Mon, Jun 24, 2002 at 03:29:47PM +0200, Carsten Lange wrote:
> > Hi,
> > 
> > I get the above error from gdb 5.2 when using the <file> command.
> > ...
> > (gdb) file iprbs
> > file iprbs
> > Reading symbols from iprbs...DW_FORM_strp pointing outside of .debug_str section
> > (gdb)                                                       
> > ...
> > 
> > My mipsel-linux- toolchain consist of the following packages:
> > 	binutils-2.12.1
> > 	gcc-3.1
> > 	glibc-2.2.5
> > 	gdb-5.2
> > 
> > I have no idea what the problem might be.
> > 
> > Any hints (solutions/workaround) are welcome.
> 
> Can you produce a testcase?  These versions of the tools should not
> show the problem, assuming you rebuilt everything using them.
> 

Please get the Linux binutils 2.12.90.0.12. You need that for gcc 3.1
on Linux/mips.


H.J.
