Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Oct 2002 20:22:27 +0100 (CET)
Received: from natsmtp01.webmailer.de ([192.67.198.81]:7054 "EHLO
	post.webmailer.de") by linux-mips.org with ESMTP
	id <S1124128AbSJ2TW0>; Tue, 29 Oct 2002 20:22:26 +0100
Received: from excalibur.cologne.de (pD9E40B74.dip.t-dialin.net [217.228.11.116])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id UAA13742
	for <linux-mips@linux-mips.org>; Tue, 29 Oct 2002 20:22:17 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 186bye-0000MO-00
	for <linux-mips@linux-mips.org>; Tue, 29 Oct 2002 20:24:36 +0100
Date: Tue, 29 Oct 2002 20:24:36 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@linux-mips.org
Subject: Re: make xmenuconfig is broken
Message-ID: <20021029192436.GA1344@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
References: <20021029103545.K24266@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021029103545.K24266@mvista.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

On Tue, Oct 29, 2002 at 10:35:45AM -0800, Jun Sun wrote:

> In addition, there are two SERIAL and SERIAL_CONSOLE related 
> setting which should be in drivers/char/Config.in
> instead of arch/mips/config-shared.in.
> 
> The following hack makes xmenuconfig work again, apparently breaking
> decstation and IP22.  If nobody interested in those two machines
> move the config, I will make an attempt to do so.

Why do you want to move the config? Is there any technical reason besides
grouping the subarch specific character devices below the generic
character devices instead of having a subarch specific menu ("DECstation
character devices")?

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
