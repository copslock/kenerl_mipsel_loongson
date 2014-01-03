Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Jan 2014 00:31:46 +0100 (CET)
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33151 "EHLO
        mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825727AbaACXbkygvim convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 4 Jan 2014 00:31:40 +0100
Received: by mail-wg0-f46.google.com with SMTP id m15so13802862wgh.13
        for <multiple recipients>; Fri, 03 Jan 2014 15:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hxT9jEGSvQJMjQduUhMoQeVs23FUqJcL+KrP5RlpXsM=;
        b=VWU/KN7mhLlkvw0lQccNF5Z5UyFQ6+yv/3hzrG+VhGJO0G0Ut9ebvfHg4qwzd9GkqN
         IE+3tiSaj31yiZlzfjVKO9s6BBhj2DZGvrES/bHukVx+nOs292Xd00AZvWIw1Qs8RRj8
         /7G3c+S8Oj+pFuHnxCzp/BBSe1/SwYNVq1fAgC9hWupHXrkKX9dXn4CPnTygrgphdPwg
         9Dk0yCAMwGZ8VB7jTZPbVr4meHtpFqHN3uKTrCQ/HRDntzra5A6uaLI3jr0pc0hhwFS1
         jUUVkYHwhY3v2VikI3FHxt7tDOL8tCkmtyhvKKRYP7nDLXZ/inYRN7XiQghs/kKeJuFd
         ix1A==
MIME-Version: 1.0
X-Received: by 10.194.86.70 with SMTP id n6mr1620274wjz.71.1388791895394; Fri,
 03 Jan 2014 15:31:35 -0800 (PST)
Received: by 10.216.161.137 with HTTP; Fri, 3 Jan 2014 15:31:35 -0800 (PST)
In-Reply-To: <1388778120-24880-1-git-send-email-hauke@hauke-m.de>
References: <1388778120-24880-1-git-send-email-hauke@hauke-m.de>
Date:   Sat, 4 Jan 2014 00:31:35 +0100
Message-ID: <CACna6rxgtTkJ_+JqxWsshJ1RVRVYzg=R6J_ua_K8y13cBrvOkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] MIPS: BCM47XX: fix detection for some boards
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
X-archive-position: 38865
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

2014/1/3 Hauke Mehrtens <hauke@hauke-m.de>:
> When a nvram reset was performed from CFE, it sometimes does not
> contain the productid value in nvram, but it still contains
> hardware_version.

Acked-by: Rafał Miłecki <zajec5@gmail.com>
