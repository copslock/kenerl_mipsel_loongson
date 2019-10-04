Return-Path: <SRS0=VyqI=X5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DBAC4360C
	for <linux-mips@archiver.kernel.org>; Fri,  4 Oct 2019 17:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2937215EA
	for <linux-mips@archiver.kernel.org>; Fri,  4 Oct 2019 17:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388146AbfJDRZP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:25:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:37452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388081AbfJDRZP (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 4 Oct 2019 13:25:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73E47AB7D;
        Fri,  4 Oct 2019 17:25:12 +0000 (UTC)
Date:   Fri, 4 Oct 2019 19:25:09 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 3/5] mfd: ioc3: Add driver for SGI IOC3 chip
Message-Id: <20191004192509.98d4bbda4468c6b9407bc370@suse.de>
In-Reply-To: <20191004144453.GQ18429@dell>
References: <20191003095235.5158-1-tbogendoerfer@suse.de>
        <20191003095235.5158-4-tbogendoerfer@suse.de>
        <20191004144453.GQ18429@dell>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, 4 Oct 2019 15:44:53 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> On Thu, 03 Oct 2019, Thomas Bogendoerfer wrote:
> > +	if (mask & BIT(IOC3_IRQ_ETH_DOMAIN))
> > +		/* if eth irq is enabled we need to check in eth irq regs */
> 
> Nit: Comments should be expressive.  Please expand all of the
> short-hand in this sentence.  It would also be nicer if you started
> with an uppercase character.
> 
> Same with all of the other comments in this file.

ok.

> Other than that, it looks like it's really coming together.  Once the
> above is fixed, please re-sumbit with my:

Thanks.

David, 

before re-posting with the english grammer pimp up, is there anything
I should improve for the network part ? If not, could I get a acked-by
from your side ?

Thomas.

-- 
SUSE Software Solutions Germany GmbH
HRB 247165 (AG M�nchen)
Gesch�ftsf�hrer: Felix Imend�rffer
