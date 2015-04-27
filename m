Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2015 09:11:35 +0200 (CEST)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:34593 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010080AbbD0HLeC8pLn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2015 09:11:34 +0200
Received: by wgso17 with SMTP id o17so105817284wgs.1;
        Mon, 27 Apr 2015 00:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KapFyQAxgUkTW1Q698itxuDrc4utOg1NGdO4QzMb88g=;
        b=eMUHzYvr8Wpbjv5Cg+2EdWrSujgxX227SulovvZcbZnN8ePMwXwzvWluLlohOuRNTE
         UrRQSmC7chc37eSf0suPvS24dd0Atmz4aKYz2BwMYWyWNE7KvIBFRBGNpe8h8Vl8QVm1
         5yCnECLKN9dQj6AHI3ycDk+dC32Yt7oEEsdWydVinoon6QKI38rjDgObSe2QEtWF4W6j
         bMJxaVVNx0lTsl7j9fro85sOk9Zk6/3cmots1vznZME21enBXsM0acooMv06LEa6xy/a
         jr7MvxzAapzfFylaJKRREpLVYY7bE3IB6K/6u36zSW6B+qPTc5BvuINJ/mZpQuSF8t0r
         FJaQ==
X-Received: by 10.180.87.199 with SMTP id ba7mr18361497wib.81.1430118690576;
 Mon, 27 Apr 2015 00:11:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.170.7 with HTTP; Mon, 27 Apr 2015 00:11:00 -0700 (PDT)
In-Reply-To: <CAD3Xx4LMq1F8cDSR=17c3ViOML2ZYaL4d1ApkEog6bftSwKAPQ@mail.gmail.com>
References: <CAD3Xx4LMq1F8cDSR=17c3ViOML2ZYaL4d1ApkEog6bftSwKAPQ@mail.gmail.com>
From:   Valentin Rothberg <valentinrothberg@gmail.com>
Date:   Mon, 27 Apr 2015 09:11:00 +0200
Message-ID: <CAD3Xx4L2x4Ph6=E4Mp2rO7KAC2eUrMU3f8eFztGeqWru3g_WxQ@mail.gmail.com>
Subject: Re: MIPS: BMIPS: broken select on RAW_IRQ_ACCESSORS
To:     cernekee@gmail.com
Cc:     ralf@linux-mips.org, jaedon.shin@gmail.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Paul Bolle <pebolle@tiscali.nl>,
        Andreas Ruprecht <rupran@einserver.de>,
        hengelein Stefan <stefan.hengelein@fau.de>
Content-Type: text/plain; charset=UTF-8
Return-Path: <valentinrothberg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: valentinrothberg@gmail.com
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

Hi Kevin,

this is just a kind reminder that the issue below is still present and
made its way to v4.1-rc1.

Kind regards,
 Valentin

On Thu, Mar 26, 2015 at 11:47 AM, Valentin Rothberg
<valentinrothberg@gmail.com> wrote:
> Hi Kevin,
>
> your commit dd6d84812b1a ("MIPS: BMIPS: Enable additional peripheral
> and CPU support in defconfig") adds a select on the Kconfig symbol
> RAW_IRQ_ACCESORS.   However, this symbol is not defined in Kconfig so
> that the select turns out to be a NOOP.
>
> Is there a patch scheduled somewhere to add this symbol to Kconfig?
>
> I detected this issue with ./scripts/checkkconfigsymbols.py.  Since
> commit b1a3f243485f ("checkkconfigsymbols.py: make it Git aware") the
> script can check and diff specified Git commits.  I found
> RAW_IRQ_ACCESORS by diffing yesterday's and today's next trees (--diff
> commit..commit2).
>
> Kind regards,
>  Valentin
