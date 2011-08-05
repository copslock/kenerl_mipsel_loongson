Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Aug 2011 15:17:55 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:58285 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491140Ab1HENRr convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Aug 2011 15:17:47 +0200
Received: by wwe32 with SMTP id 32so2119170wwe.24
        for <multiple recipients>; Fri, 05 Aug 2011 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=maB2xdZBd8HLG8DlGZOBpHBQ25FHuJLNmwsPzGDJ4Jo=;
        b=tukkESIN/5umPu6yevVbIj9XcccAerxdaeCZyLxvpXvQugUCD8fjUEZrRNNB0QXEip
         EqteYZYEmDy8RjmTO7RigwsX7kSxEbAgfVtw/2f5XWjfbaaBC2uTpJNJZQU82yoaMxaZ
         vJQUvYWAPYCc3FjT2VjitulVzPs/GBPKrTwYM=
MIME-Version: 1.0
Received: by 10.216.80.14 with SMTP id j14mr2161876wee.9.1312550249415; Fri,
 05 Aug 2011 06:17:29 -0700 (PDT)
Received: by 10.216.46.136 with HTTP; Fri, 5 Aug 2011 06:17:28 -0700 (PDT)
In-Reply-To: <20110804150709.GD3149@linux-mips.org>
References: <CAJd=RBA9ihp94TtjkWbAVo1Y_2+Vp1VskJWVahN85biCEAYWtQ@mail.gmail.com>
        <20110804150709.GD3149@linux-mips.org>
Date:   Fri, 5 Aug 2011 21:17:28 +0800
Message-ID: <CAJd=RBA1BiARt2n_wLUUd-uNkzhZBv7PLephR9b31OyED5u_eQ@mail.gmail.com>
Subject: Re: [RFC patch] MIPS: select correct tc
From:   Hillf Danton <dhillf@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4138

On Thu, Aug 4, 2011 at 11:07 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> Please, when posting MIPS patches ALWAYS include linux-mips@linux-mips.org
> so patchwork can snarf up the patches.  Without that there is a significant
> chance that I'm going to miss patches.
>
Got and thanks.

Hillf
