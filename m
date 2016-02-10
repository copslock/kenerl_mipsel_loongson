Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 00:35:17 +0100 (CET)
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34240 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011376AbcBIXfPMFesO convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Feb 2016 00:35:15 +0100
Received: by mail-lf0-f44.google.com with SMTP id j78so1691321lfb.1
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 15:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HRrWRxYbpWAwMmQNKM74BChlYFpXiRmiOREkYf8fN38=;
        b=VVrkqPV7Gw8NIy/iU822OZQCjQGS2ewwaG2OQWhfDwWCzKOM36EZnWVNftbbp+27Gc
         XUfipfnp8Tb95bIS2lKqH1/Dm923UtMDp74Py1WXGRsaU2/XQwLY7ZayMi4PxNV7M2JM
         yJ/fiCjM+y1kCc1dc0NcDjCvUtHFk4vRs4h7tmQZFeZDa+S06NihoO7vxbBom0l5WOco
         GmwlOmcjnMwbXVQ4bCm6ku7Xnd7kUzyYrNssLH14f7leEqnSS0dbhBaF097ZQdrPWsXt
         gwsuUMZfQFAihII44lv8rQ2Ejl6qXihIDfJ6q7QfX3GiZzgfu5VXhGZYSlNVMw3nm+Qi
         OniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=HRrWRxYbpWAwMmQNKM74BChlYFpXiRmiOREkYf8fN38=;
        b=QjCbwuYSAkZUTH7W/vBhlUgVXYeiIG0qplA1lwo/nXX5BWqQJpGo4sKw26+jAQndRB
         qziPR/zqKtfNhVdJvF88E4ccKdU22rmt2eBXm7izjpM8YJwevbyRu9UzQL6YhF3Rj7jg
         Q0BzDt0w22EPKnPXNZj2QFCXpn5bP7IHZNcZ1t33vYrM8JjA4MrDbYa9bOkEfqKcsrqw
         9RyaY5HcCRQmfoF/Ia03La/q1sb/PGsOupsd3AVvuhiipvehKAW0cKwglTvL3vS2nKHy
         WNrlI1xdcE9L1Qja/4TcZfxOy41/R/8HfUWgab2t+85a8HimC8BYxBBKP/4scoCFtJWN
         q0yg==
X-Gm-Message-State: AG10YORWMbeU/iF1du3Tchm+mDv6IRr0hipRWBf3ZdUSu8WQfq9SJiWiiyYGhudZF4C0mQ==
X-Received: by 10.25.23.220 with SMTP id 89mr15268197lfx.49.1455060909793;
        Tue, 09 Feb 2016 15:35:09 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id p124sm46735lfe.31.2016.02.09.15.35.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 09 Feb 2016 15:35:09 -0800 (PST)
Date:   Wed, 10 Feb 2016 03:00:44 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Marek Vasut <marex@denx.de>,
        Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v5 07/15] usb: ehci: add vbus-gpio parameter
Message-Id: <20160210030044.7c4428af97245f2bbf995f01@gmail.com>
In-Reply-To: <20160209231520.727b6ccd@tock>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
        <1455005641-7079-8-git-send-email-antonynpavlov@gmail.com>
        <20160209231520.727b6ccd@tock>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Tue, 9 Feb 2016 23:15:20 +0100
Alban <albeu@free.fr> wrote:

> On Tue,  9 Feb 2016 11:13:53 +0300
> Antony Pavlov <antonynpavlov@gmail.com> wrote:
> 
> > This patch retrieves and configures the vbus control gpio via
> > the device tree.
> 
> Wouldn't using a regulator be better than hard coding the GPIO case?
> 

Marek Vasut has noted that it is possible to use compatible = "chipidea,usb2",
which makes it possible to connect fixed vbus regulator via "vbus-supply" property.

I'll try to use fixed-regulator in RFC v6.

-- 
Best regards,
  Antony Pavlov
