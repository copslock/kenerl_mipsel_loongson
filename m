Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 19:27:09 +0000 (GMT)
Received: from bes.cs.utk.edu ([160.36.56.220]:34272 "EHLO bes.cs.utk.edu")
	by ftp.linux-mips.org with ESMTP id S3468182AbWAST0v (ORCPT
	<rfc822;Linux-mips@linux-mips.org>); Thu, 19 Jan 2006 19:26:51 +0000
Received: from localhost (bes [127.0.0.1])
	by bes.cs.utk.edu (Postfix) with ESMTP id 8FB0C273B0;
	Thu, 19 Jan 2006 14:30:37 -0500 (EST)
Received: from bes.cs.utk.edu ([127.0.0.1])
 by localhost (bes [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26487-02; Thu, 19 Jan 2006 14:30:36 -0500 (EST)
Received: from dhcp-221-85.pdc.kth.se (dhcp-221-85.pdc.kth.se [130.237.221.85])
	by bes.cs.utk.edu (Postfix) with ESMTP id AEFAC273A5;
	Thu, 19 Jan 2006 14:30:35 -0500 (EST)
Subject: Re: [perfmon] Re: 2.6.13-rc2 perfmon2 new code base with
	MIPS5K/20K support + libpfm available
From:	Philip Mucci <mucci@cs.utk.edu>
To:	eranian@hpl.hp.com
Cc:	perfmon@napali.hpl.hp.com, Linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20060119191403.GV19622@frankl.hpl.hp.com>
References: <1137666602.6648.80.camel@localhost.localdomain>
	 <20060119133609.GA3398@linux-mips.org>
	 <20060119181608.GP19622@frankl.hpl.hp.com>
	 <1137695936.6648.268.camel@localhost.localdomain>
	 <20060119191403.GV19622@frankl.hpl.hp.com>
Content-Type: text/plain
Organization: Innovative Computing Laboratory
Date:	Thu, 19 Jan 2006 20:30:33 +0100
Message-Id: <1137699033.15290.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new with ClamAV and SpamAssasin at cs.utk.edu
Return-Path: <mucci@cs.utk.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;Linux-mips@linux-mips.org
Original-Recipient: rfc822;Linux-mips@linux-mips.org
X-archive-position: 10003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mucci@cs.utk.edu
Precedence: bulk
X-list: linux-mips

Yup...just looked at the code...should be simple to adapt...I'll give it
a spin on perfmon2...the only thing that seems to be obviously wrong are
the missing arguments to PFM_CREATE_CONTEXT.

Phil

On Thu, 2006-01-19 at 11:14 -0800, Stephane Eranian wrote:
> Phil,
> 
> On Thu, Jan 19, 2006 at 07:38:56PM +0100, Philip Mucci wrote:
> > Stefane,
> > 
> > Are you saying that oprofile user level tools don't even use the
> > oprofile driver but rather just set up a system-wide IP-sampling context
> > for perfmon2?
> > 
> Yes, I think that is the way this works. I will verify this.
> 
> > Think of all the work that Ralf just did. ;-)
> > 
> If you don't have perfmon2, then you have to provide you arch/mips/oprofile
> files for sure.
> _______________________________________________
> perfmon mailing list
> perfmon@linux.hpl.hp.com
> http://www.hpl.hp.com/hosted/linux/mail-archives/perfmon/
