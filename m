Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2003 16:49:56 +0000 (GMT)
Received: from mailout05.sul.t-online.com ([IPv6:::ffff:194.25.134.82]:24720
	"EHLO mailout05.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225446AbTKLQtY>; Wed, 12 Nov 2003 16:49:24 +0000
Received: from fwd03.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1AJyBG-0004Yh-01; Wed, 12 Nov 2003 17:49:22 +0100
Received: from denx.de (rA1f6TZrweG7Og87rFMH3DH4zFkNPq+OLjzNCimfi0gmbACxB96Xr5@[217.235.231.185]) by fmrl03.sul.t-online.com
	with esmtp id 1AJyAD-16xyVc0; Wed, 12 Nov 2003 17:48:17 +0100
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 2D5F842ACF; Wed, 12 Nov 2003 17:48:16 +0100 (MET)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 355ECC5F59; Wed, 12 Nov 2003 17:48:10 +0100 (MET)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 303F3C5F58; Wed, 12 Nov 2003 17:48:10 +0100 (MET)
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: snapgear and uClinux 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Wed, 12 Nov 2003 11:36:14 EST."
             <Pine.GSO.4.44.0311121132480.5676-100000@ares.mmc.atmel.com> 
Date: Wed, 12 Nov 2003 17:48:05 +0100
Message-Id: <20031112164810.355ECC5F59@atlas.denx.de>
X-Seen: false
X-ID: rA1f6TZrweG7Og87rFMH3DH4zFkNPq+OLjzNCimfi0gmbACxB96Xr5@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <Pine.GSO.4.44.0311121132480.5676-100000@ares.mmc.atmel.com> you wrote:
> Has anyone out there used uClinux or snapgear's distro with a mips
> processor? Did you have any unexpected suprises? Do these tools help get
> the footprint smaller or is it easier to do something with the linux-mips
> tree?

I have seen uCLinux running on the Purple board (MIPS 5Kc CPU core).

If you have a MMU on your chip you should always go for the "real" Linux.

Reducing the memory footprint is not so much a kernel issue  but  one
of  the application level - using standard tools linked against glibc
vs. busybox with uClibc for example.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is easier to change the specification to fit the program than vice
versa.
