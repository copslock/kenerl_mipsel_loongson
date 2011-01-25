Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2011 18:59:44 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:48928 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491766Ab1AYR7l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jan 2011 18:59:41 +0100
Received: by ewy20 with SMTP id 20so2546573ewy.36
        for <multiple recipients>; Tue, 25 Jan 2011 09:59:40 -0800 (PST)
Received: by 10.14.10.19 with SMTP id 19mr261453eeu.42.1295978380651;
        Tue, 25 Jan 2011 09:59:40 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id t50sm11292924eeh.12.2011.01.25.09.59.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 09:59:39 -0800 (PST)
Message-ID: <4D3F0F38.6080904@mvista.com>
Date:   Tue, 25 Jan 2011 20:58:16 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/6] set up MSP VPE1 timer.
References: <1295943561-20000-1-git-send-email-anoop.pa@gmail.com> <1295978896.27661.567.camel@paanoop1-desktop>
In-Reply-To: <1295978896.27661.567.camel@paanoop1-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Anoop P A wrote:

> Changes since original:
> Corrected repeated word in comment

    These comments should *follow* the --- tear line, or Ralf will have to 
hand-edit them out of your patch. I think I've already written to you about this...

> ---
> VPE1 timer will be required for MIPS_MT modes ( VSMP / SMTC ).
> This patch will setup VPE1 timer irq.This has been tested with
> both SMTC and VSMP

> Signed-off-by: Anoop P A <anoop.pa@gmail.com>

WBR, Sergei
