Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Feb 2014 07:27:25 +0100 (CET)
Received: from mail-oa0-f47.google.com ([209.85.219.47]:58727 "EHLO
        mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826068AbaB1G1XjAQYF convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Feb 2014 07:27:23 +0100
Received: by mail-oa0-f47.google.com with SMTP id h16so3596860oag.20
        for <multiple recipients>; Thu, 27 Feb 2014 22:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XvHH6R56/krit0ekWlRrBVUhRsJxVRA7H1icv6nwnR0=;
        b=D7UvNeayB9pO4/mScE982xW8qhse0qwKthyi4aiCNRn4A5+DvbjRpwQZAq/1pJ549E
         RixJwdAG9YLTBFScl3mK+nYigyniVKH8Z/l2ntXtAxxUq/fyKPHN93C5RHdnqtbZBnUT
         V1mG2o5NlCmkgSL8CxYoPDGPDjgZ2CzPzOnr6u+UpEOeoLaXUJesmfj0m3VI9JmZusCO
         DB6YgJTS5zFz2OVriXBSQd1L7dmZj/IpQyfQEoyzGpMvIBUr/zHhF3rD4vY+4U3VtAfv
         TSsj5G2AvmrEYdfSexuGn7LTk3RFgmk7nmDyymVAOslFyFBdWZrxaZGVKNKMaksMaESX
         bCHg==
MIME-Version: 1.0
X-Received: by 10.182.117.195 with SMTP id kg3mr11790573obb.17.1393568836885;
 Thu, 27 Feb 2014 22:27:16 -0800 (PST)
Received: by 10.76.71.99 with HTTP; Thu, 27 Feb 2014 22:27:16 -0800 (PST)
In-Reply-To: <1392310092-27365-1-git-send-email-zajec5@gmail.com>
References: <1392310092-27365-1-git-send-email-zajec5@gmail.com>
Date:   Fri, 28 Feb 2014 07:27:16 +0100
Message-ID: <CACna6ryED3bATWzR9uZOyyhcEbOLtCpvQ3D3MOa8R-_5pE0_2Q@mail.gmail.com>
Subject: Re: [3.14 FIX][PATCH] MIPS: BCM47XX: Check all (32) GPIOs when
 looking for a pin
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

2014-02-13 17:48 GMT+01:00 Rafał Miłecki <zajec5@gmail.com>:
> Broadcom boards support 32 GPIOs and NVRAM may have entires for higher
> ones too. Example:
> gpio23=wombo_reset

Ping? Guys?
