Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 13:04:31 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:60036 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870448Ab2JDLEQRrxm9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 13:04:16 +0200
Received: by mail-ee0-f49.google.com with SMTP id c1so286860eek.36
        for <multiple recipients>; Thu, 04 Oct 2012 04:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=R3rd0flkpiDRNZBwOWWwuShKp3pJlE7ZiTGJq3a3t5A=;
        b=djZEeGjuHqcSzR8F5za4rT3syE982KnK+FlclBmLZN4i5SMz/0xba2c+FAUZpOTA18
         Shus1/4iljvylEe7jpS6Kw+PvdmoL95RXhf1xJtQlHW6RNpm6I4kz9LiAQeGo7h+snxa
         ze0IMVDbhWIE/eGlvbwmZmQWIhjJLnBJI8s3ma+oN7h6HFkxZCRMN81VOnVvNXHoOU4h
         HboYb1RRC6LHb0twqoyEub8N/PeDMeaXmdzvTd9RgFk1iWe9UUiS4fWwuBzaA6PJ0h/y
         40ogOehqh43+B0kBPQLlb/f5+M/n9qVSu+p0VDIXjUjr/ZYj4cx+11j+8N12NXVjqqoY
         xEdw==
Received: by 10.14.213.201 with SMTP id a49mr4079305eep.4.1349289017300;
        Wed, 03 Oct 2012 11:30:17 -0700 (PDT)
Received: from bender.localnet ([2a01:e35:2f70:4010:fce8:6de0:f479:fd83])
        by mx.google.com with ESMTPS id z3sm11019394eel.15.2012.10.03.11.30.14
        (version=SSLv3 cipher=OTHER);
        Wed, 03 Oct 2012 11:30:15 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Wolfram Sang <w.sang@pengutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/25] MIPS: Octeon: use ehci-platform driver
Date:   Wed, 03 Oct 2012 20:30:13 +0200
Message-ID: <3792469.SZIVmLSlNr@bender>
Organization: OpenWrt
User-Agent: KMail/4.8.5 (Linux/3.2.0-31-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <506C6BBC.7090806@gmail.com>
References: <1349276601-8371-1-git-send-email-florian@openwrt.org> <1349276601-8371-10-git-send-email-florian@openwrt.org> <506C6BBC.7090806@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 34591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wednesday 03 October 2012 09:45:48 David Daney wrote:
> On 10/03/2012 08:03 AM, Florian Fainelli wrote:
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> >   arch/mips/cavium-octeon/octeon-platform.c |   43 
++++++++++++++++++++++++++++-
> >   1 file changed, 42 insertions(+), 1 deletion(-)
> 
> 
> NACK.
> 
> OCTEON uses device tree now (or as soon as I send in the corresponding 
> patches), so this would just be churning the code.

Please send the changes to enable Device Tree for EHCI and OHCI, and when both 
platform drivers get Device Tree capability we can easily change them.
-- 
Florian
