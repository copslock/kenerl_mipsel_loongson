Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6B4c5m07868
	for linux-mips-outgoing; Tue, 10 Jul 2001 21:38:05 -0700
Received: from snfc21.pbi.net (mta6.snfc21.pbi.net [206.13.28.240])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6B4c3V07865
	for <linux-mips@oss.sgi.com>; Tue, 10 Jul 2001 21:38:03 -0700
Received: from pacbell.net ([63.194.214.47])
 by mta6.snfc21.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GGA006FOKVAHB@mta6.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Tue, 10 Jul 2001 21:38:02 -0700 (PDT)
Date: Tue, 10 Jul 2001 21:36:36 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: Re: USB OHCI on 2.4.2 kernel using r4k processor
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: linux-mips@oss.sgi.com
Reply-to: ppopov@pacbell.net
Message-id: <3B4BD7D4.1060003@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
References: <20010710194526.44019.qmail@web11906.mail.yahoo.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Wayne Gowcher wrote:

> Dear All,
> 
> Has anyone got USB OHCI running on a 2.4.2 kernel with
> a mips r4k processor ?


Yes, on a couple of different boards.  
 
> I have successfully used the above with a r3k mips
> processor but now after porting the same base code to
> a r4k processor the kernel throws an OOPS.
> 
> I believe the problem may lay with the writeback cache
> because when I disable the d cache on the r4k 2.4.2
> kernel USB works fine !
 
> I did some digging around and noted that the working
> aic7xxx driver I have on the 2.4.2 r4k makes use of
> pci_map_single to handle cache flushing ( ??? please
> correct me if I am wrong ) and that this type of code
> doesn't make it into the usb code until 2.4.4 of the
> sgi linux kernel.
 
> Does anyone have a "back patch" to apply to the 2.4.2
> usb code ?
 
> If not I am thinking of attempting this myself and
> would welcome any comments / advice about doing this


Steve at MontaVista did the usb work for mips about six months ago on an 
ITE 8172 board. Since then we've also ported it to the Alchemy Au1000 
board, both running on 2.4.2.  He forwarded all patches to the usb 
maintainer but it looks like it took a bit of time for all the patches 
to be applied.  I don't know if we still have patches against the 2.4.2 
tree.  One thing you can do is next Monday check our ftp site (HHL2.0 
for mips should be released by early next week), grab the generic HHL2.0 
mips kernel, and diff all the usb code against the stock 2.4.2. I don't 
think it would be too bad of a job.

Pete
