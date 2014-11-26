Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 14:33:16 +0100 (CET)
Received: from mail-wi0-f170.google.com ([209.85.212.170]:43207 "EHLO
        mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007196AbaKZNdOlhbBA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 14:33:14 +0100
Received: by mail-wi0-f170.google.com with SMTP id bs8so15152909wib.1
        for <linux-mips@linux-mips.org>; Wed, 26 Nov 2014 05:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=gVoK+Hnwj3C8JFwhdjmM/9VYWCpVRl4zCKokOgmRdzM=;
        b=WZu/D8NmwNc9s/wBgdrxqb6ypBDcWaduZUnc3tWfzQLT/32n0f79D/uzdBA2AF/Y31
         wnBUzijidiYW/gsc5R4gVWVgo8WF+i5snhSe90VJMQ70kfJuizSfxOsbLGRl21yhnMxc
         Npz9gpiT/oXclGbfgIW4lCSwtZ7+bfhO9zFNwpHzX6/NeOrJddkd1WtAiY29nfvitzHa
         U0Kgi0dCd8yCzsqbVbRrbXtZ9Mfq5qeK9YuKi8X2Iu6lJD4XjhVzESQstC6YEApFB27D
         nYCnxWRVXwBwGHeyXDr/0Jfaml6ICq3hSDTfgHXsHlFyfuNhkqKvpx2RM1wuvhddsNbr
         DV1Q==
X-Gm-Message-State: ALoCoQmYKD8uRYR17+n/SJdYzxet6sBJXXFnfPxDhaBkeTNdD+jZmrR4yOXS9S602FZkKZkY0JxX
X-Received: by 10.180.84.132 with SMTP id z4mr41313463wiy.55.1417008789126;
        Wed, 26 Nov 2014 05:33:09 -0800 (PST)
Received: from trevor.secretlab.ca (host86-166-84-117.range86-166.btcentralplus.com. [86.166.84.117])
        by mx.google.com with ESMTPSA id fm10sm6375675wjc.43.2014.11.26.05.33.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2014 05:33:08 -0800 (PST)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 659E9C4099B; Wed, 26 Nov 2014 13:33:06 +0000 (GMT)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH V2 01/10] tty: Fallback to use dynamic major number
To:     Kevin Cernekee <cernekee@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, daniel@zonque.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        tushar.b@samsung.com
In-Reply-To: <CAJiQ=7DOxK2NzmC9gGsnARxGMN8wRQyGX+5u5YC_vt00ADVsDg@mail.gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
        <1415825647-6024-2-git-send-email-cernekee@gmail.com>
        <20141125203431.GA9385@kroah.com>
        <CAJiQ=7DOxK2NzmC9gGsnARxGMN8wRQyGX+5u5YC_vt00ADVsDg@mail.gmail.com>
Date:   Wed, 26 Nov 2014 13:33:06 +0000
Message-Id: <20141126133306.659E9C4099B@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Tue, 25 Nov 2014 15:37:16 -0800
, Kevin Cernekee <cernekee@gmail.com>
 wrote:
> On Tue, Nov 25, 2014 at 12:34 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Wed, Nov 12, 2014 at 12:53:58PM -0800, Kevin Cernekee wrote:
> >> From: Tushar Behera <tushar.behera@linaro.org>
> >
> > This email bounces, so I'm going to have to reject this patch.  I can't
> > accept a patch from a "fake" person, let alone something that touches
> > core code like this.
> >
> > Sorry, I can't accept anything in this series then.
> 
> Oops, guess I probably should have updated his address after the V1
> emails bounced...
> 
> Before I send a new version, what do you think about the overall
> approach?  Should we try to make serial8250 coexist with the other
> "ttyS / major 4 / minor 64" drivers (possibly at the expense of
> compatibility) or is it better to start with a simpler, cleaner driver
> like serial/pxa?

Co-existing really needs to be fixed. The way to handle this might be to
blacklist the creation of the first 4 8250 devices on certain platforms.
It's going to be painful unfortunately.

g.
