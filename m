Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2006 12:46:00 +0000 (GMT)
Received: from smtp4.wanadoo.fr ([193.252.22.27]:46831 "EHLO smtp4.wanadoo.fr")
	by ftp.linux-mips.org with ESMTP id S8133371AbWBGMpj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Feb 2006 12:45:39 +0000
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0403.wanadoo.fr (SMTP Server) with ESMTP id D82371C002E1
	for <linux-mips@linux-mips.org>; Tue,  7 Feb 2006 13:51:13 +0100 (CET)
Received: from lexbox.fr (AToulouse-254-1-57-113.w81-49.abo.wanadoo.fr [81.49.32.113])
	by mwinf0403.wanadoo.fr (SMTP Server) with ESMTP id B9E921C00353;
	Tue,  7 Feb 2006 13:51:13 +0100 (CET)
X-ME-UUID: 20060207125113761.B9E921C00353@mwinf0403.wanadoo.fr
Subject: RE: Au1xx0: really set KSEG0 to uncached on reboot
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date:	Tue, 7 Feb 2006 13:47:57 +0100
Content-class: urn:content-classes:message
Message-ID: <17AB476A04B7C842887E0EB1F268111E02746A@xpserver.intra.lexbox.org>
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Au1xx0: really set KSEG0 to uncached on reboot
Thread-Index: AcYrRTLLwVzft7AeR4qUrbZ/Do6RzAAncaKg
From:	"David Sanchez" <david.sanchez@lexbox.fr>
To:	"Sergei Shtylylov" <sshtylyov@ru.mvista.com>,
	<linux-mips@linux-mips.org>
Cc:	"Jordan Crouse" <jordan.crouse@amd.com>
Return-Path: <david.sanchez@lexbox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.sanchez@lexbox.fr
Precedence: bulk
X-list: linux-mips

Yes, I mean "freezes" :) 

I have the BCSR fix applied.

And the message "** Resetting Integrated Peripherals" comes from the arch/mips/au1000/common/reset.c file (I'm using the kernel 2.6.10).

Maybe I forget to apply other patches...


-----Message d'origine-----
De : Sergei Shtylylov [mailto:sshtylyov@ru.mvista.com] 
Envoyé : lundi 6 février 2006 18:46
À : linux-mips@linux-mips.org
Cc : Jordan Crouse; David Sanchez; Sergei Shtylylov
Objet : Re: Au1xx0: really set KSEG0 to uncached on reboot

Hello.

Jordan Crouse wrote:
> On 06/02/06 09:10 +0100, David Sanchez wrote:
> 
>>Hi,
>>
>>This is exactly what I did...
>>But I notice that sometimes it works and sometimes the kernel frees when 

    You mean "freezes" probably? :-)

>>"** Resetting Integrated Peripherals"

    This is not kernel's msg, but YAMON's one...

> We'll need to nail this down before we go any further.  Can we get a trace
> of what happens when it crashes?

    David, do you have BCSR fix from:

http://www.linux-mips.org/archives/linux-mips/2005-10/msg00236.html

applied (the recent kernel has it but which one are you using?)?
DBAu1550 reset may not work as expeceted otherwise indeed...

> Jordan

WBR, Sergei
