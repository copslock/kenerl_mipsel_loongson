Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PFa4nC023662
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 08:36:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PFa4Mr023661
	for linux-mips-outgoing; Tue, 25 Jun 2002 08:36:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ocean.lucon.org (12-234-143-38.client.attbi.com [12.234.143.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PFa2nC023658
	for <linux-mips@oss.sgi.com>; Tue, 25 Jun 2002 08:36:02 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 944C1125D1; Tue, 25 Jun 2002 08:39:26 -0700 (PDT)
Date: Tue, 25 Jun 2002 08:39:26 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Carsten Lange <Carsten.Lange@detewe.de>
Cc: Daniel Jacobowitz <dan@debian.org>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: mipsel-linux-gdb(5.2): DW_FORM_strp pointing outside of .debug_str section
Message-ID: <20020625083926.E18907@lucon.org>
References: <3D171ECB.28F566C1@detewe.de> <20020624150001.GA5373@branoic.them.org> <20020624081221.C30482@lucon.org> <3D184EAC.D8C8CBA6@detewe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D184EAC.D8C8CBA6@detewe.de>; from Carsten.Lange@detewe.de on Tue, Jun 25, 2002 at 01:06:20PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 25, 2002 at 01:06:20PM +0200, Carsten Lange wrote:
> Hi,
> 
> when I use binutils 2.12.90.0.12 gcc 3.1 will not compile anymore.
> 

You need gcc 3.1 from CVS. I may be able to provide a gcc 3.1.1 rpm for
RedHat 7.3/mips with the java support. Is anyone interested?


H.J.
