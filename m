Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 17:16:04 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:37625 "EHLO
        mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493065AbZKYQQB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2009 17:16:01 +0100
Received: by pxi3 with SMTP id 3so5736401pxi.22
        for <multiple recipients>; Wed, 25 Nov 2009 08:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=96XwIroqYCUeChqUf4JKJs6LFllmJZNB/wFqDtGg0Xo=;
        b=VZRxpffJ1UB6IcVFXzDhBdkBP39nZpxHJEuI687VahWWbh/RgvnhBI+JsFE+ThZzNe
         YwFmxL/TkgeMW/4FGzgPf1cZZZEXaY06dONLX0LjeLIPtSGOow7xC2NThpeSqwXldWX4
         RxolbGEjzDvM72FyFpQGuX2ZS3EbYstAFTpOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=gchdp3p1+FatWbdPYCLeNWdwtXAIhyLgoVb91F7Rd9/OpDfe9e7SsUGis6IVfJRWde
         zXf66M0UGGOVBpQ/ot0Kkqa53R0E5cA8KlS/vOdG/3GiM2Xrj8jgjTGpQYJKE9POXNBl
         TB8M03l7eKTHB06iMoya8tA9gFDzM5aoeCNIg=
Received: by 10.115.66.35 with SMTP id t35mr15955234wak.87.1259165754185;
        Wed, 25 Nov 2009 08:15:54 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm4107462pxi.15.2009.11.25.08.15.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 08:15:53 -0800 (PST)
Subject: Re: [PATCH] MIPS: EARLY_PRINTK: Fixup of dependency
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Kevin Hickey <khickey@netlogicmicro.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
In-Reply-To: <1259160138.4675.14.camel@kh-d280-64>
References: <1259055230-15818-1-git-send-email-wuzhangjin@gmail.com>
         <f861ec6f0911240824u187347d6od5bfebc509a27d8d@mail.gmail.com>
         <20091124163006.GA11277@linux-mips.org>
         <1259160138.4675.14.camel@kh-d280-64>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 26 Nov 2009 00:15:36 +0800
Message-ID: <1259165736.13740.7.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-11-25 at 08:42 -0600, Kevin Hickey wrote:
> On Tue, 2009-11-24 at 16:30 +0000, Ralf Baechle wrote:
> > On Tue, Nov 24, 2009 at 05:24:57PM +0100, Manuel Lauss wrote:
> > 
> > > On Tue, Nov 24, 2009 at 10:33 AM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> > > [...]
> > > > This patch will only enable that option when the DEBUG_KERNEL is
> > > > enabled.
> > > 
> > > How about making it independent from DEBUG_KERNEL altogether?  If find
> > > it useful even without full debug info.
> 
> I agree with Manuel here.  I often build release kernels that benefit
> from EARLY_PRINTK.  Why not make EARLY_PRINTK a selectable option in the
> config?  Coupling it to DEBUG_KERNEL seems confusing. 

Hello,

Ralf have moved the EARLY_PRINTK to Kconfig.debug and removed the
dependency on DEBUG_KERNEL in his -queue repository ;) Just as the X86
and some other ARCHs does:

http://www.linux-mips.org/git?p=linux-queue.git

[...]
+config EARLY_PRINTK
+       bool "Early printk" if EMBEDDED
+       depends on SYS_HAS_EARLY_PRINTK
+       default y
[...]

So, it is okay now, please ignore this patch ;)

Regards,
	Wu Zhangjin

> 
> =Kevin
> > 
> > DEBUG_INFO controlls the generation of ELF debug information.  DEBUG_KERNEL
> > only hides most of the debugging options.
> > 
> >   Ralf
> > 
> 
