Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PDDSnC020964
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 06:13:28 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PDDSut020963
	for linux-mips-outgoing; Tue, 25 Jun 2002 06:13:28 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from crack.them.org (mail@crack.them.org [65.125.64.184])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PDDMnC020960
	for <linux-mips@oss.sgi.com>; Tue, 25 Jun 2002 06:13:22 -0700
Received: from cs2876-108.austin.rr.com ([24.28.76.108] helo=branoic)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17MqBT-00016s-00; Tue, 25 Jun 2002 08:16:39 -0500
Received: from drow by branoic with local (Exim 3.35 #1 (Debian))
	id 17MqAz-0003TV-00; Tue, 25 Jun 2002 09:16:09 -0400
Date: Tue, 25 Jun 2002 09:16:08 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Carsten Lange <Carsten.Lange@detewe.de>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: mipsel-linux-gdb(5.2): DW_FORM_strp pointing outside of .debug_str section
Message-ID: <20020625131608.GB13216@branoic.them.org>
References: <3D171ECB.28F566C1@detewe.de> <20020624150001.GA5373@branoic.them.org> <20020624081221.C30482@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020624081221.C30482@lucon.org>
User-Agent: Mutt/1.3.28i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 24, 2002 at 08:12:21AM -0700, H. J. Lu wrote:
> On Mon, Jun 24, 2002 at 11:00:01AM -0400, Daniel Jacobowitz wrote:
> > On Mon, Jun 24, 2002 at 03:29:47PM +0200, Carsten Lange wrote:
> > > Hi,
> > > 
> > > I get the above error from gdb 5.2 when using the <file> command.
> > > ...
> > > (gdb) file iprbs
> > > file iprbs
> > > Reading symbols from iprbs...DW_FORM_strp pointing outside of .debug_str section
> > > (gdb)                                                       
> > > ...
> > > 
> > > My mipsel-linux- toolchain consist of the following packages:
> > > 	binutils-2.12.1
> > > 	gcc-3.1
> > > 	glibc-2.2.5
> > > 	gdb-5.2
> > > 
> > > I have no idea what the problem might be.
> > > 
> > > Any hints (solutions/workaround) are welcome.
> > 
> > Can you produce a testcase?  These versions of the tools should not
> > show the problem, assuming you rebuilt everything using them.
> > 
> 
> Please get the Linux binutils 2.12.90.0.12. You need that for gcc 3.1
> on Linux/mips.

Would you mind explaining what binutils patch affected the DW_FORM_strp
problems?  Was it a SEC_MERGE bug that I recall being recently
discussed.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
