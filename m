Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2004 19:09:57 +0100 (BST)
Received: from natsmtp00.rzone.de ([IPv6:::ffff:81.169.145.165]:5335 "EHLO
	natsmtp00.rzone.de") by linux-mips.org with ESMTP
	id <S8225478AbUEQSJ4>; Mon, 17 May 2004 19:09:56 +0100
Received: from excalibur.cologne.de (pD9E40BB3.dip.t-dialin.net [217.228.11.179])
	by post.webmailer.de (8.12.10/8.12.10) with ESMTP id i4HI9dMQ013804
	for <linux-mips@linux-mips.org>; Mon, 17 May 2004 20:09:39 +0200 (MEST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 1BPmXg-0000Q0-00
	for <linux-mips@linux-mips.org>; Mon, 17 May 2004 20:08:48 +0200
Date: Mon, 17 May 2004 20:08:48 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@linux-mips.org
Subject: Re: SGI O2 MIPS R5000 bootp problems
Message-ID: <20040517180848.GA1551@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
References: <40A8E08B.7070203@cyberMalex.com> <20040517161515.GA5706@umax645sx> <20040517163639.GA32507@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517163639.GA32507@linux-mips.org>
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

On Mon, May 17, 2004 at 06:36:39PM +0200, Ralf Baechle wrote:
> On Mon, May 17, 2004 at 06:15:16PM +0200, Ladislav Michl wrote:
> 
> > > 7536
> > > Cannot load bootp():r5000_boot.img.
> > > Range check failure: text start 0x88802000, size 0x1d70.
> >                                   ^^^^^^^^^^
> > What kernel version are you running? This bug was fixed quite long ago.
> > I'd recommend using recent cvs and patch by Ilya
> > http://www.total-knowledge.com/progs/mips/patches
> 
> Looks like an attempt to load an IP22 kernel into an IP32.

Definitely - Debian does not yet provide IP32 images, only IP22.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
