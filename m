Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2017 16:52:42 +0200 (CEST)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:34300
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993552AbdDXOwfvINnF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Apr 2017 16:52:35 +0200
Received: by mail-pf0-x244.google.com with SMTP id g23so4342544pfj.1;
        Mon, 24 Apr 2017 07:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mdJ5Jb8AdzH4yBGdxtREes12gLzrW9qPVdMMPyFeoP8=;
        b=sNGXVhPwFhxMaQJQCyjdc6/es3j1dOj+OACKbNUCxuOTCnnaoPyOvTM+DyMbWZm/IV
         tMqih4yn8Jk5F9toWQkk1xLX/vdZXxEWo/cMjhCU78PLGY0ieFRauUYV9dzM3UixgE0n
         m+NN+aaj2Wk/M/DoIoE9acuqJgjqi2iR5ZRLKuJDikiuPaXak15iBNDX4A9/k3KhUdtp
         cacW+BVp7DDrTt08Ue27sm09FGII9QLtCp7fXU7bgiDgcdvXEB5u/R7f5XZe2+nr1eCG
         oHhz3fRisrFNtCrCCcx/yR5ErmNxiIbFJTzCRigJVPhIeUROrMro3WCc7K6FEuUvwQJr
         G+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mdJ5Jb8AdzH4yBGdxtREes12gLzrW9qPVdMMPyFeoP8=;
        b=jPpK/8eXDtYpVe7NZV2RqhVMXk2dMtHfm0mVFYCrKdWUuCjMBaPjVTczy4dFA0z8V7
         KdYWw46cMMbJuUt/ydXqxzr77qXAr6aRKXjeSPZ/Tw+/JuctKbqjvWTvdYmsNX2x/7qw
         ON0OPg4epbcUd/0Svzg3gNjsK3OtyN5B4r1vh7mRi32a4BPMkUIp5c0XXWgJaeS03nZa
         2w15LaC4vaEzFXNK9GRaackUL4zp2CfSReCS+PEemV4ujs8UEe/HDrIxZBl1ap7j0gUs
         MbyrK2kp/ibCd1GrHo5DA1YxyBxVAQYrvjMEAGr9AOAIqyTzYNBpTBN21EkZQBmkp0XF
         UDow==
X-Gm-Message-State: AN3rC/5NonEtv4nIEyfcPG2PdNAOUKYb7CYTLl8l1nZ8XDHDsx/pUQ/n
        A/yPgkvvy/cX4CSe
X-Received: by 10.98.66.212 with SMTP id h81mr25190605pfd.182.1493045548991;
        Mon, 24 Apr 2017 07:52:28 -0700 (PDT)
Received: from mint-host ([180.102.125.8])
        by smtp.gmail.com with ESMTPSA id f131sm31492626pfc.54.2017.04.24.07.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 07:52:27 -0700 (PDT)
From:   Yang Ling <gnaygnil@gmail.com>
X-Google-Original-From: Yang Ling <gnaygnail@gmail.com>
Date:   Mon, 24 Apr 2017 22:52:17 +0800
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Binbin Zhou <zhoubb@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>, ????????? <Yeking@Red54.com>,
        linux-mips@linux-mips.org, HuaCai Chen <chenhc@lemote.com>
Subject: Re: [PATCH v6 1/8] MIPS: Loongson: Merge PRID macro for
 Loongson-1A/1B/1C
Message-ID: <20170424145217.GA4729@mint-host>
References: <1490841889-13450-1-git-send-email-zhoubb@lemote.com>
 <1490841889-13450-2-git-send-email-zhoubb@lemote.com>
 <273c2b54-05df-687b-1633-36ee40a83a5d@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <273c2b54-05df-687b-1633-36ee40a83a5d@cogentembedded.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

Hi, Sergei,

I think this modification is appropriate, otherwise if the future 
support 1D, 1E and so on, the same PRID here will appear strange.

Yang

On Thu, Mar 30, 2017 at 12:50:55PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 3/30/2017 5:44 AM, Binbin Zhou wrote:
> 
> >As we all know, the Loongson-1 series CPUs(1A/1B/1C) share the same PRID macro.
> >so I rename them for more readable.
> 
>    "Better readability", perhaps?
> 
> >Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
> >Signed-off-by: HuaCai Chen <chenhc@lemote.com>
> [...]
> 
> MBR, Sergei
> 
