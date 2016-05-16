Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2016 15:12:09 +0200 (CEST)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33590 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27028934AbcEPNMDOW09K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2016 15:12:03 +0200
Received: by mail-lf0-f65.google.com with SMTP id j8so14504156lfd.0
        for <linux-mips@linux-mips.org>; Mon, 16 May 2016 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=93QqsFs88BMbiAf7BYViYsEse72kNAMBtV2FhoEZMPc=;
        b=sVnm3hP22CxTuu+8tWO/Qud4g+8l5ssdhA+Twdj1VxG984Ru+KvPifX6yDUI/UQjkD
         LWkLxFypiYAO8cBiiXHRcX+HE/AVu0CggDD3iujVSd3UOpBiwzNmtP+5x0/DP+wB4vv5
         Arqk+VUPXoi8usAg4w5SwEIoIK4ID0wfZpJlxZOmfEoNKE6wySqrWiZF1j9svNop87ni
         Hp2GgcHg8pfHwqG702JMsvSs7puAbohCdOVSmdU4aEBwBiv8GG7YVjiFznz2xQcnwT7X
         sheOa/okWJcsef9lj/EaVpRw0pIYSpo8cnxrBbQJarDFEzxVBknWjr7fyNPguqYDyJRb
         cI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=93QqsFs88BMbiAf7BYViYsEse72kNAMBtV2FhoEZMPc=;
        b=b7A3Hbid4S2HEA59zousz+mpUnXHMEaHJsP2wiXWPWWS3dLLvABuH44zKrlmacVr4h
         Qk2CfSDM4Oh3C5Is5Zdakv9hn/stpWJb1F9cD4GaZm+PZgfhencHXGOROMQCxQBY0fom
         HYHkm2QTBmbk9uwOR5YQHtNVXAr0SBui5ZJaxqH9CVsdzJQtDF99fbi/0+BRflJcAv2e
         9MrnHGYmavKS1+OI4YT2OLYRyKhuiYQXa2/BHH8wJutXGMakejGEyrxYucgxvhkYdV8H
         vjROnHSpcFFQ/AllRwRshQGJSBwDLbAvUGl1INrxVkwljEG9pb9cz/grPx1t0DDqcJwY
         Ex5w==
X-Gm-Message-State: AOPr4FUdBn33JhGp7hoz6jXUaTN/9wEm8S9YiovkMsg0gRochBveGiqt475Iljv8Cx2m7A==
X-Received: by 10.25.156.136 with SMTP id f130mr5400836lfe.141.1463404317616;
        Mon, 16 May 2016 06:11:57 -0700 (PDT)
Received: from lnxartpec.se.axis.com (rocksteady.se.axis.com. [195.60.68.156])
        by smtp.gmail.com with ESMTPSA id c20sm5361672lfb.21.2016.05.16.06.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2016 06:11:56 -0700 (PDT)
Date:   Mon, 16 May 2016 15:11:35 +0200
From:   Rabin Vincent <rabin@rab.in>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rabin Vincent <rabin.vincent@axis.com>,
        "David S. Miller" <davem@davemloft.net>, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        Rabin Vincent <rabinv@axis.com>
Subject: Re: [PATCH] phy: remove irq param to fix crash in fixed_phy_add()
Message-ID: <20160516131134.GA31094@lnxartpec.se.axis.com>
References: <1463397356-5656-1-git-send-email-rabin.vincent@axis.com>
 <20160516122903.GA27725@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160516122903.GA27725@lunn.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <rabin.vincent@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rabin@rab.in
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

On Mon, May 16, 2016 at 02:29:03PM +0200, Andrew Lunn wrote:
> What i think is better is to make fixed_phy_add() return -EPROBE_DEFER
> if it is called before fixed_mdio_bus_init().

I don't see how this will work for platforms such as ar7 and bcm47xx
which call fixed_phy_add() from platform code.  There is no probe to
retry there so while the EPROBE_DEFER will certainly fix the crash it
will also leave the platforms without a phy.
