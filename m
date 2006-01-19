Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 12:27:24 +0000 (GMT)
Received: from lennier.cc.vt.edu ([198.82.162.213]:3466 "EHLO
	lennier.cc.vt.edu") by ftp.linux-mips.org with ESMTP
	id S8133832AbWASM1G (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jan 2006 12:27:06 +0000
Received: from dagger.cc.vt.edu (IDENT:mirapoint@evil-dagger.cc.vt.edu [10.1.1.11])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id k0JCUBOW004012;
	Thu, 19 Jan 2006 07:30:11 -0500
Received: from [192.168.1.2] (blacksburg-bsr1-69-170-32-128.chvlva.adelphia.net [69.170.32.128])
	by dagger.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id FAZ61662 (AUTH spbecker);
	Thu, 19 Jan 2006 07:30:09 -0500 (EST)
Message-ID: <43CF864F.1020202@gentoo.org>
Date:	Thu, 19 Jan 2006 07:30:07 -0500
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060118)
MIME-Version: 1.0
To:	olegol@aport.ru
CC:	linux-mips@linux-mips.org
Subject: Re: GTK/GLIB port for mipsel
References: <FU-CvJRDLOVoZrY@aport2000.ru>
In-Reply-To: <FU-CvJRDLOVoZrY@aport2000.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

> Can anybody here point me to a source where I can 
> download a glib and gtk ports for mipsel, or at least get 
> more info on this.

Well, it wouldn't surprise me if something is broken, as I get the 
feeling that the GNOME folks are notorious for doing unportable crap in 
their code.  However, GTK/glib builds and works just fine for me.  I 
suspect that either something is broken in your cross-compile setup, or 
you might be using ancient versions of these packages.  I have both 
glib-2.8.5 and gtk+-2.8.10 installed on my (big-endian) machines here 
without any problems.

-Steve
