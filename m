Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2011 04:26:15 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:62484 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490947Ab1CRD0L convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Mar 2011 04:26:11 +0100
Received: by ywa8 with SMTP id 8so1512897ywa.36
        for <linux-mips@linux-mips.org>; Thu, 17 Mar 2011 20:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bIiQKlWKc6wKg7HdOs3k5fVhDQLq2bmJc+4ygoRk4cc=;
        b=fm5DrrG4RxdM4dVILM9E2DBWQUcaRrSwHzFiJwuJj4WvfIRt3PSqwyjcBToIyKdOH4
         V+gxI0Q21KV/BJMTVI3q9YbiO7Vmqdkje3SFrggh2aQcdDKyyvi1RHXDq6Ij2baW6pkX
         aT+Pq2q1ejMlgmXyqNZrmJiaE1p4KIK0n1el8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bqXmcjVv5OIiflp9lNH9x6Z5ZtWTcl3h0QzLDju5ml9e7KAQev5QfLidb35MuxINB3
         XqMsH+F9pf7YB5Cbq27r4zooYoJk3eiwZh1DF7Q3Ua9vqFBBAq6uMv9Uz/0+kb3U0w5w
         C6pFoBOoqbOakWOg8833hlDxxq6CwWKnwwI8w=
MIME-Version: 1.0
Received: by 10.146.144.8 with SMTP id r8mr600683yad.9.1300418765086; Thu, 17
 Mar 2011 20:26:05 -0700 (PDT)
Received: by 10.147.82.6 with HTTP; Thu, 17 Mar 2011 20:26:05 -0700 (PDT)
In-Reply-To: <20110314142927.GA18480@jayachandranc.netlogicmicro.com>
References: <20110312182714.GC2217@jayachandranc.netlogicmicro.com>
        <AANLkTime__o2bGyUn1-CsY4O=VhniN14u_fHYYxYz=VQ@mail.gmail.com>
        <20110314142927.GA18480@jayachandranc.netlogicmicro.com>
Date:   Fri, 18 Mar 2011 11:26:05 +0800
Message-ID: <AANLkTi=5-zOAXUr95S-KS3kT4Nm2F8H=6Y9AKGg09iv=@mail.gmail.com>
Subject: Re: [PATCH] Support for Netlogic XLR/XLS processors
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
Cc:     "wilbur.chan" <wilbur512@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Mar 14, 2011 at 10:29 PM, Jayachandran C.
<jayachandranc@netlogicmicro.com> wrote:
> On Mon, Mar 14, 2011 at 08:19:22PM +0800, wilbur.chan wrote:
>> Will kexec be supported on XLS/XLR/XLP ?
>
> The patches I have does not support it. I haven't really looked at what
> is needed in XLR platform code to support kexec, so I'm not sure what it
> takes to support it for XLR either. Any pointers?

You can get some information here:

http://dev.lemote.com/code/linux-loongson-community/wiki/kexec-loongson

And here:

http://patchwork.linux-mips.org/project/linux-mips/list/?q=kexec

BTW: what about the cpu hotplug support for XL{R, S, P} ?

Regards,
Wu Zhangjin

>
> JC.
> --
> Jayachandran C.
> jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
> jchandra@freebsd.org                               (The FreeBSD Project)
>
>
