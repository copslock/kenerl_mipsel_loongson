Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2003 08:26:59 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:5089 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226270AbTAMI06>; Mon, 13 Jan 2003 08:26:58 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id JAA23357;
	Mon, 13 Jan 2003 09:27:04 +0100 (MET)
Date: Mon, 13 Jan 2003 09:27:04 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Justin Pauley <jpauley@xwizards.com>
cc: linux-mips@linux-mips.org
Subject: Re: Decstation 5000/25 with no TFTP
In-Reply-To: <1042432324.2735.42.camel@Opus>
Message-ID: <Pine.GSO.3.96.1030113091209.22840B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sun, 12 Jan 2003, Justin Pauley wrote:

> I have a Decstation 5000/25 that I would like to install Linux onto.
> However, because this particular firmware won't allow any TFTP transfers
> over a meg I cannot find a solution. The decstation has ethernet and has
> a floppy drive. I would appreciate any directions someone could give me
> on how to solve the problem of installing Linux on it. Additionally, if

 You can use MOP to boot Linux (and probably any other) ELF images using
mopd running on a Linux server.  I haven't heard of any DECstation model
that would fail this way of booting.  I have made a suitable version of
mopd available at my site, specifically: 
'ftp://ftp.ds2.pg.gda.pl/pub/macro/mopd/' (for raw sources + patches) and
'ftp://ftp.ds2.pg.gda.pl/pub/macro/SRPMS/' (for source RPM packages; i386
and mipsel binaries are available nearby, too).

 All you need to do on the server is to put vmlinux in /home/tftpboot/mop
with a suitable name so that it can be seen by the daemon (see mopd(8)). 
Then you can boot your DECstation client with "boot 3/mop <arguments>"
(either manually or by setting the REX's "boot" variable). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
