Return-Path: <SRS0=Eolf=YJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1324BFA3728
	for <linux-mips@archiver.kernel.org>; Wed, 16 Oct 2019 17:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D832082C
	for <linux-mips@archiver.kernel.org>; Wed, 16 Oct 2019 17:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389098AbfJPRpF (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:45:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52220 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfJPRpF (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 16 Oct 2019 13:45:05 -0400
Received: from localhost (unknown [IPv6:2603:3023:50c:85e1:5314:1b70:2a53:887e])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 382FB142395C2;
        Wed, 16 Oct 2019 10:45:04 -0700 (PDT)
Date:   Wed, 16 Oct 2019 13:45:03 -0400 (EDT)
Message-Id: <20191016.134503.2122228633763051149.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     o.rempel@pengutronix.de, chris.snook@gmail.com,
        f.fainelli@gmail.com, jhogan@kernel.org, jcliburn@gmail.com,
        mark.rutland@arm.com, paul.burton@mips.com, ralf@linux-mips.org,
        robh+dt@kernel.org, linux@armlinux.org.uk,
        vivien.didelot@gmail.com, kernel@pengutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v1 1/4] net: ag71xx: port to phylink
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191016133215.GA17013@lunn.ch>
References: <20191016121216.GD4780@lunn.ch>
        <20191016122401.jnldnlwruv7h5kgy@pengutronix.de>
        <20191016133215.GA17013@lunn.ch>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 16 Oct 2019 10:45:05 -0700 (PDT)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 16 Oct 2019 15:32:15 +0200

> I don't know if there are any strict rules, but i tend to use To: for
> the maintainer you expect to merge the patch, and Cc: for everybody
> else, and the lists.

This is a good way to handle things.
