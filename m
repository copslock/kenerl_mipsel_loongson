Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2011 19:00:31 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:34860 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491763Ab1AUSA2 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jan 2011 19:00:28 +0100
Received: by eyd9 with SMTP id 9so1002030eyd.36
        for <multiple recipients>; Fri, 21 Jan 2011 10:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3XZDYq+O5NsATQqR6HMKj64/XtU/NsaRr/BPBGK7dCE=;
        b=HsqPEfdpCDCHTyIDqEc87G6plMOK4h/SU+BQxncR6zm1P5lrZsN5YeV0IZhvQWEN4t
         iAqoCALb72EXMb3ACE31dmeLlC/0F5AmffDXk60k4kccdMY/71IJCER52n4422GFFpJe
         neSeqEvbYXkd0GdXrTomhOgGbsICQu+NNv0IU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TXoPoWpZYPkRH/3rltnWugVHLLkiy8oUCyHeyVba/1jzKft7MpGeXH+JkY91rCKlRd
         6dn1mKprh52f97hPsgbyhbmq/UPUJqSBobccTKkL6njtuk8HNZrWWUCqmnr7QVMlsle4
         5+KWEj+F6tkrmxwCcTSJyOuqqNVTjnVHUUHnU=
MIME-Version: 1.0
Received: by 10.216.191.160 with SMTP id g32mr18421wen.18.1295632827810; Fri,
 21 Jan 2011 10:00:27 -0800 (PST)
Received: by 10.216.93.137 with HTTP; Fri, 21 Jan 2011 10:00:27 -0800 (PST)
In-Reply-To: <4D39C3ED.4020401@mvista.com>
References: <1295630970-32044-1-git-send-email-wuzhangjin@gmail.com>
        <4D39C3ED.4020401@mvista.com>
Date:   Sat, 22 Jan 2011 02:00:27 +0800
Message-ID: <AANLkTimKN_kGoxgA85AJMN-N1hLfTsSPBoDW0bZTXk5c@mail.gmail.com>
Subject: Re: [v2 PATCH 5/5] tracing, MIPS: Fix set_graph_function of function
 graph tracer
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, Jan 22, 2011 at 1:35 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
>> +
>> +       insns = (in_kernel_space(self_ra)) ? 2 : MCOUNT_OFFSET_INSNS + 1;
>
>   You're still keeping the parens around the function call. Why? :-)

I even didn't notice there was parens there, may be parens mania, new
one will be out immediately ;-)

>
> WBR, Sergei
>
