Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 09:57:21 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:51077 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903549Ab1KRI5R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 09:57:17 +0100
Received: by faar25 with SMTP id r25so5031941faa.36
        for <multiple recipients>; Fri, 18 Nov 2011 00:57:12 -0800 (PST)
Received: by 10.204.145.89 with SMTP id c25mr2367491bkv.35.1321606632023;
        Fri, 18 Nov 2011 00:57:12 -0800 (PST)
Received: from [192.168.2.2] (ppp85-141-239-170.pppoe.mtu-net.ru. [85.141.239.170])
        by mx.google.com with ESMTPS id hy13sm121989bkc.0.2011.11.18.00.57.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 00:57:11 -0800 (PST)
Message-ID: <4EC61DB1.3090608@mvista.com>
Date:   Fri, 18 Nov 2011 12:56:17 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2 2/2] hugetlb: Provide safer dummy values for HPAGE_MASK
 and HPAGE_SIZE
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com> <1321567050-13197-3-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1321567050-13197-3-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15193

Hello.

On 18-11-2011 1:57, David Daney wrote:

> From: David Daney<david.daney@cavium.com>

> It was pointed out by David Rientjes that the dummy values for
> HPAGE_MASK and HPAGE_SIZE are quite unsafe.  It they are inadvertently
> used with !CONFIG_HUGETLB_PAGE, compilation would succeed, but the
> resulting code would surly not do anything sensible.
>
> Place BUG() in the these dummy definitions, as we do in similar
> circumstances in other places, so any abuse can be easily detected.
>
> Since the only sane place to use these symbols when
> !CONFIG_HUGETLB_PAGE is on dead code paths, the BUG() cause any actual
> code to be emitted by the compiler.

    You mean "doesn't cause"?

> Cc: David Rientjes<rientjes@google.com>
> Signed-off-by: David Daney<david.daney@cavium.com>

WBR, Sergei
