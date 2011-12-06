Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2011 22:01:46 +0100 (CET)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:60931 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903633Ab1LFVBm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Dec 2011 22:01:42 +0100
Received: by laah2 with SMTP id h2so882785laa.36
        for <multiple recipients>; Tue, 06 Dec 2011 13:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:date:in-reply-to:references
         :content-type:x-mailer:content-transfer-encoding:message-id
         :mime-version;
        bh=6xPmG5q/GPSWaSaDrEKTed2oIT0hLQ6nIugpCeI3dOU=;
        b=gY7TEvuqkxKB52+ZwzsBVaFOfry7jmUhewa2fiH4OPCL6SSAk5tvYOMmJQ0mRAup/p
         t05qQsvNTcww5+ipiyM7obfI/bPIWYM91tbb1Ms/jx0zUQVMGanHRvwwqjAVvc9tg3E0
         6qRQcciLOQyhAqw75tLDjB6gZ1hw4eXh6RBSA=
Received: by 10.152.110.102 with SMTP id hz6mr10080198lab.11.1323205296940;
        Tue, 06 Dec 2011 13:01:36 -0800 (PST)
Received: from [192.168.255.2] (host-94-101-1-70.igua.fi. [94.101.1.70])
        by mx.google.com with ESMTPS id py2sm4918016lab.2.2011.12.06.13.01.34
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 13:01:36 -0800 (PST)
Subject: Re: [PATCH 0/7] MTD: MAPS: remove bcm963xx-flash
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <florian@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
Date:   Tue, 06 Dec 2011 23:01:33 +0200
In-Reply-To: <CAOiHx==avQMJiATzfcgHKe4AP8D2fjHyirG4RpT4hmeakabcZA@mail.gmail.com>
References: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
         <1323172965.2163.5.camel@koala>
         <CAOiHx==avQMJiATzfcgHKe4AP8D2fjHyirG4RpT4hmeakabcZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
Content-Transfer-Encoding: 7bit
Message-ID: <1323205296.2710.1.camel@koala>
Mime-Version: 1.0
X-archive-position: 32046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4983

On Tue, 2011-12-06 at 13:13 +0100, Jonas Gorski wrote:
> And these patches do apply cleanly for me on my local copy of your git
> (latest commit from 29 hours ago according to gitweb).

Sorry, indeed they apply cleanly, I used wrong branch. Pushed to
l2-mtd-2.6.git, thanks.

Artem.
