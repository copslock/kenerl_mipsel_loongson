Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Oct 2011 04:51:03 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:59243 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490964Ab1JOCuz convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 15 Oct 2011 04:50:55 +0200
Received: by iarr31 with SMTP id r31so3944350iar.36
        for <multiple recipients>; Fri, 14 Oct 2011 19:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Kr7t6/fQTcPDLei54ZEWdQ+XtPdEk5iRkOMHYc2r8bc=;
        b=nUYq7hzuVQj/xagCNXaxWWBgQOyCo/6xZohUTbjg2jg+RDoieMXsAJVJl3jrityn/W
         Ce+SSzfMEdEtWA57fFKRl51eS3seCwvMXFrUNJoB6MRTDoomCglppdqhN2jF+ougLmAM
         7LkF0fGpLJJrZMdgvgH3gyueHRihPZnlM0RZw=
MIME-Version: 1.0
Received: by 10.231.45.135 with SMTP id e7mr377109ibf.12.1318647049062; Fri,
 14 Oct 2011 19:50:49 -0700 (PDT)
Received: by 10.231.59.135 with HTTP; Fri, 14 Oct 2011 19:50:49 -0700 (PDT)
In-Reply-To: <20111013080412.GA17240@linux-mips.org>
References: <20111012190659.GC15003@mails.so.argh.org>
        <20111013080412.GA17240@linux-mips.org>
Date:   Sat, 15 Oct 2011 10:50:49 +0800
Message-ID: <CAD+V5Y+shM4eqVHomaHvrXKdO8WpKfpCHw=2ExP1GFuuQzSaGw@mail.gmail.com>
Subject: Re: YeeLoong / hotkey driver
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Andreas Barth <aba@not.so.argh.org>, linux-mips@linux-mips.org,
        debian-mips@lists.debian.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10930

On Thu, Oct 13, 2011 at 4:04 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Oct 12, 2011 at 09:06:59PM +0200, Andreas Barth wrote:
>
>> there is currently a mail thread about the hotkeys not working with
>> the default debian kernel. After a bit of search, I noticed the
>> patches within
>> http://www.linux-mips.org/archives/linux-mips/2009-11/msg00598.html
>> however I didn't find a conclusion.
>>
>> Do you remember (or does anyone else) what happened to the patches or
>> how we could get hotkey support into the default kernels? Thanks!
>
> Back then a debate started and no updated version of the patch was ever
> posted.  But nothing fundamentally wrong with the patch.

The old patch is out-of-date, perhaps we can start a new trip to
upstream the latest version maintained at
http://dev.lemote.com/code/linux-loongson-community.

The latest one threaded the irq interrupt handler and fixed some bugs.

Hope somebody else can work on it for I'm a little busy currently ;-)

Thanks Ralf,

Regards,
Wu Zhangjin

>
>  Ralf
>
