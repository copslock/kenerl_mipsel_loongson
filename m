Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2014 10:50:30 +0100 (CET)
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64492 "EHLO
        mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826068AbaCSJuYuHY9H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Mar 2014 10:50:24 +0100
Received: by mail-wi0-f172.google.com with SMTP id hi5so4774363wib.11
        for <multiple recipients>; Wed, 19 Mar 2014 02:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VwUJ8Xpe6UuPJ5rwXbFEh7ZKTsB9Z43oBIE6rh33Gm4=;
        b=QGbFX1jTr1SdCPn6pb5zrSY74ARWWQKyoWoQFRqNTF1y4aJ8jB/5jd2dJpBES8Zt+T
         UdHMaWPJw9r/xQeYujOK4tMZlStDwiWQllY33V8sPhwLYEQ9XAIOQmlVdevndWgLcC+T
         TYkW0WhIhLr1FompOsrxdPHFxJPVHov+uaN7k1YA4uNU3z1WXCyMe2X9zrl0c1/d4Kfv
         AJ+NyyhCEV0an9cBKBYBPeKkhTHU7BTlJVqQxY2ckCusViXfyODFqokoPCtzQKCXe6J6
         dRmAVcUmE2StWipD5DBoAzEWcOBii1wHaFLzjBO58nQ5w9P956cU8t9/1DTI/Fm8AmzD
         Zljg==
MIME-Version: 1.0
X-Received: by 10.180.188.66 with SMTP id fy2mr18243354wic.45.1395222619402;
 Wed, 19 Mar 2014 02:50:19 -0700 (PDT)
Received: by 10.227.100.130 with HTTP; Wed, 19 Mar 2014 02:50:19 -0700 (PDT)
In-Reply-To: <20140318120452.GA17197@linux-mips.org>
References: <1393055209-28251-1-git-send-email-villerhsiao@gmail.com>
        <1393055209-28251-2-git-send-email-villerhsiao@gmail.com>
        <20140317145641.GN19285@linux-mips.org>
        <CAA1JSY+0_4Vb9y0T+oWdZRKPEpy08soa05kNT=7Hw9+qfPG5DQ@mail.gmail.com>
        <CAA1JSY+pzsUp+Pfhvm2-rMJ0KfeZr8YaDvuefO3KqRr-Xbmj6A@mail.gmail.com>
        <20140318120452.GA17197@linux-mips.org>
Date:   Wed, 19 Mar 2014 17:50:19 +0800
Message-ID: <CA+zhxNnbikJpk=15-xh=qfU+PKH=T+sjSG+cODSHn6yOTqbScg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] MIPS: ftrace: Tweak safe_load()/safe_store() macros
From:   Tony Wu <tung7970@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Viller Hsiao <villerhsiao@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Qais Yousef <Qais.Yousef@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

On Tue, Mar 18, 2014 at 8:04 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Mar 18, 2014 at 03:53:00PM +0800, Viller Hsiao wrote:
>
>> The operand name and variable name are a little ambiguous in PATCH v2.
>> Therefore I tweaked and submitted PATCH v3. Please help to use them if
>> possible.
>
> Too late, the older versions of your patch were pulled by Linus
> yesterday.  If you have further improvments beyond those version in
> Linus' tree now, please submit a new patch.
>
> Thanks!
>
>   Ralf
>

Ralf,

This patch is required for the other ftrace patch you cherry-picked to
linux-3.x-stable tree. The safe_store macros cannot take expression as
operand without this patch.

Thanks,
Tony
