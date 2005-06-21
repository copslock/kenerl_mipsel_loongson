Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2005 13:18:22 +0100 (BST)
Received: from web25801.mail.ukl.yahoo.com ([IPv6:::ffff:217.12.10.186]:42585
	"HELO web25801.mail.ukl.yahoo.com") by linux-mips.org with SMTP
	id <S8225195AbVFUMRw>; Tue, 21 Jun 2005 13:17:52 +0100
Received: (qmail 13644 invoked by uid 60001); 21 Jun 2005 12:17:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Bi+kktNfYbNDyRytf9kD9wELZgGu0iBl1jp1OoigQO+sW0FHYkzo1PO/88QQ2H/g1alnjhXJETA8Sh9q0eN8pAppUs9/2y/jJzDSQEhv5IGaxsDmi/oluRmZK4YrTZ3IlCOGofGf0PnVITUdgXFM1LbRfF/5wfsQGrgWFQhLapU=  ;
Message-ID: <20050621121744.13642.qmail@web25801.mail.ukl.yahoo.com>
Received: from [217.167.142.149] by web25801.mail.ukl.yahoo.com via HTTP; Tue, 21 Jun 2005 14:17:44 CEST
Date:	Tue, 21 Jun 2005 14:17:44 +0200 (CEST)
From:	moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: Using a hal lib in Linux.
To:	jbglaw@lug-owl.de
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

Jan-Benedict Glaw wrote:

>On Tue, 2005-06-21 11:14:28 +0200, moreau francis
<francis_moreau2000@yahoo.fr> wrote:
>
>>I've got a mips board provided with a library that deals with hardware
>>management.
>>This library have been compiled with "sde-lite" gcc. I'm thinking of using
this
>>lib into my linux drivers to speed up developement process. Has anyone made
>>kernel
>>modifications (specially in Makefiles) in order to link such hal lib into
>>kernel
>>code ?
>
>
>Well, usually consensus is to avoid HAL layers or libraries at about any
>price because they typically add speed penalties and binary-only code,
>which are both unacceptable.
>

Totally agree with you ! But I was wondering if it was possible for a first
implementation. I will try to rewrite drivers to avoid HAL layers once
everything will be set up. I'm just trying to get something working very
quickly, and the hardware seems to be a very unusual one...but once again I
totally agree with you.

Cheers,

     Francis




	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
