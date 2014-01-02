Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 21:54:08 +0100 (CET)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:38957 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823075AbaABUyFECd9f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 21:54:05 +0100
Received: by mail-ob0-f178.google.com with SMTP id uz6so14774756obc.23
        for <multiple recipients>; Thu, 02 Jan 2014 12:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JHvfYKGL01KhciW9VdJ9LlPCbwyk9SvSGzLSTFNfpFU=;
        b=JiJE7ij9L19+nGaAm3GrSe4NwNIcdY4QiEMDk/fH7jPj0awVgeUEaG7CEmSDJJG7ZB
         4hnjbRVhhoGdFTTIQGFOejUNwtwSGRiyAwZdmSXYBpvhQSBFr+O2qQ36PNwzm1xo0JSA
         zabK7b9iyVv8QEkuaR5m8xh7x143OP/amugr5+C2mlTPIT/k83M06FJimN9Jq6MczdlW
         f73n126JDIRga+j3KGGuGIAKXemIxwJ7A5M19SUcqvOPXOwGOizznNFqq3Z+EHzqhjeX
         HCDVj/5cj29wCp7s4MCZg4gUNz1z4ft4HGEeX8dOpLoST7rG4wlRXWbsRWKrM66nPRMJ
         clOw==
MIME-Version: 1.0
X-Received: by 10.60.174.167 with SMTP id bt7mr5650055oec.54.1388696038613;
 Thu, 02 Jan 2014 12:53:58 -0800 (PST)
Received: by 10.76.69.7 with HTTP; Thu, 2 Jan 2014 12:53:58 -0800 (PST)
In-Reply-To: <1388687138-8107-3-git-send-email-hauke@hauke-m.de>
References: <1388687138-8107-1-git-send-email-hauke@hauke-m.de>
        <1388687138-8107-3-git-send-email-hauke@hauke-m.de>
Date:   Thu, 2 Jan 2014 21:53:58 +0100
Message-ID: <CACna6rxX871CsHYw+-=J6nRZRnTNLFWAhLT9dweV=Z0Ut7y0vA@mail.gmail.com>
Subject: Re: [PATCH 3/4] MIPS: BCM47XX: add board detection for Linksys
 WRT54GS V1
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, blogic@openwrt.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38847
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
> This adds board detection for Linksys WRT54GS V1.

Could you check NVRAM for something that could be more model specific?
eou_device_id maybe?
