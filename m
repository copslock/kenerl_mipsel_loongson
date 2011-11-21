Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 23:48:25 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:58504 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903810Ab1KUWsQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 23:48:16 +0100
Received: by iapp10 with SMTP id p10so10035160iap.36
        for <linux-mips@linux-mips.org>; Mon, 21 Nov 2011 14:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=YVXXq6XarjJVf+hMQMdm7tyO2LnWrSd1zSsiEsfAHdM=;
        b=c0/Fxa8UBLI29uVgQC4z6hx8dtojAdDZty44jsGbXB5uWeG5Ie9jm37Tl5414UAg8M
         UYgYLAr/MOTqODpf3M7A==
Received: by 10.42.29.137 with SMTP id r9mr14086337icc.20.1321915690103;
        Mon, 21 Nov 2011 14:48:10 -0800 (PST)
Received: by 10.42.29.137 with SMTP id r9mr14086290icc.20.1321915689856;
        Mon, 21 Nov 2011 14:48:09 -0800 (PST)
Received: from [2620:0:1008:1201:be30:5bff:fed8:5e64] ([2620:0:1008:1201:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPS id ew6sm29263255igc.4.2011.11.21.14.48.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 14:48:09 -0800 (PST)
Date:   Mon, 21 Nov 2011 14:48:07 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     David Daney <ddaney.cavm@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        linux-arch@vger.kernel.org, Robin Holt <holt@sgi.com>
Subject: Re: [patch] hugetlb: remove dummy definitions of HPAGE_MASK and
 HPAGE_SIZE
In-Reply-To: <4ECACF68.3020701@gmail.com>
Message-ID: <alpine.DEB.2.00.1111211445470.5318@chino.kir.corp.google.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com> <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com> <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com> <4ECACF68.3020701@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 31903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17970

On Mon, 21 Nov 2011, David Daney wrote:

> > So, just remove the dummy and dangerous definitions since they are no
> > longer needed and reveals the correct dependencies.  Tested on
> > architectures using the definitions with allyesconfig: x86 (even with
> > thp), hppa, mips, powerpc, s390, sh3, sh4, sparc, and sparc64, and
> > with defconfig on ia64.
> > 
> 
> This whole comment strikes me as somewhat dishonest, as at the time David
> Rientjes wrote it, he knew that there were dependencies on these symbols in
> the linux-next tree.
> 

I was referring to Linus' tree at the time the patch was merged, not 
linux-next.  However, yes, I was aware of the build breakage it caused in 
Ralf's mips tree and I sent a patch to fix that breakage to the mips 
folks:

	http://marc.info/?l=linux-mips&m=132175788803677

Thanks.
