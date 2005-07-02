Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jul 2005 09:41:26 +0100 (BST)
Received: from go4.ext.ti.com ([IPv6:::ffff:192.91.75.132]:6793 "EHLO
	go4.ext.ti.com") by linux-mips.org with ESMTP id <S8226202AbVGBIlB> convert rfc822-to-8bit;
	Sat, 2 Jul 2005 09:41:01 +0100
Received: from dlep31.itg.ti.com ([157.170.139.161])
	by go4.ext.ti.com (8.13.1/8.13.1) with ESMTP id j628eqYT017585;
	Sat, 2 Jul 2005 03:40:52 -0500 (CDT)
Received: from dlep90.itg.ti.com (localhost [127.0.0.1])
	by dlep31.itg.ti.com (8.12.11/8.12.11) with ESMTP id j628ep54020885;
	Sat, 2 Jul 2005 03:40:51 -0500 (CDT)
Received: from dbde01.ent.ti.com (localhost [127.0.0.1])
	by dlep90.itg.ti.com (8.12.11/8.12.11) with ESMTP id j628enhB006633;
	Sat, 2 Jul 2005 03:40:50 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: I built a mipsel-linux toolchain, but it doesn't work
Date:	Sat, 2 Jul 2005 14:10:48 +0530
Message-ID: <A8A67F242940E246A515077CF9ECACC157F3F6@dbde01.ent.ti.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: I built a mipsel-linux toolchain, but it doesn't work
Thread-Index: AcV+ViWjSXBS2K9XQPWdR9qPsq6FCwAi2j7w
From:	"Singh, Ajay" <ajaysingh@ti.com>
To:	<sjhill@realitydiluted.com>, "David Daney" <ddaney@avtrex.com>
Cc:	"moreau francis" <francis_moreau2000@yahoo.fr>,
	"zhan rongkai" <zhanrk@gmail.com>, <linux-mips@linux-mips.org>
Return-Path: <ajaysingh@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ajaysingh@ti.com
Precedence: bulk
X-list: linux-mips

We are using uClibc-0.9.27 for MIPS target. Can you point out the issues
with uClibc-0.9.27 ??

~Ajay.

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of
sjhill@realitydiluted.com
Sent: Friday, July 01, 2005 8:30 PM
To: David Daney
Cc: moreau francis; zhan rongkai; linux-mips@linux-mips.org
Subject: Re: I built a mipsel-linux toolchain, but it doesn't work

> moreau francis wrote:
> > Could you develop please ? What kind of config/hack does Buildroot 
> > to be able to use GCC with uClibc ?
> > 
> 
> It is quite complicated, but you can find a summary on this web page:
> 
> http://www.google.com/search?q=uclibc+buildroot
> 
Here is the page for it:

   http://buildroot.uclibc.org/

The mipsel target is supported and will build for your needs. Do not use
uClibc-0.9.27 when you configure your buildroot system. Use the latest
uClibc snapshot. There are issues with uClibc-0.9.27 with MIPS targets.

-Steve
