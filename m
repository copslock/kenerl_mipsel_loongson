Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PDCmnC020930
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 06:12:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PDCmhK020929
	for linux-mips-outgoing; Tue, 25 Jun 2002 06:12:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from crack.them.org (mail@crack.them.org [65.125.64.184])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PDChnC020926
	for <linux-mips@oss.sgi.com>; Tue, 25 Jun 2002 06:12:44 -0700
Received: from cs2876-108.austin.rr.com ([24.28.76.108] helo=branoic)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17MqAg-00016l-00; Tue, 25 Jun 2002 08:15:51 -0500
Received: from drow by branoic with local (Exim 3.35 #1 (Debian))
	id 17MqAB-0003RV-00; Tue, 25 Jun 2002 09:15:19 -0400
Date: Tue, 25 Jun 2002 09:15:18 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Carsten Lange <Carsten.Lange@detewe.de>
Cc: "H. J. Lu" <hjl@lucon.org>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: mipsel-linux-gdb(5.2): DW_FORM_strp pointing outside of .debug_str section
Message-ID: <20020625131518.GA13216@branoic.them.org>
References: <3D171ECB.28F566C1@detewe.de> <20020624150001.GA5373@branoic.them.org> <20020624081221.C30482@lucon.org> <3D184EAC.D8C8CBA6@detewe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D184EAC.D8C8CBA6@detewe.de>
User-Agent: Mutt/1.3.28i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 25, 2002 at 01:06:20PM +0200, Carsten Lange wrote:
> Hi,
> 
> when I use binutils 2.12.90.0.12 gcc 3.1 will not compile anymore.

Yes.  At this time you'll need to use a GCC on the 3.1 CVS branch to
get around this problem.


-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
