Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2012 16:47:25 +0200 (CEST)
Received: from mail-vc0-f177.google.com ([209.85.220.177]:38522 "EHLO
        mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903556Ab2G0OrT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jul 2012 16:47:19 +0200
Received: by vcbfl13 with SMTP id fl13so2821549vcb.36
        for <multiple recipients>; Fri, 27 Jul 2012 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kmwH53DQ7bhX4LK+XTWQ1oxcB5/83zEFEYWbaLgLAcQ=;
        b=j+lYMDWw1Z4ie527MfVqnEMSgSzVq0jnDzvpjSqRvWROgisRe/zaz+eYqmdj5acY1p
         +x83Kvbd+PEpstFJtHFPRKz/HJPg6u+0L4Hesb/Ho6p/cGhK0JqkdBd5oaoQvQ63wIhH
         BHln8JzAHiz1PY++6axyI8ce4dPKePKzslEUqJI47cWc5uR6XWk+TqF2dHpvXIXbMZTz
         xchpy/lZuh15/OyPm/qD4Pv7JRVETLOoHDPUPmdj7ie7TipBsySgroM9SX+0wnXT983E
         bA5W699fbcnp5BntjX/VMge2ldAbiLX5i376lLHUL9iRFAnv/ncenh6/OlfGXrNLb1uZ
         1lkA==
MIME-Version: 1.0
Received: by 10.52.90.144 with SMTP id bw16mr2269104vdb.129.1343400433293;
 Fri, 27 Jul 2012 07:47:13 -0700 (PDT)
Received: by 10.220.1.210 with HTTP; Fri, 27 Jul 2012 07:47:13 -0700 (PDT)
In-Reply-To: <1343150934.42443.YahooMailNeo@web120104.mail.ne1.yahoo.com>
References: <1342922751.65328.YahooMailNeo@web120106.mail.ne1.yahoo.com>
        <CAJd=RBC24UXztNoKews5sE06DRvk_cBEYunHT7Zc-rdvAFF0ew@mail.gmail.com>
        <1343150934.42443.YahooMailNeo@web120104.mail.ne1.yahoo.com>
Date:   Fri, 27 Jul 2012 22:47:13 +0800
Message-ID: <CAJd=RBCy+zy6jRWkpjPx43H=jqs37-L8Qij4Z5y9DYak2L643w@mail.gmail.com>
Subject: Re: Direct I/O bug in kernel
From:   Hillf Danton <dhillf@gmail.com>
To:     Victor Meyerson <calculuspenguin@yahoo.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 33991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
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

On Wed, Jul 25, 2012 at 1:28 AM, Victor Meyerson
<calculuspenguin@yahoo.com> wrote:
>
> Still different checksums and I used the same random-file from my first test.
>
Then try the fix at
             https://lkml.org/lkml/2012/7/27/54

Good Weekend
Hillf
