Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7OGDdZ17789
	for linux-mips-outgoing; Fri, 24 Aug 2001 09:13:39 -0700
Received: from snfc21.pbi.net (mta6.snfc21.pbi.net [206.13.28.240])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7OGDbd17786
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 09:13:37 -0700
Received: from pacbell.net ([63.194.214.47])
 by mta6.snfc21.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GIK003D6YEN9F@mta6.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Fri, 24 Aug 2001 09:13:36 -0700 (PDT)
Date: Fri, 24 Aug 2001 09:13:21 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: Re: arch/mips/pci* stuff
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Reply-to: ppopov@pacbell.net
Message-id: <3B867D21.50007@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
References: <3B862487.EF22D143@niisi.msk.ru>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Gleb O. Raiko wrote:

> Hello,
> 
> Could somebody, please, explain me what arch/mips/pci* stuff is for? My
> understanding is drivers/pci code shall setup everything except proper
> placing in PCI MEM/IO spaces and irqs. The code in arch/mips/pci*
> contains much more.
> 
> Anyway, drivers/pci code provides enough fixup interface, doesn't it ?
> 
> BTW, if the code in arch/mips/pci* is really required how about
> fine-grained placing, like in sparc64?

I assume you're talking about the new arch/mips/kernel/pci* code?  Yes, there's 
is duplication in arch/mips/kernel/pci.c and what's in drivers/pci. However, 
there wasn't a single complete function for mips that would get the job done. 
The result was that every single board with pci support did its own thing and it 
was getting ugly very quickly. Just search through all the embedded boards 
directories and you'll see what I'm talking about. The other important new file 
is arch/mips/kernel/pci_auto.c. If you enable pci auto in config.in, the pci 
resources will be assigned by pci_auto.c. Thus, you don't need to rely on boot 
code to do that anymore, which I think is a good thing.

Pete
