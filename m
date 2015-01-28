Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2015 11:49:51 +0100 (CET)
Received: from mail-qa0-f52.google.com ([209.85.216.52]:32866 "EHLO
        mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012055AbbA1KtuAgh76 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Jan 2015 11:49:50 +0100
Received: by mail-qa0-f52.google.com with SMTP id x12so15573680qac.11
        for <linux-mips@linux-mips.org>; Wed, 28 Jan 2015 02:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8jhGV8P2sd8sQEeQwPxvgDDrCZ7PEuQRMaPz0OAmBWQ=;
        b=k5/KjaRECNR4BV0ZTkNPBeuI9Tr6FuBScvgUhLcWn6l36uHN/e0Jgu0xhhs+a2Uf1b
         /F9nsCaYGDLHEI66YtXggEbkxwWyV97pQrKYaJ7DIo/j2QN7aDlRrleI1664d73UFLdW
         X5bAqbgne788PJHx522F1PiEA/WpV8ZJwmWYecmSvpy052/yzS5OmTHTbc1AraxNgpT/
         FyRk9JLOOqvN5uJvqJvh00QmFaFO7KGbKHEJa1i+4whXBG/yJpRMqzHYtpWEpqch49yV
         ezPo/Ybsi54bBUjA9ileyESsBmgDgZsxGdh695IltFnX3Xz8icwPMVFj8+HPM5sL61xO
         Wa3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8jhGV8P2sd8sQEeQwPxvgDDrCZ7PEuQRMaPz0OAmBWQ=;
        b=OsPk1WptaVGZbPvN9BbzRG7mVZSqm/YesuU1lwFLumZLO4YeZyD+NOM0MhydVFQLcY
         TjgbMk2o/hODqb6tydQifrHDiU5R9z8baV479R9V+4nUv7RAUn1+dZboiQwBLjAOUfP3
         uzgfSSz+hPblo6jQCCzX3b89BR33bpx6Xh9Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8jhGV8P2sd8sQEeQwPxvgDDrCZ7PEuQRMaPz0OAmBWQ=;
        b=RQRC8X8eBVoTGNnzxNZ17mBA164QmKsfvosh2mtfQ1saGOZ/1cu2oUjXPQ8mr17tBH
         DDgR5jz8RimskGVmBOl8W3kA5SnbGdvWyeak6iHP29ZpRvLXUbj+mQd4CB7l6WBDqPTg
         R213WulGjYmF4Yu/DVQz5Qv4TIV4ydYuwiKofht5boha17VRhS+UQgwOkYPVSMWuJJqf
         K4xRC9v6zu43RQKMSZsCwH/Ohhjq9mvO3FJCwJdDRT70Z+rNQm4OL18DRt+KuY+oY+ZH
         Ud4k6LKcYtDJ6qM4Ryw7L8XBU1LiJAChsHQPsHdSwQ2LsiVQJoJm18lQoiPZ0vhuy/Bl
         9xMQ==
X-Gm-Message-State: ALoCoQn8On9ptF8Gmdpjce9FYw+2UpM2oOQFJo3yYpX1qXZXT2DgQS/YAdxTgR6mnySlFv2S9h3X
MIME-Version: 1.0
X-Received: by 10.224.114.209 with SMTP id f17mr11966639qaq.68.1422442184589;
 Wed, 28 Jan 2015 02:49:44 -0800 (PST)
Received: by 10.140.19.72 with HTTP; Wed, 28 Jan 2015 02:49:44 -0800 (PST)
In-Reply-To: <1422395155-16511-6-git-send-email-james.hogan@imgtec.com>
References: <1422395155-16511-1-git-send-email-james.hogan@imgtec.com>
        <1422395155-16511-6-git-send-email-james.hogan@imgtec.com>
Date:   Wed, 28 Jan 2015 10:49:44 +0000
X-Google-Sender-Auth: fEY3NbjH2oZfAks9fQXIMkwrrIE
Message-ID: <CAL1qeaH60ERCFBNEch2htj37opy9P6V0Pzyn87tTT-YtUOis1g@mail.gmail.com>
Subject: Re: [PATCH 5/9] irqchip: mips-gic: Add missing definitions for FDC IRQ
From:   Andrew Bresticker <abrestic@chromium.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Tue, Jan 27, 2015 at 9:45 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Add missing VPE_PEND, VPE_RMASK and VPE_SMASK definitions for the local
> FDC interrupt.
>
> These local interrupt definitions aren't directly used, but if they
> exist they should be complete.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: linux-mips@linux-mips.org

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
