Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PFJQnC023249
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 08:19:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PFJQ3B023248
	for linux-mips-outgoing; Tue, 25 Jun 2002 08:19:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ocean.lucon.org (12-234-143-38.client.attbi.com [12.234.143.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PFJNnC023245
	for <linux-mips@oss.sgi.com>; Tue, 25 Jun 2002 08:19:23 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 2AFE8125D1; Tue, 25 Jun 2002 08:22:47 -0700 (PDT)
Date: Tue, 25 Jun 2002 08:22:46 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Carsten Lange <Carsten.Lange@detewe.de>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: mipsel-linux-gdb(5.2): DW_FORM_strp pointing outside of .debug_str section
Message-ID: <20020625082246.A18907@lucon.org>
References: <3D171ECB.28F566C1@detewe.de> <20020624150001.GA5373@branoic.them.org> <20020624081221.C30482@lucon.org> <20020625131608.GB13216@branoic.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020625131608.GB13216@branoic.them.org>; from dan@debian.org on Tue, Jun 25, 2002 at 09:16:08AM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 25, 2002 at 09:16:08AM -0400, Daniel Jacobowitz wrote:
> > 
> > Please get the Linux binutils 2.12.90.0.12. You need that for gcc 3.1
> > on Linux/mips.
> 
> Would you mind explaining what binutils patch affected the DW_FORM_strp
> problems?  Was it a SEC_MERGE bug that I recall being recently
> discussed.

Yes:

http://sources.redhat.com/ml/binutils/2002-06/msg00111.html

Please test it as much as you can. I want to make sure it is 100%
correct. Also as Daniel said, you need gcc 3.1 branch from CVS to
get gdb working with dwarf.


H.J.
