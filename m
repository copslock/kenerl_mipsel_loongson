Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2003 18:33:23 +0100 (BST)
Received: from natsmtp00.rzone.de ([IPv6:::ffff:81.169.145.165]:59887 "EHLO
	natsmtp00.webmailer.de") by linux-mips.org with ESMTP
	id <S8225548AbTJHRcv>; Wed, 8 Oct 2003 18:32:51 +0100
Received: from excalibur.cologne.de (pD951111A.dip.t-dialin.net [217.81.17.26])
	by post.webmailer.de (8.12.10/8.12.10) with ESMTP id h98HWjHi006108;
	Wed, 8 Oct 2003 19:32:45 +0200 (MEST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 1A7IEH-0000NX-00; Wed, 08 Oct 2003 19:36:05 +0200
Date: Wed, 8 Oct 2003 19:36:05 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: Question about use of PMAD-AA ethernet adapter on Decstation
Message-ID: <20031008173605.GA1359@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	debian-mips@lists.debian.org, linux-mips@linux-mips.org
References: <20031008142337.GI12409@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1031008162829.26799D-100000@delta.ds2.pg.gda.pl> <20031008161017.GL12409@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031008161017.GL12409@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

On Wed, Oct 08, 2003 at 06:10:17PM +0200, Thiemo Seufer wrote:
> Maciej W. Rozycki wrote:

> > There is a patch that converts the stock driver
> > into one working for the PMAD-A (but it doesn't work for the others than)
> > and I'm told Debian uses thus modified code as a separate driver.  The
> > patch is based on work by Dave Airlie and is available here:
> > 'ftp://ftp.ds2.pg.gda.pl/pub/macro/drivers/pmad-a/patch-mips-2.4.20-pre6-20021222-declance-pmad-12.gz' 
> > -- it applies cleanly to the current version of declance.c.
> 
> Debian calls this specific driver pmadaa.c. I looked only at declance.c,
> which seems to be the same as te linux-mips CVS version.

The pmadaa.c in the Debian kernel is basically the original work of
Dave Airlie with just very slight adjustments to make it compile
with 2.4.19.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
