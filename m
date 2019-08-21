Return-Path: <SRS0=RuEK=WR=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B60C3A59E
	for <linux-mips@archiver.kernel.org>; Wed, 21 Aug 2019 12:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F931233A0
	for <linux-mips@archiver.kernel.org>; Wed, 21 Aug 2019 12:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfHUMkg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:40:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:59388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbfHUMkg (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 21 Aug 2019 08:40:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 43AA6AFCE;
        Wed, 21 Aug 2019 12:40:34 +0000 (UTC)
Date:   Wed, 21 Aug 2019 14:40:33 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Evgeniy Polyakov <zbr@ioremap.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 11/17] net: sgi: ioc3-eth: no need to stop queue
 set_multicast_list
Message-Id: <20190821144033.2e206cb18b1dfd10377357c2@suse.de>
In-Reply-To: <20190819170440.37ff18d4@cakuba.netronome.com>
References: <20190819163144.3478-1-tbogendoerfer@suse.de>
        <20190819163144.3478-12-tbogendoerfer@suse.de>
        <20190819170440.37ff18d4@cakuba.netronome.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, 19 Aug 2019 17:04:53 -0700
Jakub Kicinski <jakub.kicinski@netronome.com> wrote:

> On Mon, 19 Aug 2019 18:31:34 +0200, Thomas Bogendoerfer wrote:
> > netif_stop_queue()/netif_wake_qeue() aren't needed for changing
> > multicast filters. Use spinlocks instead for proper protection
> > of private struct.
> > 
>
> I thought it may protect ip->emcr, but that one is accessed with no
> locking from the ioc3_timer() -> ioc3_setup_duplex() path..

it should protect ip->emcr ... I'll add spin_lock/unlock to setup_duplex and
respin the patch.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imend�rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N�rnberg)
