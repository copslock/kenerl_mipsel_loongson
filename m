Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 19:21:01 +0100 (CET)
Received: from mail-oa0-f50.google.com ([209.85.219.50]:63442 "EHLO
        mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821116AbaABSU7YnqZN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 19:20:59 +0100
Received: by mail-oa0-f50.google.com with SMTP id n16so15064070oag.37
        for <multiple recipients>; Thu, 02 Jan 2014 10:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wspQ7029hm39pDu+8NjqfQkl2x5EbnBj+dn8xFEhpm0=;
        b=sxheA60pVcBPU+AnL30gB6gdHK25amf6lyt2B/so752wMBxq8TAEKH6oVhPvhLTyzS
         Onn24LyuH6yMTbJ8Ww7ZqCBj0EB9I6H2UpNXjb6pQ0sI+7JuhOJGFUAZmdclummESQMp
         zZOBgmG3ZZAVtCp6YHzE/TV0ENSTC7f/218mk+ICXCbbBw1m8O52YBnT9YkpvMdx4u6J
         /eKfohL3OXNfWpU9V0j4GP/O4BGMAanygHrDsyQUB2ZUQe8l8o8657ma5q/g5S40oE3P
         /EY0/iSP28hZD5s6Di7hv06en/nCVfuIpiq2yMn+EgOz/A0qb8Q5XF4pLrov0dJI82k8
         H/KA==
MIME-Version: 1.0
X-Received: by 10.182.81.197 with SMTP id c5mr56686910oby.40.1388686852770;
 Thu, 02 Jan 2014 10:20:52 -0800 (PST)
Received: by 10.76.69.7 with HTTP; Thu, 2 Jan 2014 10:20:52 -0800 (PST)
In-Reply-To: <1388685668-19616-1-git-send-email-hauke@hauke-m.de>
References: <1388685668-19616-1-git-send-email-hauke@hauke-m.de>
Date:   Thu, 2 Jan 2014 19:20:52 +0100
Message-ID: <CACna6rzzoDw05SQXQ1WTOnFXjn0jTV1LBd_a1QsgkdE9u4AP1g@mail.gmail.com>
Subject: Re: [PATCH] bcma: prevent irq handler from firing when registered
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, blogic@openwrt.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38840
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
> With this patch we prevent the irq from being fired when it is
> registered. The Hardware fires an IRQ when input signal XOR polarity
> AND gpio mask is 1. Now we are setting polarity to a vlaue so that is
> is 0 when we register it.
>
> In addition we also set the irq mask register to 0 when the irq handler
> is initialized, so all gpio irqs are masked and there will be no
> unexpected irq.

Sorry for this problem. Since the generated event was button release
one, I didn't notice this problem. Glad you were more careful when
testing it.

Thanks for the patch!
