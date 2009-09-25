Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Sep 2009 10:48:40 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:53062 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492443AbZIYIsc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Sep 2009 10:48:32 +0200
Received: by fxm21 with SMTP id 21so1925361fxm.33
        for <linux-mips@linux-mips.org>; Fri, 25 Sep 2009 01:48:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=PT+2yIWNizmFQajJi9tScOPfnvCofWCqgKg1NxHTsow=;
        b=WHngcsaZxkI2M5TYPIeexh3XBOWHqBHmk7hZPsnRf6VV4xE/0rpybp8Idcb58Q49fK
         JnUHaXXKePdSwOp08KlnIdg/VUCt06pk2EHCYfIXyyUQQ+F/KKZ7lpQqj2lZTRtICVXb
         nChqH/yqbuSIsFtJQq27KYUNXB73NpTDQF5gI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DCpADlgIXCZG+1HJuV2QXOv50xh79KOoufyKCviS1dYWfnhvlhh9Qbj0ifgjbv365a
         PnfaTST3scxrhudlfcOjpZZGzsSdS8daszkOJAyD7Kuke4W8lfCHRaKBgpTHwGW5uoeN
         SymW23W+qo5yipmZ1L+fFpLK25dmPaRbqedPA=
MIME-Version: 1.0
Received: by 10.223.144.67 with SMTP id y3mr1690551fau.40.1253868505765; Fri, 
	25 Sep 2009 01:48:25 -0700 (PDT)
In-Reply-To: <20090924194348.GA1922@merkur.ravnborg.org>
References: <f861ec6f0909232344s72af6bax5bd77f1a5be45b4f@mail.gmail.com>
	 <20090924091539.GA929@merkur.ravnborg.org>
	 <f861ec6f0909240224m4b5dcbd9hc835409e7a66102d@mail.gmail.com>
	 <f861ec6f0909240241x5c5858d4g4d44b40107021bb6@mail.gmail.com>
	 <4ABB6189.5010909@gmail.com>
	 <20090924194348.GA1922@merkur.ravnborg.org>
Date:	Fri, 25 Sep 2009 11:48:25 +0300
Message-ID: <90edad820909250148s41deacb0x89a6aab14a10170c@mail.gmail.com>
Subject: Re: MIPS: Alchemy build broken in latest linus-git [with patch]
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	Manuel Lauss <manuel.lauss@googlemail.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Sep 24, 2009 at 10:43 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
>>
>> From: Manuel Lauss <manuel.lauss@gmail.com>
>> Subject: [PATCH] MIPS: fix build of vmlinux.lds
>>
>> Commit 51b563fc93c8cb5bff1d67a0a71c374e4a4ea049 removed a few
>> CPPFLAGS with vital include paths necessary to build vmlinux.lds
>> on MIPS, and moved the calculation of the 'jiffies' symbol
>> directly to vmlinux.lds.S but forgot to change make ifdef/... to
>> cpp macros.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>
> Thanks for providing a patch!
>
> The assignment of CPPFLAGS was supposed to be
> in arch/mips/kernel/MAkefile.
>
> I fixed this up.
> Please test this patch - I will await testing
> feedback before I submit to Linus.
>
>        Sam
>
>
> From bfc4d46080e26f5806f0aa59e95fd5d284ca1fd4 Mon Sep 17 00:00:00 2001
> From: Manuel Lauss <manuel.lauss@gmail.com>
> Date: Thu, 24 Sep 2009 21:44:24 +0200
> Subject: [PATCH] mips: fix build of vmlinux.lds
>
> Commit 51b563fc93c8cb5bff1d67a0a71c374e4a4ea049 ("arm, cris, mips,
> sparc, powerpc, um, xtensa: fix build with bash 4.0") removed a few
> CPPFLAGS with vital include paths necessary to build vmlinux.lds
> on MIPS, and moved the calculation of the 'jiffies' symbol
> directly to vmlinux.lds.S but forgot to change make ifdef/... to
> cpp macros.
>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> [sam: moved assignment of CPPFLAGS arch/mips/kernel/Makefile]
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Acked-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
