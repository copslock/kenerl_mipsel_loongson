Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 May 2012 09:23:28 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:55750 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903551Ab2E3HXX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 May 2012 09:23:23 +0200
Received: by dadm1 with SMTP id m1so7000325dad.36
        for <linux-mips@linux-mips.org>; Wed, 30 May 2012 00:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=HisjXCf9W63ht1XU06wkdgfMxMb9z6dQk45AzGGVYWs=;
        b=pJCzs3JOP7b+KYwhZDcjoJ9ur/lUS+M8o+TtwDSzluckjwsK6ouELNzugS2EAHDpBS
         2GcsjZcPaJ/jhx4WfsbHIiD+LQLTtJxPSyYLi/LQxYQ6SOPHSVRLDg+PhZ1iFi1YzwX1
         72bUqHv0duj1wcl8TsiveX+fPPZDX8GBRtdSSxCFREovL6zJlKiVfGmgaoRouNxc+XYK
         EgWkQTTR9at3wq+5XBBp86gkqk4kIbLz3Yr/nAGnrB3Vf8ujgJ0YVTmQJI8yRLzqjCnq
         6ZgVpx4Ogn8uVwlulcQJDhDQ0paLmnjgOfMtGrofr0zPXPu3biozp76sdALAbKmQPjn3
         IWLw==
Received: by 10.68.136.69 with SMTP id py5mr46518181pbb.115.1338362597109;
        Wed, 30 May 2012 00:23:17 -0700 (PDT)
Received: from localhost ([118.143.64.134])
        by mx.google.com with ESMTPS id jw3sm12840184pbc.65.2012.05.30.00.23.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 May 2012 00:23:16 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id 04A153E065C; Wed, 30 May 2012 15:23:13 +0800 (HKT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: RE: [PATCH V5 16/17] SPI: MIPS: lantiq: add FALCON spi driver
To:     "Langer Thomas (LQDE CPE AE SW)" <thomas.langer@lantiq.com>,
        John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "spi-devel-general@lists.sourceforge.net" 
        <spi-devel-general@lists.sourceforge.net>
In-Reply-To: <593AEF6C47F46446852B067021A273D6049FCE@MUCSE039.lantiq.com>
References: <1337521579-1597-1-git-send-email-blogic@openwrt.org> <20120525233845.BD93C3E0BD2@localhost> <4FC0DEEC.8050204@openwrt.org> <593AEF6C47F46446852B067021A273D6049FCE@MUCSE039.lantiq.com>
Date:   Wed, 30 May 2012 15:23:13 +0800
Message-Id: <20120530072314.04A153E065C@localhost>
X-Gm-Message-State: ALoCoQlSTnKN2kBfGLY9aB9zjFYl3gFKJU0OWCRwFS1lGLBEV/uxDsg/ZRTDQb0sFh77PW7pcrzf
X-archive-position: 33478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
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

On Tue, 29 May 2012 13:05:18 +0000, "Langer Thomas (LQDE CPE AE SW)" <thomas.langer@lantiq.com> wrote:
> Hello Grant, hello John,
> 
> John Crispin wrote on 2012-05-26:
> > 
> >> What exactly does this mean?  How does it not support any other type
> >> of SPI peripheral?  SPI is a really simple protocol, so what is it
> >> about this hardware that prevents it being used with other SPI
> >> hardware?
> >> 
> >> I see a big state machine that appears to interpret the messages and
> >> pretend to be an SPI slave instead of telling linux about the real
> >> device.  /me wonders if it should this instead be a block device
> >> driver?
> >> 
> > Thomas will need to comment on this part
> > 
> The hardware is an "EBU" (External Bus Unit) for different type of memories 
> and flashes (NOR, NAND and serial).
> One of the features of this EBU is the "execute in place" for serial flashes.
> This shows that there is some logic in the hardware for automatic reading,
> all other actions must be done using a specific cmd register.
> 
> Even if there are some restrictions from the hardware state machine,
> the goal was to use the standard driver for serial flash devices (m25p80).
> Otherwise, with a dedicated block device driver, we would have to duplicate
> much of this code and had to maintain an own list of supported flash chips.
> 
> I hope this reason is good enough for getting this driver accepted.

To be clear, I'm not going to nack the driver over this issue; but it
bothers me that I cannot understand what it is doing and I do wonder
if there is a better approach.

g.
