Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2003 18:14:35 +0100 (BST)
Received: from natsmtp01.webmailer.de ([IPv6:::ffff:192.67.198.81]:60828 "EHLO
	post.webmailer.de") by linux-mips.org with ESMTP
	id <S8225205AbTDJROe>; Thu, 10 Apr 2003 18:14:34 +0100
Received: from excalibur.cologne.de (p508519C0.dip.t-dialin.net [80.133.25.192])
	by post.webmailer.de (8.12.8/8.8.7) with ESMTP id h3AHEW6f010039
	for <linux-mips@linux-mips.org>; Thu, 10 Apr 2003 19:14:32 +0200 (MEST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 193fiY-0000F0-00
	for <linux-mips@linux-mips.org>; Thu, 10 Apr 2003 19:20:06 +0200
Date: Thu, 10 Apr 2003 19:20:06 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: ext3 under MIPS?
Message-ID: <20030410172006.GC828@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
References: <3E954651.C7AECB90@ekner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E954651.C7AECB90@ekner.info>
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

On Thu, Apr 10, 2003 at 12:24:17PM +0200, Hartvig Ekner wrote:

> I have been using ext3 with MIPS, and it seems to work fine during normal operations. However, when
> doing an unclean shutdown things don't exactly behave the way I believe they should. Does anybody
> know how the ext3 recovery is supposed to work?

Hm, at least ext3 has worked properly on a DECstation. I had a hard crash
and the journal recovery seemed to have worked. I got no fsck-errors.

HTH,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
