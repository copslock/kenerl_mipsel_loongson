Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2002 19:22:32 +0100 (CET)
Received: from p508B747B.dip.t-dialin.net ([80.139.116.123]:61920 "EHLO
	p508B747B.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122118AbSKYSWc>; Mon, 25 Nov 2002 19:22:32 +0100
Received: from natsmtp01.webmailer.de ([IPv6:::ffff:192.67.198.81]:48577 "EHLO
	post.webmailer.de") by ralf.linux-mips.org with ESMTP
	id <S868139AbSKYSQb>; Mon, 25 Nov 2002 19:16:31 +0100
Received: from excalibur.cologne.de (pD9E4044E.dip.t-dialin.net [217.228.4.78])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id TAA27007
	for <linux-mips@linux-mips.org>; Mon, 25 Nov 2002 19:22:12 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 18GNv7-0000CM-00
	for <linux-mips@linux-mips.org>; Mon, 25 Nov 2002 19:25:21 +0100
Date: Mon, 25 Nov 2002 19:25:20 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@linux-mips.org
Subject: Re: GRUB for MIPS?
Message-ID: <20021125182520.GA751@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
References: <OF0C671142.6F18C55C-ON88256C7C.0060F56F-88256C7C.006197E4@xyronsemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0C671142.6F18C55C-ON88256C7C.0060F56F-88256C7C.006197E4@xyronsemi.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

On Mon, Nov 25, 2002 at 09:48:05AM -0800, James Anderson wrote:

> Has anyone ported GRUB to a mips target?   Is it feasible or does it

Not that I know of.

> not make sense?  Popular alternatives to load Linux from a local/remote 
> filesystem?

Loaders depend on the target machine - we have DELO for booting 
DECstations from Harddisk, ARCBoot for booting SGI IP22 (Indy and
Indigo2) from harddisk and tip22 to easily create netbootable images
for IP22. Besides that, I know of no bootloaders besides the ones
that the machine firmware implements.

HTH,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
