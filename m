Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 May 2016 03:23:52 +0200 (CEST)
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35467 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033826AbcE2BXueMfsU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 May 2016 03:23:50 +0200
Received: by mail-pf0-f179.google.com with SMTP id g64so53444848pfb.2
        for <linux-mips@linux-mips.org>; Sat, 28 May 2016 18:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySdRXCGmjyWaqoWmmca3ncosrKTbT/DeZ3pgNmLgGKc=;
        b=TzpDZt+SUVHLp1sznUja2adMr8aeia6CcGyqSWtfyl1ykEhUtMAleRRW4Gwj92ygee
         l23tZG5ylI89jBWNkghBSXWYZ4CJC6HbKzKCI/Ozw9PFSXrhc1DwzmO7nykII4Y/K63c
         A2SNUU8gQBjHtn8yYSongFlxRbumL0WLADjbkZTYds/GGV8ORjCdzfoNNPJ5cdzw93vM
         KNh5VZ1zGDt/ts21BRgM7MrQdvnYALnmMjvKPDaX95X01wh8CeDVMisVQCbU9d3UC0/b
         QT1KxFqIf+W01FBe96rHUpKlXgIvSdsCBiZbzCKAmZgL/bcTW+7gnIBcxFzMtig/F5/t
         sxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySdRXCGmjyWaqoWmmca3ncosrKTbT/DeZ3pgNmLgGKc=;
        b=ajRge6xT9kmNsf3v7V5BDPB4jSNNawxFwNoY1vB26DuoBTHaTJueovVXKwXbRt5mXA
         mtxsIq09uoaOl8aUL1XU4YT0ZVg5Sevw42QTSAK4yR9X0749+60eaZm3wRjnMfIPwuJl
         +CgIKkTkIbMWD76glHFFHLG5n7XE+tWzZ54F4eULrSFEKAtFv59LpPuE/thLlCUz4gl9
         lFZar3hIhsgiOywbA/uLCgYmVNYNam1lfQ/21s/LAQDbnJjZsI4EkErbgzMwMAy9lNBh
         U1CE61OkboPkvzo3NG2CzXdwBkcnOpxGO/gvMrUkK7bhpiz4A3JXuod2nblFkxZJfil6
         eiXA==
X-Gm-Message-State: ALyK8tIlTa7tDu/dUEEoj6i1yVgybdIh/bBVid2WIAHvHw3P+okivAjd0JITUDVz7VVtMg==
X-Received: by 10.98.21.210 with SMTP id 201mr34585119pfv.51.1464485024309;
        Sat, 28 May 2016 18:23:44 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:b546:9ef3:e6a7:b5eb? ([2601:645:c200:33:b546:9ef3:e6a7:b5eb])
        by smtp.gmail.com with ESMTPSA id v185sm23135040pfb.72.2016.05.28.18.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 May 2016 18:23:43 -0700 (PDT)
Message-ID: <1464485020.5020.28.camel@chimera>
Subject: Re: [PATCH v2] Re: Adding support for device tree and command line
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     linux-mips@linux-mips.org, hauke@hauke-m.de, jogo@openwrt.org,
        openwrt@kresin.me
Date:   Sat, 28 May 2016 18:23:40 -0700
In-Reply-To: <1464462306.5020.25.camel@chimera>
References: <20160524194818.9e8399a56669134de4baee1e@gmail.com>
         <1464383198-6316-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
         <20160528133152.cc8b7fad8665b20a3519f4e0@gmail.com>
         <1464462306.5020.25.camel@chimera>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

On Sat, 2016-05-28 at 12:05 -0700, Daniel Gimpelevich wrote:
> On Sat, 2016-05-28 at 13:31 +0300, Antony Pavlov wrote:
> >   Can we use 'if' instead of preprocessor's '#if' here?
> > 
> >   If we use regular C 'if' operator with IS_ENABLED() instead of
> > '#if/#ifdef'
> >   then the compiler can check all the code.
> > 
> >   E.g. please see this barebox patch:
> > 
> > 
> > http://lists.infradead.org/pipermail/barebox/2014-February/017834.html
> 
> Sigh. I guess I will resubmit again…

Upon further review, no, we cannot use 'if' instead of '#if' here. The
reference to the appended DTB would throw a linker error if the option
to put it there is not enabled. Sorry.
