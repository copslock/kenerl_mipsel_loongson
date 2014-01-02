Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 21:47:59 +0100 (CET)
Received: from mail-ob0-f172.google.com ([209.85.214.172]:64838 "EHLO
        mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823075AbaABUrzfRVT2 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Jan 2014 21:47:55 +0100
Received: by mail-ob0-f172.google.com with SMTP id gq1so14996127obb.31
        for <multiple recipients>; Thu, 02 Jan 2014 12:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ggQBzgqKUMXXtgXLy7tOLTwwrdFGslWgL9EVkXARdoU=;
        b=nbkVF4CcuU4ASyVaODAux4wIPFEG5DQcTAey2sB7Tl0C8PMVjyEiJu6VpM14Y37RDH
         6u2EE/GF6ncGZm0x3dC74ZgZWhxjjTm1Ydx4aEGb0/CKC1QCesak9EoJmzU0if3T9pyI
         GIgmFUp42h98vdK+cQn6MZjRIPFJlWb+38FAKBJFx0xb7ea3M1rfBgd7jqPe+Hd2w9uD
         tv9U6Ng4WvdVTl/POFbm3NQxymsWJFLzlL8MY1z+Hru2jZkmKSd8FxfYiWGuQBTaZQBo
         9uw+aVQtU3bjNt5kg6/RzpLDTuGv+3C9JspIXxd4Kt/jz8RnLwpir47FED29hV4qmCLz
         q/Ug==
MIME-Version: 1.0
X-Received: by 10.182.99.231 with SMTP id et7mr56068680obb.10.1388695668908;
 Thu, 02 Jan 2014 12:47:48 -0800 (PST)
Received: by 10.76.69.7 with HTTP; Thu, 2 Jan 2014 12:47:48 -0800 (PST)
In-Reply-To: <1388687138-8107-2-git-send-email-hauke@hauke-m.de>
References: <1388687138-8107-1-git-send-email-hauke@hauke-m.de>
        <1388687138-8107-2-git-send-email-hauke@hauke-m.de>
Date:   Thu, 2 Jan 2014 21:47:48 +0100
Message-ID: <CACna6rw3Y7GwitM4nma+MHVj1spqOyv1F4GWJtaA+e5TTHjnug@mail.gmail.com>
Subject: Re: [PATCH 2/4] MIPS: BCM47XX: fix detection for some boards
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, blogic@openwrt.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38846
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

2014/1/2 Hauke Mehrtens <hauke@hauke-m.de>:
> When a nvram reset was performed from CFE, it sometimes does not
> contain the productid value in nvram, but it still contains
> hardware_version.

It seems you switched to a very solid detection with that.

Why not remove old entries?

-- 
Rafał
