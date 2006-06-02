Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2006 11:16:42 +0200 (CEST)
Received: from mail.baslerweb.com ([145.253.187.130]:4207 "EHLO
	mail.baslerweb.com") by ftp.linux-mips.org with ESMTP
	id S8133569AbWFBJQW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2006 11:16:22 +0200
Received: (from smtpd@127.0.0.1) by mail.baslerweb.com (8.13.4/8.13.4)
	id k52BFEsZ004337 for <linux-mips@linux-mips.org>; Fri, 2 Jun 2006 13:15:14 +0200
Received: from unknown [172.16.20.75] by gateway id /processing/kwwblL39; Fri Jun 02 13:15:14 2006
MIME-Version: 1.0
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date:	Fri, 2 Jun 2006 11:16:18 +0200
Message-ID: <C5A8FDEFF7647F4C9CB927D7DEB30773C7AE85@AHR075S.basler.corp>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Location of PCI setup code
Thread-Index: AcaF1VkjPtksw6SASzWpstbbqfTi7wAT7ymQ
From:	"Koeller, T." <Thomas.Koeller@baslerweb.com>
To:	<linux-mips@linux-mips.org>
X-SecurE-Mail-Gateway: Version: 5.00.3.1 (smtpd: 6.53.8.7) Date: 20060602111514Z
Subject: RE: Location of PCI setup code
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-Path: <Thomas.Koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Thomas.Koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

> From: Ralf Baechle [mailto:ralf@linux-mips.org] 
> 
> On Thu, Jun 01, 2006 at 10:46:17PM +0200, Thomas Koeller wrote:
> 
> > the PCI setup code for a platform is conventionally located 
> in arch/mips/pci. 
> > I fail to see the benefits of separating this particular 
> part of a platform's 
> > setup from the rest. The PCI setup code will in general 
> contain references to 
> > platform-specific information, such as the overall address 
> space layout, of 
> > which the PCI memory and I/O pages are a part. If the PCI 
> setup code were in 
> > the platform subdirectory, sharing this information by means of a 
> > platform-local header file would be easy. But with the PCI code in 
> > arch/mips/pci, this becomes more difficult. The platform 
> header could be 
> > located somewhere outside the platform's directory, maybe under 
> > 'include' (where?), or referenced via an ugly relative path like 
> > '../../vendor/platform/platform.h'. All this seems rather 
> clumsy to me. No 
> > other part of a platform's initialization is separated from 
> the rest in a 
> > similar way, so what is so special about PCI setup that it 
> cannot be in the 
> > platform directory, thereby avoiding all these annoyances? 
> 
> The per-platform PCI code used to live in the per-platform 
> directories.
> It turned into a giant mess, very little code was being shared, it was
> hard to uniformly perform any kind of modification or fixes - and more
> of that kind of changes will be needed before the PCI codes really
> shines.
> 
>   Ralf
> 

So how am I supposed to deal with the issues mentioned?
Should I duplicate the PCI-related platform definitions into
arch/mips/pci? Scattering related information across several places is
generally regarded as poor design, as it will make maintenance more
difficult.
Or should I resort to one of the methods I mentioned, or is there any
other
preferred/recommended way of dealing with this?

tk
----------------------------------------------- 
Thomas Koeller, Software Development 

Basler Vision Technologies 
An der Strusbek 60-62 
22926 Ahrensburg 
Germany 

Tel +49 (4102) 463-390 
Fax +49 (4102) 463-46390

mailto:Thomas.Koeller@baslerweb.com 
http://www.baslerweb.com 
