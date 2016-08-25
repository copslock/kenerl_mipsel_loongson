Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2016 03:30:44 +0200 (CEST)
Received: from mail-ua0-f181.google.com ([209.85.217.181]:36080 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992240AbcHYBafZ4bcA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Aug 2016 03:30:35 +0200
Received: by mail-ua0-f181.google.com with SMTP id m60so19577111uam.3
        for <linux-mips@linux-mips.org>; Wed, 24 Aug 2016 18:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyportsystems.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OD/rfNzVAhfGCFrhcFp6B7QXsHKe+VzdipjXWdWpQ3s=;
        b=vB3Qi96XwSzKalSWmIs+hsdiGAsynzYgzussE+eRA9DKOiBAmJhnIM6lLbIiCfzI69
         9C6jJSJ4uNazO7emr/vSyAB20ex9apsNMwjHLDdBDOuvHyHoweyn5WLTFwnWY//+isU1
         5nbpT4WB50UN9IPrKo0pw6qAd3w855VxPjvRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OD/rfNzVAhfGCFrhcFp6B7QXsHKe+VzdipjXWdWpQ3s=;
        b=A/DUeAgw1hnBcfUWlb1ZbgIk7J57vnEBWbzmg6DoLPC5FtEVbjn1nUTtE0ZEUM3Hwl
         4/Ez7SY3kgV/ntRHCtJA9gHXF19iHvuRK9cY93x5GWrn3UggU/12qFT6mKkKi1tTSDJQ
         vpFop1QxFTLXp+V3LGL2MIc3vSCSl/Rmb1Mb6GVQRnXb73TxbFnrmAsOf/JLRNSfmx3y
         4zb/G4OKlrWX8y1/cv0RjvAJPiiADXV+ipCNiZOa+CsqMRVr6guv59PNare5SS15KyWS
         JHzqOv3fzNmdA12sHWOrBBmkqVOgyBrGaGrkwbY7UgXu7+j5GGFKIV5TqKG+bnVa+Ynf
         QpGA==
X-Gm-Message-State: AEkoouunD+rFTcOXom5QgFx5yV1bNhOEB1xa12ZLXdv2fPfypsQOlQMmJhJfqh9waPquZ8YUAWSSBxQUzNF9rI3y
X-Received: by 10.31.171.214 with SMTP id u205mr3517197vke.119.1472088629505;
 Wed, 24 Aug 2016 18:30:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.159.86 with HTTP; Wed, 24 Aug 2016 18:29:49 -0700 (PDT)
From:   Ed Swierk <eswierk@skyportsystems.com>
Date:   Wed, 24 Aug 2016 18:29:49 -0700
Message-ID: <CAO_EM_nrb0M49YwU+gjL+bqT4V1rFj4z7DQ8juTYXgaoKet0mg@mail.gmail.com>
Subject: Improving OCTEON II 10G Ethernet performance
To:     linux-mips <linux-mips@linux-mips.org>,
        driverdev-devel <devel@driverdev.osuosl.org>,
        netdev <netdev@vger.kernel.org>
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <eswierk@skyportsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eswierk@skyportsystems.com
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

I'm trying to migrate from the Octeon SDK to a vanilla Linux 4.4
kernel for a Cavium OCTEON II (CN6880) board running in 64-bit
little-endian mode. So far I've gotten most of the hardware features I
need working, including XAUI/RXAUI, USB, boot bus and I2C, with a
fairly small set of patches.
https://github.com/skyportsystems/linux/compare/master...octeon2

The biggest remaining hurdle is improving 10G Ethernet performance:
iperf -P 10 on the SDK kernel gets close to 10 Gbit/sec throughput,
while on my 4.4 kernel, it tops out around 1 Gbit/sec.

Comparing the octeon-ethernet driver in the SDK
(http://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto-contrib/tree/drivers/net/ethernet/octeon?h=apaliwal/octeon)
against the one in 4.4, the latter appears to utilize only a single
CPU core for the rx path. It's not clear to me if there is a similar
issue on the tx side, or other bottlenecks.

I started trying to port multi-CPU rx from the SDK octeon-ethernet
driver, but had trouble teasing out just the necessary bits without
following a maze of dependencies on unrelated functions. (Dragging
major parts of the SDK wholesale into 4.4 defeats the purpose of
switching to a vanilla kernel, and doesn't bring us closer to getting
octeon-ethernet out of staging.)

Has there been any work on the octeon-ethernet driver since this patch
set? https://www.linux-mips.org/archives/linux-mips/2015-08/msg00338.html

Any hints on what to pick out of the SDK code to improve 10G
performance would be appreciated.

--Ed
