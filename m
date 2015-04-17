Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 18:49:33 +0200 (CEST)
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34431 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025644AbbDQQtcB5rOO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Apr 2015 18:49:32 +0200
Received: by qkgx75 with SMTP id x75so147362667qkg.1
        for <linux-mips@linux-mips.org>; Fri, 17 Apr 2015 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BeaWnLR0kmD1DBBhg+8XmNDnQeRZsl3wzunIpUb5LjI=;
        b=dGscmI73K/T3nwWYfd2/PpzosQh6Qypj8+sPfcgQ/siCo+YEBGacOVMwBXQjoJ1TUO
         cUDRFW1/CK9Rys38wJ4F+Gouujrzr2MkZ92+a2YmVFsqixDLZF5G4g+2lPuiBQUn5k1E
         5ZmhfH4pOjnTtk6kS7C6PQ8CxTCnPS9BBRxzmIHuDIMTamgDAtMn/UoljCtPFOu8plY3
         TDvmf2I341fV3GqqlcorPWJPjRWmFpz6rbQ9ppLf23riYlllKVjUOWpszFe8alsnN7WW
         qQQC9Wd3Fg+TcnjDKWxpGwl6KvODAmSKA547eFNl+TONN/van3GYOW6LyQBVq6cj9RN7
         BCjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BeaWnLR0kmD1DBBhg+8XmNDnQeRZsl3wzunIpUb5LjI=;
        b=Su3EhElTH0vRGxke6lFQM2G2xNY4BPo8K2cTocCuQ6qqiTmJLxPWdMOs5r9L6RRH7g
         RMFWHnzwxAMu0b8GAkRcv4a861ZUxKLlga3DxlKFi1A92hK+xOUg268T9mFOicy8owkn
         oqn0IheCL/5e2lbGtDZmAMj9QGhjN1G0/SSD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BeaWnLR0kmD1DBBhg+8XmNDnQeRZsl3wzunIpUb5LjI=;
        b=kBBuQ68N4j2hou7zzW2hq/Pr/NHtXUabEy1lH69nCAe4ah7FuyH+Jxz92mFYzsTBCn
         g51eaZoIpuqmnRMdk+MZJVQ3xJ5tg848LXlaEEe8mhBU1qB5mGHQx7ISu1eXZUOcylLo
         HwEBuY671UuiyXGRXxoQoOvaZJ7Z4gejP3je6stFgbNIzPP23dHy5OPsq1FBkbkoAxYZ
         7MzCgNfhQgjZJyhXmbRLwx4WqiyjvmLzJnD8b0x9D6QvWS40B1k2HRByNlfeXNrcVeoQ
         FlrELavy/E0gnV5v90UoYLwRGGQNjfPWjZNL26NLcEBdUDKiuodIoTP+nJIpSacVqkrf
         qKHg==
X-Gm-Message-State: ALoCoQmPQCkLQJN317c0PBg45wYELUbT/jUEYi9nBNRtMjP/h2Mn0gCVRMEDDvnJ3cfNLdX3dPbp
MIME-Version: 1.0
X-Received: by 10.140.237.67 with SMTP id i64mr4599962qhc.86.1429289367868;
 Fri, 17 Apr 2015 09:49:27 -0700 (PDT)
Received: by 10.140.19.104 with HTTP; Fri, 17 Apr 2015 09:49:27 -0700 (PDT)
In-Reply-To: <1429263856-30471-2-git-send-email-james.hogan@imgtec.com>
References: <1429263856-30471-1-git-send-email-james.hogan@imgtec.com>
        <1429263856-30471-2-git-send-email-james.hogan@imgtec.com>
Date:   Fri, 17 Apr 2015 09:49:27 -0700
X-Google-Sender-Auth: aCs0BczxoFdlF_s47zfXPWrd_Ls
Message-ID: <CAL1qeaEj+5Nb5S0N8XLe=+QNxnLXNCeUu4skxi=Gq5aysYwnnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Malta: Make GIC FDC IRQ workaround Malta specific
From:   Andrew Bresticker <abrestic@chromium.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hartley <james.hartley@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46901
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

Hi James.

On Fri, Apr 17, 2015 at 2:44 AM, James Hogan <james.hogan@imgtec.com> wrote:
> Wider testing reveals that the Fast Debug Channel (FDC) interrupt is
> routed through the GIC just fine on Pistachio SoC, even though it
> contains interAptiv cores. Clearly the FDC interrupt routing problems
> previously observed on interAptiv and proAptiv cores are specific to the
> Malta FPGA bitstreams.
>
> Move the workaround for interAptiv and proAptiv out of
> gic_get_c0_fdc_int() in the GIC irqchip driver into Malta's
> get_c0_fdc_int() platform callback, to allow the Pistachio SoC to use
> the FDC interrupt.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
