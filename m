Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2005 20:56:17 +0000 (GMT)
Received: from foothill.iad.idealab.com ([IPv6:::ffff:64.208.8.35]:31459 "EHLO
	foothill.iad.idealab.com") by linux-mips.org with ESMTP
	id <S8225351AbVAUU4M> convert rfc822-to-8bit; Fri, 21 Jan 2005 20:56:12 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Bootloader for mips
Date:	Fri, 21 Jan 2005 12:56:04 -0800
Message-ID: <BBB228F72FF00E4390479AC295FF4B350DE832@FOOTHILL.iad.idealab.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Bootloader for mips
Thread-Index: AcT/zhzLV7+Jg+pgQDa5XAviw861KwALGb3g
From:	"Joseph Chiu" <joseph@omnilux.net>
To:	"Karl Lessard" <klessard@sunrisetelecom.com>,
	"linux-mips" <linux-mips@linux-mips.org>
Return-Path: <joseph@omnilux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@omnilux.net
Precedence: bulk
X-list: linux-mips

If you want to just jump into the kernel, you'd just have to write the low-level init code to setup the hardware and setup the stack to send in the initial
"main" arguments  (see init_arch in arch/mips/kernel/setup.c): argc, **argv, **envp, memsize.

For no kernel parameters, pass in empty argv and envp...

Good luck.

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Karl Lessard
> Sent: Friday, January 21, 2005 7:25 AM
> To: linux-mips
> Subject: Bootloader for mips
> 
> 
> Hi all!
> 
> let's say that I want a very very very simple bootloader for 
> MIPS that 
> boots from flash roms, as trivial
> as 'start and go', without interaction, commands, etc.. any 
> idea where I 
> can find it?
> 
> Or at least how can I write it? (i.e. is there something else 
> to do than 
> setting up kernel parameters
> and jumping to the kernel start address?)
> 
> Thanks a lot,
> Karl
> 
> 
> 
> 
