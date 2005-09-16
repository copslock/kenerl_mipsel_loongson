Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Sep 2005 16:39:33 +0100 (BST)
Received: from father.pmc-sierra.com ([IPv6:::ffff:216.241.224.13]:52726 "HELO
	father.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225225AbVIPPha>; Fri, 16 Sep 2005 16:37:30 +0100
Received: (qmail 26363 invoked by uid 101); 16 Sep 2005 15:37:19 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by father.pmc-sierra.com with SMTP; 16 Sep 2005 15:37:19 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id j8GFbJJg013205
	for <linux-mips@linux-mips.org>; Fri, 16 Sep 2005 08:37:19 -0700
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <RMQMVC0S>; Fri, 16 Sep 2005 08:37:26 -0700
Message-ID: <5C1FD43E5F1B824E83985A74F396286E5E9483@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Don Hiatt <Don_Hiatt@pmc-sierra.com>
To:	linux-mips@linux-mips.org
Subject: Location of MIPS KDB Patch? 
Date:	Fri, 16 Sep 2005 08:38:42 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Don_Hiatt@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Don_Hiatt@pmc-sierra.com
Precedence: bulk
X-list: linux-mips


Howdy,

 I've included the response (hope Keith doesn't mind) I got about
the MIPS patch for KDB. Is there in fact a MIPS patch for KDB? According
to Sergey there is:

(http://www.linux-mips.org/archives/linux-mips/2005-08/msg00117.html)
>It works fine, I'm using it on NEC VR5701

>Best wishes,
>Sergey Podstavin.

On Mon, 2005-08-22 at 18:00 -0700, Knittel, Brian wrote:
> There are a couple of references to KDB in the archive, but nothing recent. 
> What is the state of KDB on MIPS?
>  
> Thanks,
> --Brian
> 
> 

Cheers,

don


-----Original Message-----
From: Keith Owens [mailto:kaos@sgi.com]
Sent: Thursday, September 15, 2005 5:01 PM
To: Don Hiatt
Cc: 'kdb@oss.sgi.com'
Subject: Re: Location of MIPS KDB Patch? 


On Thu, 15 Sep 2005 09:57:19 -0700, 
Don Hiatt <Don_Hiatt@pmc-sierra.com> wrote:
>  I was wondering where I could find the MIPS specific patch for
>KDB for 2.4.25? I've found the common-portions on the FTP site but
>seem to be missing the MIPS part. Sorry if this is detailed somewhere
>which I have likely overlooked. ;)

KDB has never been supported on MIPS.  Over the years several people
with MIPS hardware have said that they would have a go at it, but
nobody ever sent any patches.
