Received:  by oss.sgi.com id <S553782AbQJZOtI>;
	Thu, 26 Oct 2000 07:49:08 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:773 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553779AbQJZOsr>;
	Thu, 26 Oct 2000 07:48:47 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D4CEB8F5; Thu, 26 Oct 2000 16:48:43 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 42060900C; Thu, 26 Oct 2000 14:19:08 +0200 (CEST)
Date:   Thu, 26 Oct 2000 14:19:08 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
Cc:     Guido Guenther <guido.guenther@gmx.net>, linux-mips@oss.sgi.com
Subject: Re: fdisk/kernel oddity
Message-ID: <20001026141908.F399@paradigm.rfc822.org>
References: <20001025190129.A28426@bilbo.physik.uni-konstanz.de> <20001025101453.A11789@chem.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001025101453.A11789@chem.unr.edu>; from wesolows@chem.unr.edu on Wed, Oct 25, 2000 at 10:14:53AM -0700
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Oct 25, 2000 at 10:14:53AM -0700, Keith M Wesolowski wrote:
> 
> I rather suspect that this is the same problem that causes the request
> for the out-of-bounds block in the first place: kernel memory
> corruption. Unfortunately I have few ideas as to what the specific
> problem is. I would start bug-hunting in the sgi disklabel kernel
> parts. Make sure that it's compatible with what fdisk is doing.
> 

I agree here - This also would fit to the "Illegal Instruction" thing
he sees afterwards - It seems to be time to debug the kernel SGI Disklabel
support :)

Most interestingly i am running on an Indigo2 with 7 Disks attached 
and they all have SGI Disklabels - And i have no problems (Although
6 of the 7 have the exatly same geometrie)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
