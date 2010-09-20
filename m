Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Sep 2010 11:23:47 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:49636 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490967Ab0ITJXo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Sep 2010 11:23:44 +0200
Received: by vws11 with SMTP id 11so3612933vws.36
        for <linux-mips@linux-mips.org>; Mon, 20 Sep 2010 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=cRJWS/HL0te7crIe1ENyLVp3rnXWDE5/Ec0ZzzyYthk=;
        b=kh4R7iB6SSC7hfh1CTndEUqFHKoOHVqYMVK0Wba/SqhJFfnkjIkiielU8IHA2+Qnru
         MxschsRMPfbFWZ1ASmCcij9WdMDQFYyyCgtn0JxkPsQRQDdxC8Iaf7Is3ZbUhYnhIeoU
         J6VmKBuOrkFP91XmSBLz0tNe0B7N8B6v5se/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=R5pKxchrpJVSyqnxM/LDmMVefLZE79XUR5mSnboVOkh9bDgrMz/wpPtIrkuReZVhGw
         eBHANQm5U+K2zcnGAytVxCjmkVSrOAAqCzYVKzrN5YvvqV5f2kZYZPdM+Sybrt8HLXCw
         R2uvfwjjMreFOILCG93fiHoxJnbXfslo4p/w0=
MIME-Version: 1.0
Received: by 10.220.157.200 with SMTP id c8mr4474413vcx.160.1284974618020;
 Mon, 20 Sep 2010 02:23:38 -0700 (PDT)
Received: by 10.220.195.3 with HTTP; Mon, 20 Sep 2010 02:23:37 -0700 (PDT)
In-Reply-To: <AANLkTinU_bBu8n9-dW31ATqA-CKX+UHyNOkRHHhZAiro@mail.gmail.com>
References: <AANLkTinU_bBu8n9-dW31ATqA-CKX+UHyNOkRHHhZAiro@mail.gmail.com>
Date:   Mon, 20 Sep 2010 10:23:37 +0100
Message-ID: <AANLkTinZz9TZDfmyULfQ0J7pbAguaLd2vq8689fmJm9B@mail.gmail.com>
Subject: Re: mips64-octeon-linux-gnu
From:   Tom Parkin <tom.parkin@gmail.com>
To:     Maciej Drobniuch <maciej@drobniuch.pl>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tom.parkin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 15183

On 17 September 2010 19:53, Maciej Drobniuch <maciej@drobniuch.pl> wrote:
> Hi ALL!
> I'm new to linux-mips world!
> I'm looking for a toolchain called mips64-octeon-linux-gnu
> Does anyone know where i could get one ?

If you go down the route of compiling your own, you may want to take a
look at the crosstool-ng project:

http://ymorin.is-a-geek.org/projects/crosstool

I'm not sure whether mips64-octeon is currently supported, but if it
is crosstool-ng could save you a lot of legwork on building the
toolchain by hand.

Tom
-- 
Tom Parkin
www.thhp.org.uk
Morality, like art, means drawing a line someplace /Wilde/
