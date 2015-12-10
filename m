Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Dec 2015 17:25:08 +0100 (CET)
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33826 "EHLO
        mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013632AbbLJQZG39iw0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Dec 2015 17:25:06 +0100
Received: by obciw8 with SMTP id iw8so62700084obc.1
        for <linux-mips@linux-mips.org>; Thu, 10 Dec 2015 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LZaJVDDXwxshGEsiBRUeul7NkYsmbEEQHQXSF+ytNCo=;
        b=a1e+yc054FFPzQb47atDdF7Acp80zeVCdathpkBZvo7ydnqjZCQl1sIrYN4nfVtmJ4
         Jk6JygmKsv204V8fwzC5HdOfOG3/yWdI3psk7J9tmTObHx3eB9qpjfa6A58wAeQB69UG
         D9W/zGdf6lYz6Ky8mLxsl2gjkkagEbOCM7rmTGKG/SO1WeDJwA/Jfu8jUOIIcGtyH9bI
         udrjDMGLTn2IiuqxsuOQ1IqZFVWqCNN/AA5XkCPXEUa/zBZYxf6P5D0ogn4HD8nYtVZf
         1HaZKQIaL8xZhcVfV8k5fzQjpqNDB3+3KSq7GptBIuoLJLDz2IU4qgGWYNyUCkFpqXjQ
         3C4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LZaJVDDXwxshGEsiBRUeul7NkYsmbEEQHQXSF+ytNCo=;
        b=CVJMvc55QlEgmJjZTcQRq3vADG67AqzNdYo4KsSYhRhm+uJRi0yC5b+vWmmGN/m2DJ
         KkHbfNZ9LNiMEyGmEzivdfck5/KJxru8xpcmPNr7EdGcsAGYsusqjdueJP4dKaUh7htW
         GnNhKRPwAM7YgCVqNwSfMs4qfdEngDPc34mEg1CPc7tJoD/+sltmFbij7B7n02FQ+sNE
         ejEhkFe/v4khG+gGjsLoqyg5EuRDSFPRJumztzmlsMkl9AgcYJ+PeVvBm+1P9F7/OutR
         VaemUxBhpBYhCYjJg5UsT544+T6BRYxfl0nuWdhqYOO6+v6/P2rwV5hKWwR0aq4mH7se
         D3YQ==
X-Gm-Message-State: ALoCoQmY0pkW/chzRRnMNsIwsEQcM/VJlCg8IkOfu7fq6VX8Mx3sbhug1s/vp6CRxEzcyNXQmUi3Gtq9cDAbTbBSkCrY+P4ono7qOEEURd80zB12nHCj2is=
MIME-Version: 1.0
X-Received: by 10.182.200.201 with SMTP id ju9mr10120197obc.30.1449764700510;
 Thu, 10 Dec 2015 08:25:00 -0800 (PST)
Received: by 10.182.32.70 with HTTP; Thu, 10 Dec 2015 08:25:00 -0800 (PST)
In-Reply-To: <1448900513-20856-14-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
        <1448900513-20856-14-git-send-email-paul.burton@imgtec.com>
Date:   Thu, 10 Dec 2015 17:25:00 +0100
Message-ID: <CACRpkdboe5BPSNbDOHEzVtQ_kdeWMAR9x2QkDAE-8YO-2E2HHg@mail.gmail.com>
Subject: Re: [PATCH 13/28] gpio: pch: allow use from device tree
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Mon, Nov 30, 2015 at 5:21 PM, Paul Burton <paul.burton@imgtec.com> wrote:

> Allow GPIOs from the gpio-pch driver to be referenced from device tree
> by simply setting the struct gpio_chip of_node pointer to that of the
> struct pci_dev.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Patch applied.

Yours,
Linus Walleij
