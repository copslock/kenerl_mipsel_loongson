Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 15:43:51 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:50777 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493421Ab1AQOnp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jan 2011 15:43:45 +0100
Received: by iwn38 with SMTP id 38so4941837iwn.36
        for <linux-mips@linux-mips.org>; Mon, 17 Jan 2011 06:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WyGLWAKAeOQLD9Bk61gOKrxoa9KuGEkmbxvtqGW1xBE=;
        b=g8RCsFA94jazRISVtIo3l9ecTGFW4n8BtMlyqY4J/S82u4Ne8O/2jdJxgm9gzgk+qt
         wmZlV7Pak035/ZlMNOqV5QHrQ+eAi9lZo0o1rO7om0Y3Do2o413Qh14j24ukhrAllqBa
         erw7g8A47n+Y+0j0DLsJIWMWzABPHFY2T/Ha8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DkaxvQQrysqCHS4kGdXwEvkD+bD2eh5pnVq6eUovV9JZcZmQ9e9UzKcD5LPUQ8Nr9P
         v2nJPLaWeO2qaUinmyoRfR2Rge09zU9ix2YbG/VxhpOTIECE0gvgxj1lkKSUaRIGMyxG
         X0JxUeJugTNbB4Jz5gsdqctfC7Wy0Z7JjmHKY=
MIME-Version: 1.0
Received: by 10.42.164.194 with SMTP id h2mr4516845icy.197.1295275423661; Mon,
 17 Jan 2011 06:43:43 -0800 (PST)
Received: by 10.42.221.136 with HTTP; Mon, 17 Jan 2011 06:43:43 -0800 (PST)
In-Reply-To: <AANLkTimN4mTxSJiBD2cNs-pOTQBTHysFQYyYiU5ZSBsQ@mail.gmail.com>
References: <1295255224-19408-1-git-send-email-xiangfu@sharism.cc>
        <AANLkTimN4mTxSJiBD2cNs-pOTQBTHysFQYyYiU5ZSBsQ@mail.gmail.com>
Date:   Mon, 17 Jan 2011 16:43:43 +0200
Message-ID: <AANLkTinMEFjXQZapVTZ=LgdXhNEEpYqpr7Pb1ong7_cp@mail.gmail.com>
Subject: Re: [PATCH] MIPS: add U-boot uImage build target to arch Makefile
From:   Sergey Kvachonok <ravenexp@gmail.com>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     Xiangfu Liu <xiangfu@sharism.cc>, linux-mips@linux-mips.org,
        lars@metafoo.de
Content-Type: text/plain; charset=UTF-8
Return-Path: <ravenexp@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ravenexp@gmail.com
Precedence: bulk
X-list: linux-mips

On 1/17/11, wu zhangjin <wuzhangjin@gmail.com> wrote:
> Hi, Xiangfu
>
> On Mon, Jan 17, 2011 at 5:07 PM, Xiangfu Liu <xiangfu@sharism.cc> wrote:
>> Requires mkimage tool from u-boot-tools.
>
> This patch is cool, seems more and more MIPS boards are using the
> popular U-boot ;-)
>
>> Uses gzip compression by default.
>
> Perhaps add more compression algos support and make them configurable
> will be better. lzma/xz has higher compression rate, lzo has faster
> decompression speed. and bzip2 is between lzo and gzip.
>
> Regards,
> Wu Zhangjin

Ok, I'll try to make compression algo into Kconfig option then.
And maybe unify with existing avr32 u-boot target, e.g. make use of
scripts/mkuboot.sh.
Will resubmit directly to this list when (if) it's done.

Regards,
Sergey
