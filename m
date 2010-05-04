Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 06:36:00 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:52525 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491171Ab0EDEf4 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 May 2010 06:35:56 +0200
Received: by vws8 with SMTP id 8so796972vws.36
        for <linux-mips@linux-mips.org>; Mon, 03 May 2010 21:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TBYnzKy539UZklv2GxCIIwemDLHJTVl5jXKC+SZBBJ0=;
        b=Ig1pjOLLby9vunFRaL9W3XL5cFtsDe7+jF4pZsMJKnnRh4Uva+vT2ukdOxU1BtjaCk
         +SRN/eOZVyhi4M0uhZkGbqSaNGoOoXxxkKr02+W974k9O2jfSBFosLAyvYqCv2byeXyv
         lKCiJdpbiB4QP4zNPlOLCIpIntfS0GFhnxWxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hfvYxiQ4iuaRf04jJxPwtQvx6uTkubWIo6r25WRq8vgLcVnrADH8QlRHPxHUgt9xC4
         T/hrkBqdipJzIidg0OlFvpinBAeldsNv5nBQ77kVyA5zeJwX0GcsCts8dDyPjwHqWkRX
         PbEm95Yb04MEyIuGo0ranoWuZNfJXGPvShIn8=
MIME-Version: 1.0
Received: by 10.220.63.10 with SMTP id z10mr10956827vch.70.1272947749377; Mon, 
        03 May 2010 21:35:49 -0700 (PDT)
Received: by 10.220.19.212 with HTTP; Mon, 3 May 2010 21:35:49 -0700 (PDT)
In-Reply-To: <n2pb2b2f2321005032049h56cd72ceh3ac7120c547b59c5@mail.gmail.com>
References: <E1O8lDn-0000Sk-86@localhost> <4BDF366E.5000501@paralogos.com>
         <k2hb2b2f2321005031843l87f39f36h960153cae3ec5020@mail.gmail.com>
         <4BDF8092.1060401@paralogos.com>
         <n2pb2b2f2321005032049h56cd72ceh3ac7120c547b59c5@mail.gmail.com>
Date:   Mon, 3 May 2010 22:35:49 -0600
Message-ID: <n2rb2b2f2321005032135ze807a2aft8811a7937288de53@mail.gmail.com>
Subject: Re: Unexpected behaviour when catching SIGFPE on FPU-less system
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, May 3, 2010 at 9:49 PM, Shane McDonald <mcdonald.shane@gmail.com> wrote:
> Looking at env[0], I see that the __fpc_csr field has a value of 1024,
> indicating a divide-by-zero.  As soon as that ctc1 instruction
> is executed, the exception is raised.  I guess that makes
> sense, but I don't understand why __fpc_csr has a value of 1024.
> When I step through the call to setjmp(), it gets set to a value of 0.
> In longjmp(), every other field in env[0] has the value that it was
> set to in the call to setjmp().

Wait, I take that back -- I was looking at the wrong env[0] variable!
I can see that __fpc_csr actually does have a value of 1024 when
I call setjmp(), and that's why longjmp() is setting the FCSR
register to indicate divide-by-zero.  If I comment out my call to
feenableexcept( FE_DIVBYZERO ), it is set to 0; if I include that call,
it is set to 1024.

Looking further, I also see that I confused the Cause bits and the
Enable bits of the FCSR -- the Enable divide-by-zero bit is set,
not the Cause bit.  Clearly, the call to feenableexcept() must
be setting that bit.  But, it no longer makes sense that an exception
is raised when the FCSR register is restored to the value 1024.

Shane
