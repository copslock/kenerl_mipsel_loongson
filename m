Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2009 20:59:18 +0100 (BST)
Received: from adelie.canonical.com ([91.189.90.139]:17897 "EHLO
	adelie.canonical.com") by ftp.linux-mips.org with ESMTP
	id S20027344AbZDUT7K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Apr 2009 20:59:10 +0100
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1LwM7U-0006eZ-4X; Tue, 21 Apr 2009 20:59:04 +0100
Received: from 189.26.152.230.dynamic.adsl.gvt.net.br ([189.26.152.230] helo=[192.168.77.100])
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <adilson@canonical.com>)
	id 1LwM7T-00022J-Q9; Tue, 21 Apr 2009 20:59:04 +0100
Message-ID: <49EE2583.6030802@canonical.com>
Date:	Tue, 21 Apr 2009 16:58:59 -0300
From:	Adilson Oliveira <adilson@canonical.com>
Organization: Canonical
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	linux-mips@linux-mips.org
Subject: Re: Crazy idea: run linux on a mips-based photo frame
References: <49E644A9.6040503@canonical.com> <f861ec6f0904152344i781f794dkb463909d734c77f3@mail.gmail.com> <49E79F89.9090104@canonical.com> <20090417061955.GA7249@roarinelk.homelinux.net>
In-Reply-To: <20090417061955.GA7249@roarinelk.homelinux.net>
X-Enigmail-Version: 0.95.7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <adilson@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adilson@canonical.com
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Em 17-04-2009 03:19, Manuel Lauss escreveu:

> I don't know WinCE very well, but I think you can simply dump the relevant
> registers from any app (at least that's what my colleagues tell me).
> 
> The registers you need are MEM_SD* and MEM_ST* (addresses can be found
> in arch/mips/include/asm/mach-au1x00/au1000.h.  To get the datasheet, go to
> Raza's Alchemy support site and apply for access.  I can't give you the
> datasheet directly due to a ridiculous NDA requirement.  But all information
> you need is in the kernel headers ;-) )
> 
> If the frame doesn't allow you to run "foreign" WinCE apps, then you'd need
> to find out where the JTAG pins are and use a probe to dump the registers...

Well, I spent the sunday trying to find a way to get this information
but wasn't able to run anything else or find any jtag points I could
use. Anyone with contacts inside Samsung can find more information? ;)
I would really love to dump this damn windows ce 5 from it but I can't
find a starting point...
I'm thinking very hard of trying any sort of ready-to-run distro created
for a basic AU1200 board and try to load on the frame using the firmware
update option on it just to see what happens. Is there such thing as a
ready-to-run kernel+rootfs I can load on a USB key?

[]s

Adilson.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAknuJYMACgkQYaKG37RGLIoIvACfQrN+zBuF2i6OjZyk9wfH6hTz
HyYAnA1z7/ZM8ag+K8OstfVS4MBvqcHm
=BOYJ
-----END PGP SIGNATURE-----
