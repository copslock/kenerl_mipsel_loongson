Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2004 21:50:01 +0100 (BST)
Received: from noc.mainstreet.net ([IPv6:::ffff:207.5.0.45]:56078 "EHLO
	noc.mainstreet.net") by linux-mips.org with ESMTP
	id <S8226020AbUENUt7>; Fri, 14 May 2004 21:49:59 +0100
Received: from mail.idt.com (mail.idt.com [157.165.5.20])
	by noc.mainstreet.net (8.12.10/8.12.10) with ESMTP id i4EKnuOr018450;
	Fri, 14 May 2004 13:49:56 -0700 (PDT)
Received: from corpml2.corp.idt.com (firewall-user@supercop4.idt.com [157.165.5.10])
	by mail.idt.com (8.9.3/8.9.3) with ESMTP id NAA08430;
	Fri, 14 May 2004 13:50:06 -0700 (PDT)
Received: from CORPBRIDGE.corp.idt.com (corpexchange1.corp.idt.com [157.165.140.83])
	by corpml2.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id i4EKnrv04087;
	Fri, 14 May 2004 13:49:53 -0700 (PDT)
Received: by corpbridge.corp.idt.com with Internet Mail Service (5.5.2655.55)
	id <KNJAZG6A>; Fri, 14 May 2004 13:49:53 -0700
Message-ID: <73943A6B3BEAA1468EE1A4A090129F43742773@corpbridge.corp.idt.com>
From: "Tiwari, Rakesh" <Rakesh.Tiwari@idt.com>
To: "'Pete Popov'" <ppopov@mvista.com>,
	"Tiwari, Rakesh" <Rakesh.Tiwari@idt.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: RE: Adding support for new BSP
Date: Fri, 14 May 2004 13:49:51 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain
Return-Path: <Rakesh.Tiwari@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rakesh.Tiwari@idt.com
Precedence: bulk
X-list: linux-mips

Thanks Ralf and Pete.

I will check for the Coding Style compliance and mail you the 
patch sometime next week.

Thanks
Rakesh


-----Original Message-----
From: Pete Popov [mailto:ppopov@mvista.com] 
Sent: Friday, May 14, 2004 10:36 AM
To: Tiwari, Rakesh
Cc: Ralf Baechle; linux-mips@linux-mips.org
Subject: Re: Adding support for new BSP


Ralf Baechle wrote:

>On Fri, May 14, 2004 at 10:06:16AM -0700, Tiwari, Rakesh wrote:
>
>  
>
>>We plan to add our (IDT) BSP (board support package) for evaluation 
>>boards based on IDT 32 bit MIPS processors to the main mips-linux 
>>2.6.x kernel.
>>
>>Can somebody please tell me the procedure/requirements to check-in the 
>>new BSP files into the main kernel tree.
>>    
>>
>
>Send me a patch; cc'ing linux-mips can't harm.  I'll either apply or 
>comment the patch.
>  
>
Take a look at the CodingStyle doc in the Documentation directory first. 
That will save you and Ralf sometime.

Pete
