Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2012 07:07:50 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:59762 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817521Ab2JMFHqgOJyp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2012 07:07:46 +0200
Received: by mail-lb0-f177.google.com with SMTP id gi11so2393539lbb.36
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2012 22:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZVeNZRyv9rCjzzoQpnwCr30dsWL2X3WNOyJookTgpvs=;
        b=dFPJSQXPeDuAlWWitrcpZuVy32vCzgsSydqF55HaxzRoargSyxxIhAUA3GFLphCc/I
         5SUbL3BhDzvYhXeXDshQQmHayxoT16LSRedzWz1dD8mkn91qSbAB6aRsQgXPRM+hJL0K
         2EiQG/CcAOYOqn5xQUhtCuDnJJhKgyOTD9CsBiRvdivJygTaUdxzR+hHtGEXNtomoIBK
         Kk/+lZu8USwJPQeIwjYhrpMWbR96jMQOa/wdztWZELfBmaVk9iZieMg0/Hj3qXDugzcZ
         Y3ZHnNaV0YZPdBW3vOFiFCNAzXUhlqXwB2dU9PDfy/TWvZF3XQ8Z6fD+iV8wSBGFQ3mT
         EFYg==
MIME-Version: 1.0
Received: by 10.152.148.195 with SMTP id tu3mr5290185lab.16.1350104860915;
 Fri, 12 Oct 2012 22:07:40 -0700 (PDT)
Received: by 10.114.21.199 with HTTP; Fri, 12 Oct 2012 22:07:40 -0700 (PDT)
In-Reply-To: <CAF1ivSbCYW3Dfs7Ej=XdAhdk5Xc+enoY-wKmwZSZ4bJ+HmPa8g@mail.gmail.com>
References: <CAF1ivSYqNpzZD5U6Ne_FL_gDmPC0aETb7Gt3uyWZzNp9tTMP5Q@mail.gmail.com>
        <20120828081353.GB23288@linux-mips.org>
        <CAF1ivSbCYW3Dfs7Ej=XdAhdk5Xc+enoY-wKmwZSZ4bJ+HmPa8g@mail.gmail.com>
Date:   Sat, 13 Oct 2012 10:37:40 +0530
Message-ID: <CAMmEz3TzA-ndXpeEeWOgt81KK-68Qmne7WMt6fqYaaALh32r0w@mail.gmail.com>
Subject: Re: panic in hrtimer_run_queues
From:   Noor <noor.mubeen@gmail.com>
To:     Lin Ming <mlin@ss.pku.edu.cn>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noor.mubeen@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

>> On Tue, Aug 28, 2012 at 09:42:51AM +0800, Lin Ming wrote:
> fn = timer->function;
> restart = fn(timer);   <---- line 1164
>
> Seems "fn" is corrupted....

was this root cause identifed ?

Noor
