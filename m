Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 08:37:41 +0100 (BST)
Received: from sigrand.ru ([80.66.88.167]:31207 "HELO mail.sigrand.com")
	by ftp.linux-mips.org with SMTP id S8126552AbWFGHhc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2006 08:37:32 +0100
Received: from develop (unknown [192.168.2.238])
	by mail.sigrand.com (Postfix) with ESMTP id ADE9BE8042;
	Wed,  7 Jun 2006 14:37:30 +0700 (NOVST)
Date:	Wed, 7 Jun 2006 14:37:30 +0700
From:	art <art@sigrand.ru>
X-Mailer: The Bat! (v1.38e) S/N A1D26E39 / Educational
Reply-To: art <art@sigrand.ru>
Organization: Sigrand LLC
X-Priority: 3 (Normal)
Message-ID: <12609.060607@sigrand.ru>
To:	ashley jones <ashley_jones_2000@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re[4]: Socket buffer allocation outside DMA-able memory
In-reply-To: <20060607051756.66058.qmail@web38409.mail.mud.yahoo.com>
References: <20060607051756.66058.qmail@web38409.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <art@sigrand.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: art@sigrand.ru
Precedence: bulk
X-list: linux-mips

Hello ashley,

Wednesday, June 07, 2006, 12:17:56 PM, you wrote:



aj>> I guess your 25 bit dma address field will be word alligned, so ur dma engine will be able to index up to 64 MB( 25+2 = 27 bits).
aj> Address not aligned - if I don't do anything driver work incorrect!
   
aj>   *** what do you mean by Address not aligned ??
   
aj>   *** What address you r passing to dma ? u should pass (skb->data >> 2) (if word alligned address is required for dma engine.)

In adm5120 switch driver to dma passed skb->data

-- 
Best regards,
 art                            mailto:art@sigrand.ru
