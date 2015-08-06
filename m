Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 18:37:14 +0200 (CEST)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35648 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012684AbbHFQhLnvX7Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 18:37:11 +0200
Received: by igr7 with SMTP id 7so14795282igr.0
        for <linux-mips@linux-mips.org>; Thu, 06 Aug 2015 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7AcY7eb67Klxmu3g83eJ127OWhNiRlw7LBmKfwsMlto=;
        b=Ep/+YtkA+KUijSYheeKLTBFljEzQKJWQBsykyxKkeef3Nc5mDGPyvjBBzprvpEpOIk
         O09cDjGtG3R3a3k32EO7KEkBIroJ1mDbaWThGbDu0q1E/1FvNETwQnu8aXFXPD2OuRDf
         za+k+TrvgsOkann6Uo7XNJniyQiZGUaDIa2L5c40MzeKFYVTrLq2Pdm4hxflua2ndDaH
         4qQdvZi/4rimUPED+oqpnUF4JySqKxJ1ywbtOGE0pNO091/zpAgYLei5ftcrgXNmatsU
         deXeFEJjQ54rBavaUY7sgw/osaBy7aTmdEvrWOPeKpUl0AY5UImDysiXlkrp4nlUhFfV
         AXyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7AcY7eb67Klxmu3g83eJ127OWhNiRlw7LBmKfwsMlto=;
        b=Awo6z/UW25Q7j7Wv60vanGm2iMj4iVEhLuDvx00/pSwsbh6H/VLtd4VUjTBqV8Pi3z
         Vi+fErQmfl/ud5AGgQgFUFN3DKPXSeRB/qY4cAfjSYbdWOsIAxnLcJ2z2MCtFHmqN2Vc
         QhipDh7B4fvUCsMTkfYgCRGzJSOuBIofPP9FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7AcY7eb67Klxmu3g83eJ127OWhNiRlw7LBmKfwsMlto=;
        b=SOdFY+5idpgtDoTWrObkuTWRB4RyDOmqg5kfhH/ECDJ0Ziprh8YEGojzz0cWCQ7fPJ
         7kSi8AMOirQ2vDasclrmG/uw4Q2nDrcwU3udS8zxuTF8kcXy93Ct2+2L0ZoFL0nniigH
         2Amu+kJf7dKKF/Ef0+avGsnC+6WPkA6BdTk4Jo8LgPldKeWsb67sxtOPZnrYH4UraYK9
         wb0b4mV34eIqrKsLSXAZULFzkuMQu0DHuskJAdQKhaZxvpqNrqGq3oCgMQgueOnlPavh
         luzF36bN4MoyYVP2HBWt8+n3gLOp1h2csn3CRiiHMNNdPg5rk4I+fIkPagG4JLtGSnyp
         agQg==
X-Gm-Message-State: ALoCoQkcJKhsHUc/bGH60+E6KqnFH5D4r0Cpzd2Mcc/BD8H5tgI9+QJHjCXOCB4QEG8RZznKK0An
MIME-Version: 1.0
X-Received: by 10.50.138.73 with SMTP id qo9mr4979553igb.64.1438879025967;
 Thu, 06 Aug 2015 09:37:05 -0700 (PDT)
Received: by 10.64.236.98 with HTTP; Thu, 6 Aug 2015 09:37:05 -0700 (PDT)
In-Reply-To: <1438868890-7810-1-git-send-email-govindraj.raja@imgtec.com>
References: <1438868890-7810-1-git-send-email-govindraj.raja@imgtec.com>
Date:   Thu, 6 Aug 2015 09:37:05 -0700
X-Google-Sender-Auth: Lxmp2cd49QSW4RQk259JFTJxECI
Message-ID: <CAL1qeaHLqj+vicU8FbxSnJW81STP4uPbOMnM5m42ecBJu1Vokg@mail.gmail.com>
Subject: Re: [PATCH 6/6] clk: pistachio: correct critical clock list
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Govindraj Raja <govindraj.raja@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>, linux-clk@vger.kernel.org,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Zdenko Pulitika <zdenko.pulitika@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48693
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

Govindraj,

On Thu, Aug 6, 2015 at 6:48 AM, Govindraj Raja
<govindraj.raja@imgtec.com> wrote:
> From: "Damien.Horsley" <Damien.Horsley@imgtec.com>
>
> Current critical clock list for pistachio enables
> only mips and sys clocks by default but there also
> other clocks that are not claimed by anyone and
> needs to be enabled by default.
>
> This patch updates the critical clocks that needs
> to enabled by default.
>
> Add a separate struct to distinguish the critical clocks
> one is core clock(mips) and others are from periph_clk_*
>
> Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>

Since you're the one sending the patch, you should include your Signed-off-by.
