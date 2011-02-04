Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2011 04:24:51 +0100 (CET)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:55553 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490961Ab1BDDYr convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Feb 2011 04:24:47 +0100
Received: by qwj9 with SMTP id 9so1461958qwj.36
        for <multiple recipients>; Thu, 03 Feb 2011 19:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0ANHv8SJTJXJNAToirr7L5FRoJx+b9m/H+fREj0Xl3o=;
        b=aK3wQJo/tOTMiYe1q9j+BTMwLrhbrJvUCIUMjxwgRspegH547b7WcuH4Zxb1iEvqsq
         p+DEyBUy7dJNFI+M4DWxPXHEIq23jfJWcHRTOojWFM/4KQqyDAjKRpZF7zB/ZtAHR69Q
         Tv9d6qDUnFhlXY8JOwqVeIWNYXJi09JzckDFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Lt17TyrU8MyYowcZezakovfORvKROmxPPV9JNGq41rpVVbuFvOcUDc2w5ecGH+k8Wp
         Po2lXqqGV3D1xHP8IOgq5WcUfXoOMoTKzscorsGrnCerENb0irgcFP0UCjzzZrDKizGi
         xD2i7WzU8EwJmUZYyxMJOJMFgC5R3fgFmhLHs=
MIME-Version: 1.0
Received: by 10.229.235.201 with SMTP id kh9mr9744448qcb.240.1296789881588;
 Thu, 03 Feb 2011 19:24:41 -0800 (PST)
Received: by 10.229.98.5 with HTTP; Thu, 3 Feb 2011 19:24:41 -0800 (PST)
In-Reply-To: <20110131130820.GB26217@linux-mips.org>
References: <AANLkTik+vpiWR4Xk4Pu+uCHq3XO=BZMGVka8-B9vuQew@mail.gmail.com>
        <4D3DCB5A.6060107@caviumnetworks.com>
        <AANLkTin6GkKeJATbafP-k9YNcSTHeT8ohDpUD2RLDZ1J@mail.gmail.com>
        <20110131130820.GB26217@linux-mips.org>
Date:   Fri, 4 Feb 2011 08:54:41 +0530
Message-ID: <AANLkTi=UTRk8e6fv3USP5RPKY-Fg0ehGBXrf0bD8NthX@mail.gmail.com>
Subject: Re: page size change on MIPS
From:   naveen yadav <yad.naveen@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Himanshu Aggarwal <lkml.himanshu@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        kernelnewbies@nl.linux.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

thanaks a lot for your suggestion ..


I debug this issue further, and here is my observations:

1. If I replace init with simple static link executable binary, this
can be executed.
2. In case of busy-box, I debug the reason why init fails to excute.

When I execute init command from busybox the control goes in main()
function of busybox(appletlib.c) with argv value
as the command you are suppose to execute, which in our case is init.

But when i check argv is coming null when page size is 64KB and it
comes init when page size is 16KB.

This behaviour is very strange and i am still debugging this issue.


I have check in Glibc, the max_page size it support is 64 KB in
codesourcercy toolchain 4.4.1

How can I check alignment issue as mention by Mr. Ralf Baechle.



Kind regards




On Mon, Jan 31, 2011 at 6:38 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sun, Jan 30, 2011 at 08:32:43PM +0530, Himanshu Aggarwal wrote:
>
>> Why should the application or the toolchains depend on pagesize? I am
>> not very clear on this. Can someone explain it?
>
> To allow loading directly with mmap the executable file's layout must
> be such that it's it's segments are on offsets that are a multiple of
> the page size so in turn the linker must know that alignment.
>
>  Ralf
>
