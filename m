Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2011 18:33:08 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:58770 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903621Ab1LNRdB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Dec 2011 18:33:01 +0100
Received: by fabs1 with SMTP id s1so1828873fab.36
        for <multiple recipients>; Wed, 14 Dec 2011 09:32:54 -0800 (PST)
Received: by 10.180.84.71 with SMTP id w7mr6750501wiy.37.1323883974690;
        Wed, 14 Dec 2011 09:32:54 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id hn15sm4474819wib.22.2011.12.14.09.32.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 09:32:53 -0800 (PST)
Message-ID: <4EE8EB95.7040901@mvista.com>
Date:   Wed, 14 Dec 2011 21:31:49 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0) Gecko/20110812 Thunderbird/6.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     ralf@linux-mips.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        linux-kernel@vger.kernel.org, Jason Baron <jbaron@redhat.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] jump-label: initialize jump-label subsystem somewhat
 later
References: <1323881315-23245-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1323881315-23245-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11535

Hello.

On 12/14/2011 07:48 PM, David Daney wrote:

> From: David Daney <david.daney@cavium.com>

> commit 97ce2c88f9ad42e3c60a9beb9fca87abf3639faa breaks MIPS.

    Please also specify that commit's summary (in parens).

> The jump-lable initialization does I-Cache flushing after modifying

    Label.

> code.  On MIPS this is done by calling through the function pointer
> flush_icache_range().  This function pointer is initialized mm_init().

    "By" missing?

> As things stand, we cannot be calling jump_label_init() until after
> mm_init() completes, so we move the call down to satisfy this
> constraint.

> Signed-off-by: David Daney<david.daney@cavium.com>

WBR, Sergei
