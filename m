Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2012 14:20:02 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:54724 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903696Ab2C3MT6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Mar 2012 14:19:58 +0200
Received: by bkcjk13 with SMTP id jk13so573860bkc.36
        for <linux-mips@linux-mips.org>; Fri, 30 Mar 2012 05:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-gm-message-state:content-type
         :content-transfer-encoding;
        bh=/mtXg0RFQbxbH1FF5p7Ydyc6CcCXbu2SzUznrzCudQ8=;
        b=bZ5X5ELBCVqxrkxIpZyx/a/2fYDF3sVnMfPFzhYHSEM6V4LdsHM++1OqMyrl+NPCru
         +DBWWcR1B/g60T3rKv+SMUZe/UyRfyo3tYaaXvaBmVbzfdA7i4K91c400M9+CSjFqW5r
         nbWpDNAz31ExZOH7Om4XqvaXLbjXfJA7R4FKSQEIvCxD/rIg0E2fq4Y/Zn/F/hxQfOMG
         fM+5xAWKyGfMWFdicDNC18dsm9Y5zKrLEoGtoLm3RgxRFYPCbNdR/Cl7s7urtjFVXMfU
         vHW+z1BLZvTycGxNnD8xqFFstj3jii2XPaU7kAMr10pkOyfgHYjm5WMdOf+qCemsTD6G
         XjSA==
Received: by 10.204.136.198 with SMTP id s6mr837520bkt.129.1333109991860;
        Fri, 30 Mar 2012 05:19:51 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-89-254.pppoe.mtu-net.ru. [91.79.89.254])
        by mx.google.com with ESMTPS id r14sm20351565bkv.11.2012.03.30.05.19.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 05:19:49 -0700 (PDT)
Message-ID: <4F75A48F.8010307@mvista.com>
Date:   Fri, 30 Mar 2012 16:18:23 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To:     Maarten ter Huurne <maarten@treewalker.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?ISO-8859-1?Q?Llu=EDs_Batlle_i_Rossell?= <viric@viric.name>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] MIPS: Enable vmlinuz for JZ4740
References: <1333037360-18382-1-git-send-email-maarten@treewalker.org> <4F74E210.70707@mvista.com> <3042754.g6sLXu44Oc@hyperion>
In-Reply-To: <3042754.g6sLXu44Oc@hyperion>
X-Gm-Message-State: ALoCoQn7cLpCWBd5URcpc9dy1/RFFBwrtqCPyFqQUZS59+M4bN6FklvDrUZpToxXhr9Eg8bHgtGj
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 30-03-2012 13:53, Maarten ter Huurne wrote:

> [...]

>>> +ifeq ($(CONFIG_MACH_JZ4740),y)
>>> +VMLINUZ_LOAD_ADDRESS:=0x80600000

>>      Spaces around :=, please. And why this should be out of order case?

> I can add spaces, no problem.

> I don't understand your question though. Do you mean why there is a
> different address for the JZ4740 platform? Or why the variable name is in
> upper case? Or something else?

    I should have said: why the variable is handled as a special case for JZ4740?

> Bye,
> 		Maarten

WBR, Sergei
