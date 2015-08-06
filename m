Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 18:31:12 +0200 (CEST)
Received: from mail-io0-f172.google.com ([209.85.223.172]:34887 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012684AbbHFQbKEhTZY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 18:31:10 +0200
Received: by iodd187 with SMTP id d187so86548706iod.2
        for <linux-mips@linux-mips.org>; Thu, 06 Aug 2015 09:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+NqvHG8dRPfWzEIYuIK5+8vzrDeNUkeN3KlfPKioVEg=;
        b=On3rkbdQCga5NEPMc5lxPT4c5F9ZXDNrhl4O9V7hicpl+3rrDgwlj3evqbwA75e15y
         pa8xh1/Ba6LRynaMuZV9OXbQrt79sSXIdYSfiE2zJvN6y/pLc5I3qXFwmx659BK3CAXB
         cYM4CARLMwYDakhQiJmhHzt7TbVvKhAqrmH5HKd06BebybjFQvAKBgbROU4R/qFudUCl
         +asm+zqo6/xvbBPc9z2hT+uyk+A3HbxDouFntKzCW0UaXsS96xvLh7GIcm+NsK5ejWAU
         hUcK4+x9eFcoOXrMF4usn/3WWE+VRwJ/nkcDn9427VJXZdLG3qDz3yRIYLCW1WVn0Qk2
         l2Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+NqvHG8dRPfWzEIYuIK5+8vzrDeNUkeN3KlfPKioVEg=;
        b=WhtO5ooaOLxHbqDiWDuoNxQFBQlGgCgH9C1/JpW6Ge04qqxzdTG8cAFZ1SjcDSpGgf
         GniENx8O/03HxXrUQKa+YhOPpTc8Tky9EcHaT3GrZewiAH99Y6tepgrY1qtuiFnw4IvL
         XE9jN708/2iPRyBcMR8YgWA2PJKwwZKQdoSqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+NqvHG8dRPfWzEIYuIK5+8vzrDeNUkeN3KlfPKioVEg=;
        b=ka5osxHcZlcsD+7RNg2NmQfBKW3h/9VlHXb+gocb4ry72n0/GTefzUd7lI/HEX7CL/
         ku+McMBcpxNZ0z9k9oYwfjAIvFzJ1W+Vdh1o9XjkS8XolCxkPjt2UqX7WihadO/iIAmo
         w7pAOlTP70MYGH3c+hNQEQ3APPEZ3P0KhQaG1ZmyPT7b11Z7DlOlaJWqTQFubxmWiRVS
         OMIVHIRuFfWGsLI6vMouFKA7wWwipV6DTXpWPpHC66nGi9WDMX8DmQ8sU4qkk3TJjUHV
         bvU/ZNq8iHlE9PWVDkhqBzZrStAMVQUp22icyV+78Xx/CRi6LkfP6jttBgVbdt654TFq
         NXmQ==
X-Gm-Message-State: ALoCoQn//WSLRILddhfasWHmdctlzvMlq4uliseyuIwjTuHur6sXOZF0PKlbZm8GU1DWPeHzRl4x
MIME-Version: 1.0
X-Received: by 10.107.137.195 with SMTP id t64mr1319619ioi.150.1438878664378;
 Thu, 06 Aug 2015 09:31:04 -0700 (PDT)
Received: by 10.64.236.98 with HTTP; Thu, 6 Aug 2015 09:31:04 -0700 (PDT)
In-Reply-To: <1438868811-7769-1-git-send-email-govindraj.raja@imgtec.com>
References: <1438868811-7769-1-git-send-email-govindraj.raja@imgtec.com>
Date:   Thu, 6 Aug 2015 09:31:04 -0700
X-Google-Sender-Auth: MBApity2Z7a0J5HDpy3OiB4jqKs
Message-ID: <CAL1qeaG5+cB1Hw-s-p_9_zM5TK6ZOeNrMP5oAspbrgsY=_V89g@mail.gmail.com>
Subject: Re: [PATCH 5/6] pistachio: pll: Fix vco calculation in .set_rate (fractional)
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
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48691
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

On Thu, Aug 6, 2015 at 6:46 AM, Govindraj Raja
<govindraj.raja@imgtec.com> wrote:
> From: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
>
> Vco was calculated based on the current operating mode which
> makes no sense because .set_rate is setting operating mode. Instead,
> vco should be calculated using pll settings that are about to be set.
>
> Signed-off-by: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
> Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>

Shouldn't this be squashed with patch 3/6?
