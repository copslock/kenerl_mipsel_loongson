Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2003 17:55:17 +0000 (GMT)
Received: from natsmtp01.webmailer.de ([IPv6:::ffff:192.67.198.81]:39659 "EHLO
	post.webmailer.de") by linux-mips.org with ESMTP
	id <S8226365AbTAMRzR>; Mon, 13 Jan 2003 17:55:17 +0000
Received: from excalibur.cologne.de (p508510D9.dip.t-dialin.net [80.133.16.217])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id SAA10160;
	Mon, 13 Jan 2003 18:55:07 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 18Y8tL-0000DA-00; Mon, 13 Jan 2003 19:00:55 +0100
Date: Mon, 13 Jan 2003 19:00:53 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@linux-mips.org
Cc: Justin Pauley <jpauley@xwizards.com>
Subject: Re: Decstation 5000/25 with no TFTP
Message-ID: <20030113180053.GA432@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org, Justin Pauley <jpauley@xwizards.com>
References: <1042432324.2735.42.camel@Opus> <Pine.GSO.3.96.1030113091209.22840B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030113091209.22840B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

On Mon, Jan 13, 2003 at 09:27:04AM +0100, Maciej W. Rozycki wrote:
> On Sun, 12 Jan 2003, Justin Pauley wrote:
> 
> > I have a Decstation 5000/25 that I would like to install Linux onto.
> > However, because this particular firmware won't allow any TFTP transfers
> > over a meg I cannot find a solution. The decstation has ethernet and has
[SNIP]
>  You can use MOP to boot Linux (and probably any other) ELF images using
> mopd running on a Linux server.  I haven't heard of any DECstation model

As mopd requires an ELF image and the offical Debian netboot images
are tftpimages in ECOFF, you should try using MOP with 

http://people.debian.org/~merker/experimental_packages/bf-pre3.0.24-20021224/unpacked/mopimage-r3k-kn02

As URL for getting kernel and modules give

http://people.debian.org/~merker/experimental_packages/bf-pre3.0.24-20021224/unpacked/

to the installer. These are installer images built from the Debian
"boot-floppies" CVS and contain an important fix regarding the Personal
DECstation series, which is not in the last official release.

HTH,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
