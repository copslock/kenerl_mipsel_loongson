Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Dec 2010 12:32:40 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:60106 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491066Ab0LXLch (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Dec 2010 12:32:37 +0100
Received: by eyd9 with SMTP id 9so4465204eyd.36
        for <multiple recipients>; Fri, 24 Dec 2010 03:32:37 -0800 (PST)
Received: by 10.213.4.11 with SMTP id 11mr8734297ebp.3.1293190356595;
        Fri, 24 Dec 2010 03:32:36 -0800 (PST)
Received: from [192.168.2.2] ([91.79.84.9])
        by mx.google.com with ESMTPS id x54sm6377083eeh.23.2010.12.24.03.32.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 03:32:35 -0800 (PST)
Message-ID: <4D148495.4030703@mvista.com>
Date:   Fri, 24 Dec 2010 14:31:33 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Select R4K timer lib for all MSP platforms
References: <1290067948.9091.14.camel@paanoop1-desktop>
In-Reply-To: <1290067948.9091.14.camel@paanoop1-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 18-11-2010 11:12, Anoop P A wrote:

>> From c872cbbe5f475d3bb3cb7f821270cb466eead1f7 Mon Sep 17 00:00:00 2001
> From: Anoop P A<anoop.pa@gmail.com>
> Signed-off-by: Anoop P A<anoop.pa@gmail.com>
> Date: Thu, 18 Nov 2010 01:33:36 +0530
> Subject: [PATCH] Select R4K timer lib for all MSP platforms

    Please don't include this header (except the signoff line) -- Ralf will 
have to manually edit it out.

WBR, Sergei
