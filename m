Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2015 22:24:02 +0100 (CET)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35375 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008790AbbLVVYAl-GkA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2015 22:24:00 +0100
Received: by mail-pa0-f45.google.com with SMTP id jx14so95012264pad.2
        for <linux-mips@linux-mips.org>; Tue, 22 Dec 2015 13:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MjJmWN35KTmQoi1o3rsGUDmRCKJ0bY+TSBxamEI3QlQ=;
        b=kZDXEp2G46LGNeVagFESsQRa34IeGXUb/3pmAJ2UE/znL7lRaz1Y8dVfEw9LIuuUcv
         7PU15JUki2Kn9c1EtC7XRwA7J2lXGm9sD8BeOEh/XgLKB65zMmxx+yubg1kVWhg/sM6U
         8S4H2DZf3y7sQtHFxVdlOfmI6vQWZc2L1LrjHuWNOWXd0GPanz8PiK58VqcejEDGv2l5
         rfQaMGcEWHBv7/f21OUSkQQcO4rpI05I8qOXL6rV8xbf8t9rSGKIUeFy/Ov9KwZie2VV
         9p8gbyslWEf7Sxta6lXfmF9uR++GS2VKVNLgOhnR8g6fNbRkfrfNKeqSbr+JEeqUl+gG
         7vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=MjJmWN35KTmQoi1o3rsGUDmRCKJ0bY+TSBxamEI3QlQ=;
        b=HN0whec6vCfw5SK2m2ZTa+YSXJIWH4xhO06FQ/NIlh3T/un6ZlQe7RvGWZPw2U3wX4
         A0B+uthpBgYMuHq5ZE+YYDLhfgY5fj0XCTuCBLCIfQPItkqG0BKsX2kxGED0ebcWKP3X
         a9STQjupmHVlU+85KULVTA1YhUjZi8L+VxZbRzkpSN1tdZzeIF0zwqV86JvKXNV/udAY
         CDhdFKUoD30tnZf+72xmmKLugJ4ARPE0mNPY0vKOaDJ/OzOcml/b8d6vxJtumVoF/T8V
         dkcAPDstNdZLRes83ACL9H5vbfIKU82Y02m7/LV7tfu5Iu96j1bcnsJAiEAglmta8RQc
         /OWg==
X-Gm-Message-State: ALoCoQmyS9U2HEhpvOVNbcS7myXKiM08O7QMZaz3NRNhGtE/8okq3yKIMLUoDCOpgjbFWKW/tGSFCQh8s75BjU8bJvQR6ITQKw==
X-Received: by 10.66.140.39 with SMTP id rd7mr38772171pab.86.1450819434734;
        Tue, 22 Dec 2015 13:23:54 -0800 (PST)
Received: from localhost ([2620:0:1000:fd1f:a01d:b55d:7883:cc13])
        by smtp.gmail.com with ESMTPSA id 15sm43197800pfo.43.2015.12.22.13.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2015 13:23:53 -0800 (PST)
Date:   Tue, 22 Dec 2015 13:23:50 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     arm@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] ARM: dts: Add compatible property to "partitions"
 node
Message-ID: <20151222212350.GF30172@localhost>
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <olof@lixom.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: olof@lixom.net
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

Hi,

On Mon, Dec 21, 2015 at 11:33:44AM +0100, Geert Uytterhoeven wrote:
> 	Hi,
> 
> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
> property to "partitions" node"), which is in v4.4-rc6, the "partitions"
> subnode of an SPI FLASH device node must have a compatible property. The
> partitions are no longer detected if it is not present.
> 
> However, several DTSes in -next have already been converted to the
> "partitions" subnode without "compatible" property, introduced by
> commits 5cfdedb7b9a0fe38 ("mtd: ofpart: move ofpart partitions to a
> dedicated dt node") and fe2585e9c29a650a ("doc: dt: mtd: support
> partitions in a special 'partitions' subnode"). Hence all of these are
> now broken in -next, and will be broken in upstream during the merge
> window.

So, if I understand this correctly, the partitions format was added for v4.4,
then this non-backwards compatible change was added in -rc6. But, there were
also DT files that had the new-for-v4.4 partitions nodes in them that then
stopped working in -rc6?

That sounds like a regression, so this should be picked up as fixes for v4.4.

Please confirm that I've understood the setup correctly, and I'll apply the
series directly to fixes.


-Olof
