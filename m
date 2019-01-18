Return-Path: <SRS0=gTW6=P2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68698C43613
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 02:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3939A20873
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 02:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l657KXwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfARCNs (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:13:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37508 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfARCNs (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 17 Jan 2019 21:13:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so3049272wmd.2;
        Thu, 17 Jan 2019 18:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M7SLDhjFcKwH7+q3F8eYXlUPuBRQyFCKD7xK/RWvSBM=;
        b=l657KXwHeBCGPjq0PFSauWGe58227V+SOVSrwnancbb7iS3HUXrnAWtdfYB79WBbMv
         XrCjafjJbhmQ69H2Y6tFXUjkHA/cKvjya+J9gubpVvtV2R/MuZdiPP3NVqb+YbIvcX5f
         774ol5OyRx5QjXKdejMwFLgtI95JKROEsuVt2Ig7LuA8hrsNiZ4g6p5nOLiygNeo4lor
         sq99wJthx0KVp1kLb29YzK35mw08cpUYEKNZzY+yVPvlP87AuaNxgrsKBi6eZa8Ivc8C
         ebeifPbi2MCqIBUJ9kTTadqB5qIN0O5rWfMbdQ7AqUFO5ia60dB+xaOpPOaSV3JbilbG
         PtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M7SLDhjFcKwH7+q3F8eYXlUPuBRQyFCKD7xK/RWvSBM=;
        b=eJ7LG/YydzHtwcIp3LcCA5QfI2Od0Lv1rw7ukrYLAhtPoT9iO3LHTJJwJDFo6ejD/G
         1HQh6bs389FUgwtrHOigVBmsRzsScoOSynXh3kecQTdZmYYZDriXLVf+kWFC1rnpQhSs
         vJjLNa2BfgnU1S5tOYtf6o8ohAxI8aLkZVl2f8Po87FBnC/m/sfG8HRKYyYWmtcGuHHg
         nU6qvpRlmfaBczR7xZh4aPxFE6AZSxXrGXbqCThbTXBaaTHwiTofszYQRR8cP9LNLxI/
         vuo+6mn1cvKsHs6BTex4zorn9eChXjuHIk3Uw8FLz01YRNSxfMi1shhUHVP2B27D4V7x
         /hlQ==
X-Gm-Message-State: AJcUuke/aTwxy0f6E+dx7z+WYUZk7NUpdWAZFWtdX5OcsRM8cYyQnD7R
        Cb3RERuKwAId+qiiWcHKzVmB4JB1Z88=
X-Google-Smtp-Source: ALg8bN7a3MkI463DC7UxFX44GUs/ET7arhbICNGK0ERZ3VNTV2wEoI71kharMvrriHb588sElpqhGw==
X-Received: by 2002:a1c:5a42:: with SMTP id o63mr13656061wmb.88.1547777626354;
        Thu, 17 Jan 2019 18:13:46 -0800 (PST)
Received: from localhost (83-215-98-136.stmi.dyn.salzburg-online.at. [83.215.98.136])
        by smtp.gmail.com with ESMTPSA id p139sm79063595wmd.31.2019.01.17.18.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 18:13:45 -0800 (PST)
Date:   Thu, 17 Jan 2019 18:13:42 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, netdev@vger.kernel.org,
        linux-mips@vger.kernel.org, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 0/8] net: mscc: PTP offloading support
Message-ID: <20190118021342.enounbkp7v7nqzj2@localhost>
References: <20190117100212.2336-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117100212.2336-1-antoine.tenart@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Thu, Jan 17, 2019 at 11:02:04AM +0100, Antoine Tenart wrote:
> This series adds support for the PTP offloading support in the Mscc
> Ocelot Ethernet switch driver. Both PTP 1-step and 2-step modes are
> supported.
> 
> In order to make use of the PTP offloading support, two new register
> banks were described in the Ocelot device tree. The use of those
> registers by the Mscc Ocelot Ethernet switch driver is made optional for
> dt compatibility reasons. For the same reason a new interrupt is
> described, and its use is also made optinal for compatibility reasons.
> All of this is done ine patches 1-5.
> 
> The PTP offloading support itself is added in patch 8.

The subject lines and this description are misleading.  You are not
offloading the Precision Time Protocol.  Instead, this series
implements a normal PHC driver.

Please change the text to avoid the phrase, "PTP offloading".

Thanks,
Richard

