Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2004 17:06:15 +0100 (BST)
Received: from pfepc.post.tele.dk ([IPv6:::ffff:195.41.46.237]:14740 "EHLO
	pfepc.post.tele.dk") by linux-mips.org with ESMTP
	id <S8225288AbUDTQGO> convert rfc822-to-8bit; Tue, 20 Apr 2004 17:06:14 +0100
Received: from ANNEMETTE (0x50c71479.adsl-fixed.tele.dk [80.199.20.121])
	by pfepc.post.tele.dk (Postfix) with ESMTP id DB7D226283E;
	Tue, 20 Apr 2004 18:06:09 +0200 (CEST)
From: =?iso-8859-1?Q?J=F8rg_Ulrich_Hansen?= <jh@hansen-telecom.dk>
To: "'Pete Popov'" <ppopov@mvista.com>
Cc: "Linux-Mips" <linux-mips@linux-mips.org>
Subject: SV: Framebuffer for au1100
Date: Tue, 20 Apr 2004 18:06:27 +0200
Message-ID: <004f01c426f1$7085b080$050ba8c0@ANNEMETTE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <4085420D.7040403@mvista.com>
Return-Path: <jh@hansen-telecom.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jh@hansen-telecom.dk
Precedence: bulk
X-list: linux-mips

> Jørg Ulrich Hansen wrote:
> 
> >Hi
> >
> >I was trying to make use of framebuffer for a db1100 board. It looks 
> >like au1100fb.c is not updated to kernel 2.6. It makes use of some 
> >structs and procedures in fbcon that has been removed in 
> 2.6. Any ideas 
> >what is needed to get au1100fb.c to work in 2.6? Has someone 2.6 to 
> >work with frambuffers on au1100? I think that au1100fb is 
> written for 
> >pb1100 that has an epson lcd controller fitted.
> >Does that mean that nothing has been done for the internal 
> lcd controller?
> >  
> >
> No, the internal au1100 fb controller is supported in 2.4. 
> The external 
> epson controller is supported through the LCD chip select. 
> What needs to 
> be done in 2.6 is an update of the au1100fb driver to the new 
> api. Right 
> now what I'm working on part time is syncing up 2.6 with the 
> latest 2.4 
> updates and getting the basic features functioning, including 
> the 36 bit 
> address support. Then the drivers update will come one at a time. Of 
> course, if someone else has time to help, patches are welcomed :)
> 
> Pete
> 
Hi

If you can put me in the right direction I am very keen on helping.
I have included the file in Kconfig but then it wound compile because of
the old 2.4 files (fbcon).
What are the tasks and are you aware of any framebuffer code that are
already modyfired?

Regards Jorg




 
