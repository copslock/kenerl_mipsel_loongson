Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2003 14:27:38 +0100 (BST)
Received: from natsmtp01.webmailer.de ([IPv6:::ffff:192.67.198.81]:1484 "EHLO
	post.webmailer.de") by linux-mips.org with ESMTP
	id <S8225256AbTDKN1h>; Fri, 11 Apr 2003 14:27:37 +0100
Received: from excalibur.cologne.de (pD95119F9.dip.t-dialin.net [217.81.25.249])
	by post.webmailer.de (8.12.8/8.8.7) with ESMTP id h3BDRYjd024869
	for <linux-mips@linux-mips.org>; Fri, 11 Apr 2003 15:27:35 +0200 (MEST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 193ygu-0000Dm-00
	for <linux-mips@linux-mips.org>; Fri, 11 Apr 2003 15:35:40 +0200
Date: Fri, 11 Apr 2003 15:35:34 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: ext3 under MIPS?
Message-ID: <20030411133534.GB418@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
References: <3E954651.C7AECB90@ekner.info> <20030410154050.GI5242@lug-owl.de> <3E95D16D.1671BA5A@ekner.info> <20030411064754.GM5242@lug-owl.de> <3E969362.B50934A@ekner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E969362.B50934A@ekner.info>
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

On Fri, Apr 11, 2003 at 12:05:22PM +0200, Hartvig Ekner wrote:

> Now I'm beginning to suspect that my conversion from ext2 to ext3 (tune2fs -j on a running system, and
> just modifying ext2 to ext3 in fstab) is somehow not correct, or something else which I overlooked?
> How did you guys (the ones without any ext3 problems) initially get the ext3 root partition in place
> (was it born as ext3 or converted from ext2?) and anything special one needs to do in fstab?

On my mipsel box it was created as ext3 from scratch, on i386 it was
converted from ext2.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
