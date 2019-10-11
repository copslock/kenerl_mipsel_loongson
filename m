Return-Path: <SRS0=OK/w=YE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20722C47404
	for <linux-mips@archiver.kernel.org>; Fri, 11 Oct 2019 08:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B8F20679
	for <linux-mips@archiver.kernel.org>; Fri, 11 Oct 2019 08:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfJKIhO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:37:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:50344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbfJKIhO (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 11 Oct 2019 04:37:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB590ADDD;
        Fri, 11 Oct 2019 08:37:11 +0000 (UTC)
Date:   Fri, 11 Oct 2019 10:37:10 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v9 3/5] mfd: ioc3: Add driver for SGI IOC3 chip
Message-Id: <20191011103710.6c45fdbc9a05fdd13177193e@suse.de>
In-Reply-To: <20191010200002.5fe5f34f@cakuba.netronome.com>
References: <20191010145953.21327-1-tbogendoerfer@suse.de>
        <20191010145953.21327-4-tbogendoerfer@suse.de>
        <20191010200002.5fe5f34f@cakuba.netronome.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Thu, 10 Oct 2019 20:00:02 -0700
Jakub Kicinski <jakub.kicinski@netronome.com> wrote:

> On Thu, 10 Oct 2019 16:59:49 +0200, Thomas Bogendoerfer wrote:
> >  	dev = alloc_etherdev(sizeof(struct ioc3_private));
> > -	if (!dev) {
> > -		err = -ENOMEM;
> > -		goto out_disable;
> > -	}
> > -
> > -	if (pci_using_dac)
> > -		dev->features |= NETIF_F_HIGHDMA;
> 
> Looks like the NETIF_F_HIGHDMA feature will not longer be set, is that
> okay?

yes, all platforms where ioc3 is usable are running 64bit kernels without
HIGHMEM.

Thomas.

-- 
SUSE Software Solutions Germany GmbH
HRB 247165 (AG M�nchen)
Gesch�ftsf�hrer: Felix Imend�rffer
