Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2015 11:48:57 +0100 (CET)
Received: from mail-qc0-f180.google.com ([209.85.216.180]:51893 "EHLO
        mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012059AbbA1Kszz0Ryq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Jan 2015 11:48:55 +0100
Received: by mail-qc0-f180.google.com with SMTP id r5so15723078qcx.11
        for <linux-mips@linux-mips.org>; Wed, 28 Jan 2015 02:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/c09z+cXQyphXX7+S5f1jpdOqVHmbjjhKNy5nlZ+bsY=;
        b=g7S8oc+ZIhmzWZ54KtCELGaPv4Z1LN9Puike7ak3aOhxWd0mC62SVDpGsdTBe0L3yj
         DjsIwEcCtEESXlWUNjWNz7PP8M1pttvnMZavEU6CXHRVPR7OwSm2hwhuHLnJ6SQ2GjcN
         QjREN1HRPkXtIudQ5vqls0r7PyLh7cCdgrEiVxRV++zSx4YSRENjWPf8JMn+dY8K7EhM
         ODBTn9S21Xb2aV0ZxChQ48/K0SIjaN018iIK9ibtBCxAd8fCbLxtRxPX6SLB3tdFzF9X
         /lCH4FyoP+gCTrI+t2YfL+B6RLLp5PKnUxsER6zN/0JkwCekPm+B21amgMJtWm/jI4NI
         9TCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/c09z+cXQyphXX7+S5f1jpdOqVHmbjjhKNy5nlZ+bsY=;
        b=lu2fF0wTTzCDryJAQtxuDwg2FT8h9qCQrcrSL+2TkSsS+Qgzuo5ZQTZCApB4dXJ4Sn
         Zoxbb7E6DzN4GQIK8x7GbnJuxaC64E/J6mCJe7vhVF0zGrlqO4mP+EjEpr5b1CpB2e7f
         hz5BZ15WRLZ306TOnrjBKV2SqpG7UtfmVIK04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/c09z+cXQyphXX7+S5f1jpdOqVHmbjjhKNy5nlZ+bsY=;
        b=VaYdUWLJIfUfCDXSefwLC20MzPMOHCMl5E2g5UaqRwtdm7nCA/i2w9MPJuRZ9qCj/W
         zuT3NgbOsOdMSiA9jTIifRhPCaswaOopHfpNzzPohEgJ/Zf1orzxr5JDUIsOLETI4WxB
         11VRc0rVLuRbFg9NZ5Uk2Bt4fdAE6hr1+KT0SDTL/enI2AOnXnPZlIa3Wjt3vgi2pWbe
         dBv3QQkjRg+qATTlZSM+wq9YoJgth/F7rutZpx9P+xHpddpUFFCVpGRBHtIun77YIcbJ
         LMCtjSuEJyyXHn3hVbZ2JQgedED+yHS9RMgvnP2rWwI3PyekwTcK8vbOwzGQly6NwEWI
         IM8w==
X-Gm-Message-State: ALoCoQns9262raFBlJ0imn3muTFvlR5EApLWIsXeVLTfuB6L/F/MA3hKx6CdWEAeWBvy+b24MKA/
MIME-Version: 1.0
X-Received: by 10.224.111.194 with SMTP id t2mr11323101qap.86.1422442129445;
 Wed, 28 Jan 2015 02:48:49 -0800 (PST)
Received: by 10.140.19.72 with HTTP; Wed, 28 Jan 2015 02:48:49 -0800 (PST)
In-Reply-To: <1422395155-16511-5-git-send-email-james.hogan@imgtec.com>
References: <1422395155-16511-1-git-send-email-james.hogan@imgtec.com>
        <1422395155-16511-5-git-send-email-james.hogan@imgtec.com>
Date:   Wed, 28 Jan 2015 10:48:49 +0000
X-Google-Sender-Auth: M0-J0fZF5O5s8jBucwJxKJ_Z5bA
Message-ID: <CAL1qeaG542xhS9FdEgMPEezaQJpApNTaLE8p-nUbrj9XPVy=xw@mail.gmail.com>
Subject: Re: [PATCH 4/9] irqchip: mips-gic: Fix typo in comment
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
X-archive-position: 45512
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
> Fix typo in comment in gic_get_c0_perfcount_int:
> "erformance" -> "performance".
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: linux-mips@linux-mips.org

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
