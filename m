Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 May 2010 15:13:46 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:38729 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491912Ab0EXNNn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 May 2010 15:13:43 +0200
Received: by vws4 with SMTP id 4so1432459vws.36
        for <linux-mips@linux-mips.org>; Mon, 24 May 2010 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=t7dCou9vhJSq97nWBRRcN/MDJB16aoEzEZUxUq5sdJg=;
        b=T0CnnoRKut3ZonsQPSOWcNiwwzStl3tzJkhjWHhv1uqiERG5+AOcdZw1SAk+JGhKMQ
         DA8E4diM/OXF/gEe8azSWRkGf8C/2/62BahcPgaHkQL3MkwylwNNZiYkDIfbDEXbg4q+
         nMeN510VE+IaI6cP7YXso/PaQk4Rv7HNXm2+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=r7VWDLlxxk3YpI54BFRSU+EFFAZBrhRt2Q07V93s4MmVi0OypV4yluxqu9NGIWlutd
         lmw+E9Hn/Xc8huE8nlbYtl7NKxrK34oYkCx4PmgC+lkGSiyqqOUb5Yh9mXG9PhHXwBT9
         TZrUeePzWJ8zez4r1IxT4xcWLggb6ZB2kHz0s=
MIME-Version: 1.0
Received: by 10.220.122.24 with SMTP id j24mr3845031vcr.17.1274706817085; Mon, 
        24 May 2010 06:13:37 -0700 (PDT)
Received: by 10.220.12.18 with HTTP; Mon, 24 May 2010 06:13:35 -0700 (PDT)
In-Reply-To: <4BD08329.80804@adax.com>
References: <j2sdf5e30c51004172251z9fd01867h562b99c1f1044c26@mail.gmail.com>
         <q2odf5e30c51004220901l8bfa979ftc9c6a7b633569460@mail.gmail.com>
         <4BD08329.80804@adax.com>
Date:   Mon, 24 May 2010 21:13:35 +0800
Message-ID: <AANLkTinU_HjzlgYCuvd3q0v4LD3uS6e1PUSFxfmkkeWf@mail.gmail.com>
Subject: Re: Ask help:why my 64-bit ELF file could not run at the 64-bit mips 
        cpu
From:   Dominic <dominicwj@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dominicwj@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dominicwj@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I am trying to understand the boot process of Linux Kernel, especially
on MIPS, I am pretty new to these. Could anybody introduce some
documents or the boot logs on some MIPS platform? Any reply is much
appreciated!

Thank you!

BR/Dominic
