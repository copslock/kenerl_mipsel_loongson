Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Nov 2002 20:47:16 +0100 (CET)
Received: from p508B747B.dip.t-dialin.net ([80.139.116.123]:8416 "EHLO
	p508B747B.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122118AbSKXTrP>; Sun, 24 Nov 2002 20:47:15 +0100
Received: from natsmtp01.webmailer.de ([IPv6:::ffff:192.67.198.81]:22729 "EHLO
	post.webmailer.de") by ralf.linux-mips.org with ESMTP
	id <S868139AbSKXTlN>; Sun, 24 Nov 2002 20:41:13 +0100
Received: from excalibur.cologne.de (p50851F45.dip.t-dialin.net [80.133.31.69])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id UAA14394
	for <linux-mips@linux-mips.org>; Sun, 24 Nov 2002 20:46:45 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 18G2l6-0001o0-00
	for <linux-mips@linux-mips.org>; Sun, 24 Nov 2002 20:49:36 +0100
Date: Sun, 24 Nov 2002 20:49:36 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@linux-mips.org
Subject: Re: [RFT] DEC SCSI driver clean-up
Message-ID: <20021124194936.GA6929@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
References: <Pine.GSO.3.96.1021121134955.24541B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021121134955.24541B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

On Thu, Nov 21, 2002 at 02:07:20PM +0100, Maciej W. Rozycki wrote:

[DEC SCSI driver patch]
>  I want to apply the patch to the CVS, but I have no means to test it with
> a SCSI device -- I could only verify after the change the driver works
> well enough to detect the absence of devices in my systems.  I would
> appreciate if someone with a real SCSI setup could test these changes
> before I apply them.

At least a short test on my /150 did not show any problems.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
