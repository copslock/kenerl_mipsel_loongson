Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2003 12:06:22 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:411 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225240AbTFLLGU>; Thu, 12 Jun 2003 12:06:20 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA26307;
	Thu, 12 Jun 2003 13:06:52 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Thu, 12 Jun 2003 13:06:51 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: Martin Leopold <mleopold@tiscali.dk>, linux-mips@linux-mips.org
Subject: Re: Linux on Indigo2 (IP28) - R10000
In-Reply-To: <20030611204117.GO29687@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1030612130044.25948C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 11 Jun 2003, Thiemo Seufer wrote:

> > > > I looked arround your website and saw
> > > > "mips64-linux-ip28-2002-06-28.tar.gz"
> > > > whoo.. Sounds exiting =]
> > > I know it's somewhat outdated. :-)
> > 
> > Hehe.. I tried it, and it booted. Whopee.. However the kernel-level-IP 
> > configuration (BOOTP) fails!? I'm not really sure why - the DHCP server 
> > just gave the IP and kernel-image a moment ago. This make me wonder: 
> > how far could I get with this kernel? Is it possible that I could 
> > actually boot an entire system with this kernel, or is that pushing it 
> > a bit?
> 
> It happens to work by accident, because the cachelines destoyed
> due to the speculative stores don't hit anything important. The
> 2.5 kernel fails much earlier.

 I recall fixing an IP checksum calculation bug in the 64-bit kernel last
year -- this may possibly be another reason of BOOTP failing (well, it
used to fail for me because of this problem back then).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
