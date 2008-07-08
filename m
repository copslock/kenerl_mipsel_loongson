Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2008 18:56:20 +0100 (BST)
Received: from bu3sch.de ([62.75.166.246]:21228 "EHLO vs166246.vserver.de")
	by ftp.linux-mips.org with ESMTP id S20024248AbYGHR4L (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Jul 2008 18:56:11 +0100
Received: from ycb20.y.pppool.de ([89.60.203.32] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.63)
	(envelope-from <mb@bu3sch.de>)
	id 1KGHQ8-000114-KS; Tue, 08 Jul 2008 17:56:08 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	sbrown@cortland.com
Subject: Re: Correct way to set coherent_dma_mask on a non-pci device?
Date:	Tue, 8 Jul 2008 19:55:47 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	linux-mips@linux-mips.org
References: <4873A676.8050906@cortland.com>
In-Reply-To: <4873A676.8050906@cortland.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200807081955.47594.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Tuesday 08 July 2008 19:40:06 Steve Brown wrote:
> There appears to be no function like pci_set_consistent_dma_mask to set 
> the coherent mask for a non-pci device.
> 
> What is the "proper" way to set it?
> 
> The context for the question is a recent change to ssb_dma_set_mask() in 
> drivers/ssb/main.c that removed the somewhat fragile, direct 
> manipulation of dma_mask and coherent_dma_mask in favor of a call to 
> dma_set_mask().

Note that SSB devices use the dma_*** API for doing DMA remappings.
So it uses dma_set_mask() for setting the mask.

-- 
Greetings Michael.
