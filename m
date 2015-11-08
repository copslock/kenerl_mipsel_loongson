Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Nov 2015 06:09:54 +0100 (CET)
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36457 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006153AbbKHFJxHv3a0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Nov 2015 06:09:53 +0100
Received: by oiww189 with SMTP id w189so61443654oiw.3
        for <linux-mips@linux-mips.org>; Sat, 07 Nov 2015 21:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital_net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iUdq+xQlFI1K9CjZtVMtYtwpXIgIH3Ahp4jA7ZT5Mhs=;
        b=Uf2Evya8D1Ze8Es6wvSSGY8/+kK9eJAmLWAYa6VhE1T/F4SvTivbiSZMp3yhLmeY1Q
         rLDqzNNQbyo8KQlDkuSnQ04Q1tPx7jTY7GusZ1A/KJnAAhjtTHQLQbeS3CpqWAT5Za0U
         W+EjO1qcWM3y4guFnV4Ex5z9TbzfLRCj+xueXXiexC6w5RB7t4DIoSXqoQLaTcAxhN35
         fiC4XhD4IxZWZBtagesaw/omFh8WxLXkL5RjtSCi3QXKm50i+MwKjwq2jl3Nz82gbw9L
         IEEXm1HTshqFzzLuoEkmApGXn+dtC58Tldoz2jyaISUQDmCBq0x08eY5CWXr0SEZZ+xC
         gZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=iUdq+xQlFI1K9CjZtVMtYtwpXIgIH3Ahp4jA7ZT5Mhs=;
        b=GtHFPmNJlu+JEYkg3DQF20ChtzkVWjbPx8vWVbfCepvNzFl8+iC739pHlmcndbZGsT
         dG6yL+Bjpb9wBtfS+vLLfFGKPzZaIplx0U4ZVb6nvwWTjh7V2qiuc150GAXcUMIO8apc
         Zf6/pjXMwYcynI8HUTHWkghueU2iE5tM98RF++MWIm93VXc8pXl3ct/3E3+EGzBKRfNU
         Z2f7fznGuIXcikXwDtSIMiKY40OQOXVwhUhBruJjUrjQ/pvcVE7TEEpmF5aG/Rkouf9n
         WZtGyU4SSqJzFU4pDcg7lY8rkx8Tb/D73a9/HOPz8x5XaK76y5hdudUhviS+6U3VaV6A
         5hYw==
X-Gm-Message-State: ALoCoQkTCwWhF4TTPinYu7y0kgfv7NRG8gK/WIIHXO66lE70quAGUuaqY5PwTu4uWq1FsJFbn5LB
X-Received: by 10.202.204.5 with SMTP id c5mr6207097oig.93.1446959387024; Sat,
 07 Nov 2015 21:09:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.202.44.71 with HTTP; Sat, 7 Nov 2015 21:09:27 -0800 (PST)
In-Reply-To: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
References: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Sat, 7 Nov 2015 21:09:27 -0800
Message-ID: <CALCETrWKK_REdX7TJO8X7jC=8k=YdgJH_txXpC4Pdzn-tukg5A@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] Fix handling of compat_siginfo_t
To:     "Amanieu d'Antras" <amanieu@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kenton Varda <kenton@sandstorm.io>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Wed, Nov 4, 2015 at 4:50 PM, Amanieu d'Antras <amanieu@gmail.com> wrote:
> One issue that isn't resolved in this series is sending signals between a 32-bit
> process and 64-bit process. Sending a si_int will work correctly, but a si_ptr
> value will likely get corrupted due to the different layouts of the 32-bit and
> 64-bit siginfo_t structures.

This is so screwed up it's not even funny.

A 64-bit big-endian compat calls rt_sigqueueinfo.  It passes in (among
other things) a sigval_t.  The kernel can choose to interpret it as a
pointer (call it p) or an integer (call it i).  Then (unsigned long)p
= (i<<32) | [something].  If the number was an integer to begin with
*and* user code zeroed out the mess first, then [something] will be 0.
Regardless, p != i unless they're both zero.

If the result gets delivered to a signalfd, then it's plausible that
everything could work.  If it gets delivered to a 64-bit siginfo, then
all is well because it's in exactly the same screwed up state it was
in when the signal gets sent.

If, however, it's delivered to a compat task, wtf is the kernel
supposed to do?  We're effectively supposed to convert a 64-bit
sigval_t to a 32-bit sigval_t.  On a little-endian architecture, we
can fudge it because it doesn't really matter whether we consider the
pointer or the int to be authoritative.  I think that, on big-endian,
we're screwed.

BTW, x86 has its own set of screwups here.  Somehow cr2 and error_code
ended up as part of ucontext instead of siginfo, which makes
absolutely no sense to me and bloats task_struct.

--Andy
