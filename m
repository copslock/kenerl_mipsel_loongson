Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Oct 2010 20:28:20 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:49436 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491122Ab0JZS2Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Oct 2010 20:28:16 +0200
Received: by wyf22 with SMTP id 22so4964774wyf.36
        for <multiple recipients>; Tue, 26 Oct 2010 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=MmpufEmUtlILGD0T77KDTEQL3Fpx+tZ3plvRUuwhoXE=;
        b=HSH+thl6uiP83J6wq5uL7IG/Jg9E7nZrApMAm/d7okH2ZPbb40rRr90JA6+qx8J7PT
         V003HwzsfUDdfm9c3cSEv7zEPrx2CMzi0nzf5K9ZJMTvIdsi/riEvatPokiXGbtu2K49
         YsV4jyYdD8Yx7Qds3bd4QJvV4JD9mW/sk8zUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=MfBVMTIs85IRCxf/gUKXlchc8Ej+BT29uIlHRcXnDBs2BXjQ6IFssBGmXWJ+42x/fA
         acr0Se1DXbPfnWudzXqKB9gFMMBFzAo8AwnvoRxIkuj8mefWkj7lZUD6fNCYlAnGsEBz
         C/5Kv164xs3ALkrMuoH0eWYaMir702FJvkYnI=
MIME-Version: 1.0
Received: by 10.216.176.20 with SMTP id a20mr1267226wem.14.1288117690156; Tue,
 26 Oct 2010 11:28:10 -0700 (PDT)
Received: by 10.216.176.203 with HTTP; Tue, 26 Oct 2010 11:28:10 -0700 (PDT)
In-Reply-To: <1288038294.18238.4.camel@gandalf.stny.rr.com>
References: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com>
        <4CC49A99.1080601@bitwagon.com>
        <alpine.LFD.2.00.1010250435540.15889@eddie.linux-mips.org>
        <4CC5B474.9050503@bitwagon.com>
        <AANLkTin=ym_e8009pHkn+7jtXG1toiKb1O3TS4FNQu3U@mail.gmail.com>
        <1288038294.18238.4.camel@gandalf.stny.rr.com>
Date:   Wed, 27 Oct 2010 02:28:10 +0800
Message-ID: <AANLkTinsRMwtTzdRd89aKxFddcS8fwtOowtB4OT9vqY+@mail.gmail.com>
Subject: Re: patch v2: [RFC 2/2] ftrace/MIPS: Add support for C version of recordmcount
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Reiser <jreiser@bitwagon.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Oct 26, 2010 at 4:24 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 2010-10-26 at 02:17 +0800, wu zhangjin wrote:
>> On 10/26/10, John Reiser <jreiser@bitwagon.com> wrote:
>> > Here's a second try [discard the first] for handling MIPS64 in
>> > recordmcount.[ch].
>>
>> Just tested the 64bit kernel, it works well.
>>
>> Will test the 64bit module and the 32bit kernel and module tomorrow If
>> time allowed.
>>
>> BTW, seems this patch can not be applied directly, suggest you
>> generate it by "git format" automatically ;-)
>
>
> Great! If it all passes nicely, can I get a tested-by from you, and a
> patch that enables it for mips with an Acked-by: from Ralf?

Based on John's patch, I just added the support(no -m or --module for
recordmcount is needed) for MIPS module and tested it, it works well.
Will send it out after the testing the 32bit support.

Regards,
Wu Zhangjin
