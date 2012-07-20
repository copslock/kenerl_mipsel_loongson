Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2012 23:06:54 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:55179 "EHLO
        mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903748Ab2GTVGu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jul 2012 23:06:50 +0200
Received: by ghbf11 with SMTP id f11so4743526ghb.36
        for <linux-mips@linux-mips.org>; Fri, 20 Jul 2012 14:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=6w1VWgyiw+m9RsZKkVDy62tHKRq0zeow6FE9nzKpKAg=;
        b=eX5hZnlJjzxETvNN0+WXAwsfH/tVXNYz/mNrurIAKWCP0NLJFhQPx3C7xgihiMQP+M
         e6kANOPPVNhOptkDYLF36htZW8du3o38HxP2vJ4AKxdek5Is5Eqyo9f8/mx6JRmtyoFP
         dJHm2O1jvAAQNd1eQYW9HkNQ8gd8N1xXsrYsdmznbgT7vQOsKMhpppBWua6mIfvOew3t
         dKJcQQAhzs+4qvSSyVea66TfikZlWqDnCuYiThItJswPs+4yqg+cpYblxXwrm49TnmlQ
         YryC/wITTUM8kJl720vaWIiDSMhG5w9VdZS+vVPGa9GGOQ+XMjodV1tGYBkWwnIKh+b0
         2kzg==
MIME-Version: 1.0
Received: by 10.50.94.133 with SMTP id dc5mr9352614igb.16.1342818404325; Fri,
 20 Jul 2012 14:06:44 -0700 (PDT)
Received: by 10.231.135.1 with HTTP; Fri, 20 Jul 2012 14:06:44 -0700 (PDT)
In-Reply-To: <20120720215516.03abd164@pyramind.ukuu.org.uk>
References: <20120713141345.f71b7c01f720d616d74721dd@canb.auug.org.au>
        <20120713121053.0637219f@pyramind.ukuu.org.uk>
        <CAMuHMdWRM0y07r1nL-9fXB3nLKXMgftqhiruEeuEe4QYDA2o9Q@mail.gmail.com>
        <20120720215516.03abd164@pyramind.ukuu.org.uk>
Date:   Fri, 20 Jul 2012 23:06:44 +0200
X-Google-Sender-Auth: jTxq8avEmrgzCrGCx1FUtEagvy4
Message-ID: <CAMuHMdXt2zptOB=F4suLYjoAp0k9fWPQMLdt-67pN53rD5yqaw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the tty tree
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:     David Daney <david.daney@cavium.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg KH <greg@kroah.com>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 33948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Alan,

On Fri, Jul 20, 2012 at 10:55 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> Today's build failed because there's a new user in the MIPS tree:
>> arch/mips/cavium-octeon/serial.c
>>
>> http://kisskb.ellerman.id.au/kisskb/buildresult/6739341/
>
> The version in the tree I have registers a platform device rather than
> calling into 8250 directly. That appears to be rather better mannered
> than whatever you are building.
>
> If someone has moved from the platform device could they kindly explain
> *why* ?

commit 7c507e6fe36d8e8f67a06d1f81ddde4d8ecf739f ("MIPS: Octeon: Use
device tree to register serial ports.") in linux-next.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
