Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 May 2013 13:21:42 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:43774 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835017Ab3EBLVU4a5nO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 May 2013 13:21:20 +0200
Received: from mail-vb0-f48.google.com (mail-vb0-f48.google.com [209.85.212.48])
        by mail.nanl.de (Postfix) with ESMTPSA id D6A0F45F55;
        Thu,  2 May 2013 11:21:06 +0000 (UTC)
Received: by mail-vb0-f48.google.com with SMTP id q16so339604vbe.21
        for <multiple recipients>; Thu, 02 May 2013 04:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=peoMNyi5RA6cZJBESOxEc7jUapm5q2VQPqzq4UZoGIA=;
        b=N7bCSU9KcYADOK2CoonKxXoYkuUezMoNLkzSpI0Rub9tJdr3aEe3HTzAkSZLW54neW
         cDk++25zMjcLMlXRIkxjsnPhez+nnUflC7Hr0or3/QeBQot9Zu6CULBYZ9VyhX7ad5v9
         HscBpEM3M99JtKx6Sj4lhX3YUfvFyHfA9H8nAk3os/wIaponi/00ExutP0hSBCW2E9SX
         6T6LWfjQA2yeVqBCJLkmEeL4j1yX8fqfj9fPUylNyFru2s4pPAYrZMqF9Ld90PYFf6RY
         appTQh7rzpp/C2iO33dGXYACPqoCfN9r9621zOkaQoAufrtORqFlRzNUFE4pk8vGC1i0
         Veqw==
X-Received: by 10.58.188.82 with SMTP id fy18mr1979827vec.41.1367493676704;
 Thu, 02 May 2013 04:21:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.31.73 with HTTP; Thu, 2 May 2013 04:20:56 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1305021241040.3972@ionos>
References: <20522420.158691367384219315.JavaMail.weblogic@epml17>
 <CAOiHx=mBPHmDse4EwL-+Fgmpz0=XhcgF_0nWdyvErFO4NU7E0Q@mail.gmail.com> <alpine.LFD.2.02.1305021241040.3972@ionos>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Thu, 2 May 2013 13:20:56 +0200
Message-ID: <CAOiHx=mA-htk_2daeE9WpbEVV9YLvfLc1NYZZR=JeDdibchCnw@mail.gmail.com>
Subject: Re: mips; boot fail after merge 3.9+
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     eunb.song@samsung.com, "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Thu, May 2, 2013 at 12:42 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Does the patch below fix your issue ?

Does not work for me either. I don't even have SMP enabled, so this
codepath isn't taken for me at all.


Jonas
