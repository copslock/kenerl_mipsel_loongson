Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2006 18:11:07 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:1182 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8134029AbWFPRK6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Jun 2006 18:10:58 +0100
Received: (qmail 23516 invoked by uid 101); 16 Jun 2006 17:10:45 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by father.pmc-sierra.com with SMTP; 16 Jun 2006 17:10:45 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k5GHAdld019226;
	Fri, 16 Jun 2006 10:10:40 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF7CW0A>; Fri, 16 Jun 2006 10:10:39 -0700
Message-ID: <9328C220997E4E448CC833AF1AB402DA0344D906@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Shane McDonald <Shane_McDonald@pmc-sierra.com>
To:	"'Jean Delvare'" <khali@linux-fr.org>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: RE: i2c-algo-ite and i2c-ite planned for removal
Date:	Fri, 16 Jun 2006 10:10:33 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Shane_McDonald@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Shane_McDonald@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi:

  PMC-Sierra has an eval board (the "Xiao Hu") that uses these files.  We haven't (yet) pushed out patches to add support for this board, but we hope to at some time.  The kernel we use on the board is based on 2.6.14, so I could generate a patch so that these files will compile against 2.6.14.  I'm guessing the patch will also apply to 2.6.16.20, since these files haven't changed for so long.

  I'll put together the patch and make sure it's still correct against 2.6.16.20, then submit it.

Shane

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Jean Delvare
> Sent: Thursday, June 15, 2006 2:57 PM
> To: linux-mips@linux-mips.org; LKML
> Subject: i2c-algo-ite and i2c-ite planned for removal
> 
> Hi all,
> 
> I noticed today that we have an i2c bus driver named i2c-ite,
> supposedly useful on some MIPS systems which have an ITE8172 chip,
> which doesn't compile. It is based on an i2c algorithm driver named
> i2c-algo-ite, which doesn't compile either, due to some 
> changes made to
> the i2c core which weren't properly reflected there. Going back trough
> the versions, I found that the bus driver was previously named
> i2c-adap-ite, and was introduced in 2.4.10. And I don't think it even
> compiled back then either, as it uses a structure (iic_ite) 
> which isn't
> defined anywhere.
> 
> So basically we have two drivers in the kernel tree for 5 years or so,
> which never were usable, and nobody seemed to care. It's about time to
> get rid of these 1296 lines of code, don't you think? So, 
> unless someone
> volunteers to take care of these drivers, or otherwise has a very
> strong reason to object, I'm going to delete them from the tree soon.
> 
> Thanks,
> -- 
> Jean Delvare
> 
