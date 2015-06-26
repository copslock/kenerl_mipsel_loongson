Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jun 2015 01:16:24 +0200 (CEST)
Received: from mail-la0-f45.google.com ([209.85.215.45]:35857 "EHLO
        mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009529AbbFZXQVYZtpL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jun 2015 01:16:21 +0200
Received: by lacny3 with SMTP id ny3so71608381lac.3;
        Fri, 26 Jun 2015 16:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:message-id:to:cc:subject:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ptZV3GiumCI1taFo59N69Y2JNvw66h06rPBMmXEq/H8=;
        b=P2ORo2FB4DrjlAIT2Bnycv09C9Bay3dN6DHZP9ZEUH+6byGIY5bzBYc6mpJO+qD0Nc
         5Nf70d/bL3JefO85+4EDiooxD0WwOvMFGyQkL5nWftlvM20vwsTCTTclI9gjxSYX5Bth
         LEL9jVChEWj+P2n/yebFEVAybfp/J43nqqe1hbysWpevSkte35nUm3DwHZTUzFBwDarS
         HW/H1122pWopqGxdjt4RQuuaCdXRQ8LjSvjBRFGRAoPadORUyNRCPiuj4yrUueumTbbI
         DYdymeZXfqyphFbyTHePFVEWRvj+Z3qFqNovumfm3P19dlRHMUT1LdxQPsfBZaX1e5/9
         giZA==
X-Received: by 10.112.137.99 with SMTP id qh3mr3753639lbb.108.1435360576132;
        Fri, 26 Jun 2015 16:16:16 -0700 (PDT)
Received: from rsa.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id cq1sm6314003lad.18.2015.06.26.16.16.14
        (version=TLSv1.1 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 16:16:15 -0700 (PDT)
Date:   Sat, 27 Jun 2015 02:16:30 +0300
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <441261391.20150627021630@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     rmk+kernel@arm.linux.org.uk, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        Julia.Lawall@lip6.fr, hpa@zytor.com, tglx@linutronix.de,
        linux-tip-commits@vger.kernel.org,
        Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: [tip:irq/urgent] MIPS/ath25: Fix race in installing chained IRQ handler
In-Reply-To: <tip-08ece35e7dcc24591e27089029f1fea14e76d1fa@git.kernel.org>
References: <tip-08ece35e7dcc24591e27089029f1fea14e76d1fa@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Hello Thomas,

Friday, June 26, 2015, 10:48:13 PM, you wrote:
> MIPS/ath25: Fix race in installing chained IRQ handler

> Fix a race where a pending interrupt could be received and the handler
> called before the handler's data has been setup, by converting to
> irq_set_chained_handler_and_data().

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

-- 
Sergey
