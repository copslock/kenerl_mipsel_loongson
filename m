Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2015 14:30:58 +0200 (CEST)
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35871 "EHLO
        mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010629AbbDVMa5QZDA6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Apr 2015 14:30:57 +0200
Received: by wizk4 with SMTP id k4so175893865wiz.1
        for <linux-mips@linux-mips.org>; Wed, 22 Apr 2015 05:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ASEVyb5ouwoaRV+u4QS7CpBehQ74T+5s14Wqc4HXRL4=;
        b=V+umWCBHLbwWTkcRhHsQ3VvNZ+gaCjs/FfxEVU1haqllhPV4kttWNN9lZYHjVGSfOi
         LO2x99Dy7KoJjK6v2VhDsmacZiJ2NYjrfSNxytS0dhCtMWX4IqJ1EHvldhmd+CZ/j2Fu
         8va+0h0cKLsSz+omMB8m/egEJ2c+GGKKI/rIFIoWW96MCIqsNNKrCjN+7/kIINWxtfEn
         VjCLVZO3SJG2Zp0p6JL90gTAWBi5Oz4JbDk9m/GfUOr8bDMEEJqiSgSANbZLQU0puYpe
         apwvnSI0z1vmTEmD5R5MGQLy6EhfzeHuAQnUSpijuLMgEoNM254woxHwDA+evKBZeKY2
         tlNg==
X-Gm-Message-State: ALoCoQmEzfW2REXcAgvwovS4hA6VHODb61YdqiQhOltL0He1SoxNa5cOIRua26u00TmfkhA4cNFI
X-Received: by 10.194.79.199 with SMTP id l7mr50147069wjx.158.1429705853565;
        Wed, 22 Apr 2015 05:30:53 -0700 (PDT)
Received: from bordel.klfree.net (bordel.klfree.cz. [81.201.48.42])
        by mx.google.com with ESMTPSA id o5sm24405205wia.0.2015.04.22.05.30.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Apr 2015 05:30:52 -0700 (PDT)
Date:   Wed, 22 Apr 2015 14:30:45 +0200
From:   Petr Malat <oss@malat.biz>
To:     Mike Frysinger <vapier@gentoo.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH] Revert "MIPS: Provide correct siginfo_t.si_stime"
Message-ID: <20150422123045.GA5428@bordel.klfree.net>
References: <1429641183-15873-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1429641183-15873-1-git-send-email-vapier@gentoo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <oss@malat.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oss@malat.biz
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

Hi,
On Tue, Apr 21, 2015 at 02:33:03PM -0400, Mike Frysinger wrote:
> From: Mike Frysinger <vapier@chromium.org>
> 
> This reverts commit 8cb48fe169dd682b6c29a3b7ef18333e4f577890.
> 
> UAPI headers cannot use "uapi/" in their paths by design -- when they're
> installed, they do not have the uapi/ prefix.  Otherwise doing so breaks
> userland badly:
> $ printf '#include <stddef.h>\n#include <linux/signal.h>\n' > test.c
> $ mips64-unknown-linux-gnu-gcc -c test.c
> In file included from /usr/mips64-unknown-linux-gnu/usr/include/linux/signal.h:5:0,
>                  from test.c:2:
> /usr/mips64-unknown-linux-gnu/usr/include/asm/siginfo.h:31:38: fatal error: uapi/asm-generic/siginfo.h: No such file or directory
> compilation terminated.

I will look how to fix the include issue without delivering stack content
instead of stime. By the way hexagon arch does the same :-/
BR,
  Petr
