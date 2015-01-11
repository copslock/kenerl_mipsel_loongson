Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2015 02:43:04 +0100 (CET)
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48173 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011180AbbAKBnD333Xo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jan 2015 02:43:03 +0100
Received: from mfilter11-d.gandi.net (mfilter11-d.gandi.net [217.70.178.131])
        by relay4-d.mail.gandi.net (Postfix) with ESMTP id 3258A172070;
        Sun, 11 Jan 2015 02:43:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter11-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
        by mfilter11-d.gandi.net (mfilter11-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id G2D9wtcwF8KJ; Sun, 11 Jan 2015 02:43:01 +0100 (CET)
X-Originating-IP: 88.159.34.112
Received: from starbug-2.treewalker.org (unknown [88.159.34.112])
        (Authenticated sender: relay@treewalker.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B7F14172055;
        Sun, 11 Jan 2015 02:43:00 +0100 (CET)
Received: from hyperion.localnet (hyperion.trinair2002 [192.168.0.43])
        by starbug-2.treewalker.org (Postfix) with ESMTP id 4C60D50B98;
        Sun, 11 Jan 2015 02:43:00 +0100 (CET)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/3] MIPS: jz4740: Move reset code to the watchdog driver
Date:   Sun, 11 Jan 2015 02:43 +0100
Message-ID: <1766434.QjfqQROysC@hyperion>
User-Agent: KMail/4.14.3 (Linux/3.11.10-25-desktop; KDE/4.14.3; x86_64; ; )
In-Reply-To: <54B1CF4B.3070503@roeck-us.net>
References: <1420914550-18335-1-git-send-email-lars@metafoo.de> <1420914550-18335-3-git-send-email-lars@metafoo.de> <54B1CF4B.3070503@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <maarten@treewalker.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
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

On Saturday 10 January 2015 17:18:03 Guenter Roeck wrote:
> On 01/10/2015 10:29 AM, Lars-Peter Clausen wrote:
> > @@ -186,9 +208,20 @@ static int jz4740_wdt_probe(struct platform_device
> > *pdev)> 
> >   	if (ret < 0)
> >   		goto err_disable_clk;
> > 
> > +	drvdata->restart_handler.notifier_call = jz4740_wdt_restart;
> > +	drvdata->restart_handler.priority = 128;
> > +	ret = register_restart_handler(&drvdata->restart_handler);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "cannot register restart handler, %d\n",
> > +			ret);
> > +		goto err_unregister_watchdog;
> 
> Are you sure you want to abort in this case ?
> After all, the watchdog would still work.

That raises a similar question: what about the opposite case, where the 
watchdog registration fails? If the resource acquisition part of the probe 
fails, neither the watchdog nor the restart functionality is going to work, 
but if the call to watchdog_register_device() fails, the restart handler 
would still work.

Bye,
		Maarten
