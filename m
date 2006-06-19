Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2006 17:37:19 +0100 (BST)
Received: from natreg.rzone.de ([81.169.145.183]:40861 "EHLO natreg.rzone.de")
	by ftp.linux-mips.org with ESMTP id S8133525AbWFSQhK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Jun 2006 17:37:10 +0100
Received: from excalibur.cologne.de (cable-84-44-248-98.netcologne.de [84.44.248.98])
	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k5JGat03027671
	for <linux-mips@linux-mips.org>; Mon, 19 Jun 2006 18:36:55 +0200 (MEST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.36 #1 (Debian))
	id 1FsMk8-0001FN-00
	for <linux-mips@linux-mips.org>; Mon, 19 Jun 2006 18:36:52 +0200
Date:	Mon, 19 Jun 2006 18:36:52 +0200
From:	Karsten Merker <karsten@excalibur.cologne.de>
To:	linux-mips@linux-mips.org
Subject: Re: Merge window ...
Message-ID: <20060619163652.GA4219@excalibur.cologne.de>
References: <20060619103653.GA4257@linux-mips.org> <20060620000346.2b704b9b.yoichi_yuasa@tripeaks.co.jp> <20060619155001.GA12123@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619155001.GA12123@linux-mips.org>
X-No-Archive: yes
User-Agent: Mutt/1.5.9i
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

On Mon, Jun 19, 2006 at 04:50:01PM +0100, Ralf Baechle wrote:
> On Tue, Jun 20, 2006 at 12:03:46AM +0900, Yoichi Yuasa wrote:

[board list]
> > These boards are candidate for removal.
> > If there are none objection, we can add to feature-removal-schedule.txt.
> 
> A little too much.  Malta for example works and I'm running top of tree.
> Jazz is happy, SNI was doing ok and received a major upgrade just on
> the weekend  and the Broadcom stuff - aside of slight bitrot is crucially
> important for many projects as the provider of horsepower for native
> builds.

Indeed - if you kick out the Broadcom Swarm support, you would
effectively kill the Debian/mips(el) build farm, which relies
heavily on this type of system.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
