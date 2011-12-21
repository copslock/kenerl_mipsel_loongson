Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2011 00:25:26 +0100 (CET)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:61217 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903762Ab1LUXZX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Dec 2011 00:25:23 +0100
Received: by lahc1 with SMTP id c1so6131394lah.36
        for <linux-mips@linux-mips.org>; Wed, 21 Dec 2011 15:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=PhvsXONvCVcB7SJQH1WmpI8j9fwnyfXmRsXXUs47gR0=;
        b=FlfAQaKH1/JZtnLtI4VeOlEs/apzgGHkZxV1+X1RLzSc4fx7IQvA3QNjAoc4zLJoNz
         BWc3MzqKu7nRbbqbdJMFyUHG8nN/ysfq3beuEoYrBRwjXxwQaJc44dLcjR4BBrvbyXX3
         ldRi+Lg4GNnXHMYhpP4iTybmvudkXhx504QnA=
MIME-Version: 1.0
Received: by 10.152.128.98 with SMTP id nn2mr7347650lab.14.1324509917983; Wed,
 21 Dec 2011 15:25:17 -0800 (PST)
Received: by 10.152.11.194 with HTTP; Wed, 21 Dec 2011 15:25:17 -0800 (PST)
Date:   Wed, 21 Dec 2011 17:25:17 -0600
Message-ID: <CAMB9WxLyQ9kFV96rquZDNL+86hDjtTh=0sydwQWyuUaAzm5dgA@mail.gmail.com>
Subject: Power management on ar71xx
From:   Harsha Chenji <cjkernel@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 32152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cjkernel@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17613

Hello list,

I was trying to get some power savings working on my AR7161 chipset
using OpenWRT, but I was unsuccessful.

Since mips24kc supports the wait instruction, shouldn't sleeping be
supported too? Is anyone working on this platform currently?

Thanks,
Harsha
