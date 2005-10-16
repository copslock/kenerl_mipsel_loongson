Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Oct 2005 19:36:19 +0100 (BST)
Received: from mail.alphastar.de ([194.59.236.179]:2568 "EHLO
	mail.alphastar.de") by ftp.linux-mips.org with ESMTP
	id S8133412AbVJPSgC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 16 Oct 2005 19:36:02 +0100
Received: from SNaIlmail.Peter (217.249.225.149)
          by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==)
          for <linux-mips@linux-mips.org>; Sun, 16 Oct 2005 20:33:05 +0200
Received: from Opal.Peter (Opal.Peter [192.168.1.1])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id j9GIY6N8000552;
	Sun, 16 Oct 2005 20:34:07 +0200
Received: from Opal.Peter (localhost [127.0.0.1])
	by Opal.Peter (8.12.11.Beta0/8.12.11.Beta0/Sendmail/Linux 2.4.24-1-386) with ESMTP id j9GIXs97001586;
	Sun, 16 Oct 2005 20:33:54 +0200
Received: from localhost (pf@localhost)
	by Opal.Peter (8.12.11.Beta0/8.12.11.Beta0/Debian-1) with ESMTP id j9GIXrGY001582;
	Sun, 16 Oct 2005 20:33:54 +0200
Date:	Sun, 16 Oct 2005 20:33:53 +0200 (CEST)
From:	peter fuerst <pf@net.alphadv.de>
To:	linux-mips@linux-mips.org
cc:	karsten@excalibur.cologne.de
Subject: Re: I2-R10k patchset - help needed
In-Reply-To: <20051016180321.GA9993@excalibur.cologne.de>
Message-ID: <Pine.LNX.4.21.0510162020420.1578-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Reply-To: pf@net.alphadv.de
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@net.alphadv.de
Precedence: bulk
X-list: linux-mips



Sorry that the last patches caused problems.
I know that i'm late, unfortunately i let me seduce myself to play
around (this can take arbitrarely long :) with the DMA version of the
Impact-Xserver (which forced some changes to the kernel-driver) :(
At the latest tomorrow i'll deposit a new patch-set for 2.6.14
(a patch for stackframe.h is no longer contained/needed !) together
with the enhanced Xserver Impact-sources.

Hope, this promise compensates for the frustration.

pf



On Sun, 16 Oct 2005, Karsten Merker wrote:

> Date: Sun, 16 Oct 2005 20:03:21 +0200
> From: Karsten Merker <karsten@excalibur.cologne.de>
> Reply-To: linux-mips-bounce@linux-mips.org
> To: linux-mips@linux-mips.org
> Subject: I2-R10k patchset - help needed
> 
> Hallo everybody,
> 
> I am trying to get the current git tree running on an I2 R10k, so
> I applied Peter Fürsts patches from
> 
> http://home.alphastar.de/fuerst/download.html 
> 
> to it. As these are against 2.6.12-rc2, I got a bunch of rejects,
> which I have resolved manually, but I am stuck with the patch for
> include/asm-mips/stackframe.h.
> 
> I would be very grateful if somebody could take a look into this
> and provide an updated patch against the current kernel sources.
> Attached to this mail is both my version of Peter Fürsts
> "collected.diff" (applies cleanly against current git but without
> the stackframe.h-patch) as well as the original stackframe.h
> patch.
> 
> Regards,
> Karsten
> -- 
> #include <standard_disclaimer>
> Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
> oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
> Meinungsforschung.
> 
