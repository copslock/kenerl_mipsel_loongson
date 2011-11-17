Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 00:22:17 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:48133 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904087Ab1KQXWL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 00:22:11 +0100
Received: by yenr8 with SMTP id r8so1583747yen.36
        for <linux-mips@linux-mips.org>; Thu, 17 Nov 2011 15:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=5Fg27qAvsDWmP+SgQ0tvlzK0U2yjR1z8WHS8s5WvBvI=;
        b=B7jBTLmBRLw0qKMTsaibN8cGE9f3MGrZOg/oNZcqAL3N1s5P3J5bfMetDIIfbh6cur
         dFqro7aYFEGtyjA69Oeg==
Received: by 10.101.179.35 with SMTP id g35mr160399anp.82.1321572125320;
        Thu, 17 Nov 2011 15:22:05 -0800 (PST)
Received: by 10.101.179.35 with SMTP id g35mr160372anp.82.1321572125041;
        Thu, 17 Nov 2011 15:22:05 -0800 (PST)
Received: from [2620:0:1008:1201:be30:5bff:fed8:5e64] ([2620:0:1008:1201:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPS id 33sm84679114ano.1.2011.11.17.15.22.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 15:22:04 -0800 (PST)
Date:   Thu, 17 Nov 2011 15:22:02 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     David Daney <ddaney.cavm@gmail.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 0/2] Dummy HPAGE_* constants for
 !CONFIG_HUGETLB_PAGE
In-Reply-To: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 31769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14948

On Thu, 17 Nov 2011, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> After a, somewhat heated, discussion with David Rientjes, I think the
> following approach will work.
> 
> The first patch adds HPAGE_SHIFT, needed by MIPS.
> 
> The second cleans up the exiting HPAGE_MASK and HPAGE_SIZE
> 
> David Daney (2):
>   hugetlb: Provide a default HPAGE_SHIFT if !CONFIG_HUGETLB_PAGE
>   hugetlb: Provide safer dummy values for HPAGE_MASK and HPAGE_SIZE
> 
>  include/linux/hugetlb.h |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> Cc: David Rientjes <rientjes@google.com>

Nack on both, we already discussed this in the other thread (and I 
wouldn't call it "somewhat heated").

We don't need these dummy definitions at all for any current architectures 
that use them and they should be removed so that any future code using 
them will have the proper dependency on CONFIG_HUGETLB_PAGE.
