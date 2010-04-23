Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2010 10:42:36 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:36468 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491789Ab0DWImd convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Apr 2010 10:42:33 +0200
Received: by vws3 with SMTP id 3so2520826vws.36
        for <linux-mips@linux-mips.org>; Fri, 23 Apr 2010 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cwDs8pWyFY8KS2MrengUkITzIHs9dMYf3DhN2CMUlC4=;
        b=hw7cb85/phUKHH4PaPQnCICDsUMMRcn0lOuJxlCZ3CsJHxSBUwC6q7dd68jz64AFFP
         n/iK6tm80EZmADoG4l5VA2ZuXMNSrm3dY23pj2PurbCGic3XpmBIoLn9bjiswg0q84Ck
         6f79ZSOFtwBYGVZbcqEQ/xdXmUHVXWzOXMzhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oHllwcoLpypBiTMM88E3HF4p2p4+uNFkePAxx9wmNkwlriZ/tALmaF2jSBHm+LUUzu
         UkMDRltfNF64NBeJCRiLX3IGTIKD2QvGqfN7kmCZaH3kzdrX25W4kmf1w0gB/8P+JaDJ
         DzTJB5QJayfwSayNwaE3QfmN/lmfHYVDnuvJs=
MIME-Version: 1.0
Received: by 10.220.17.141 with HTTP; Fri, 23 Apr 2010 01:42:26 -0700 (PDT)
In-Reply-To: <4BD08329.80804@adax.com>
References: <j2sdf5e30c51004172251z9fd01867h562b99c1f1044c26@mail.gmail.com>
         <q2odf5e30c51004220901l8bfa979ftc9c6a7b633569460@mail.gmail.com>
         <4BD08329.80804@adax.com>
Date:   Fri, 23 Apr 2010 16:42:26 +0800
Received: by 10.220.157.206 with SMTP id c14mr7627121vcx.110.1272012146792; 
        Fri, 23 Apr 2010 01:42:26 -0700 (PDT)
Message-ID: <h2hdf5e30c51004230142q21184429pffcaa9351510bc2d@mail.gmail.com>
Subject: Re: Ask help:why my 64-bit ELF file could not run at the 64-bit mips 
        cpu
From:   Dominic <dominicwj@gmail.com>
To:     Jan Rovins <janr@adax.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dominicwj@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dominicwj@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Jan,

Thanks a lot for your precious reply! I try to use -static to compile
the program, then the 64-bit program can run, so it should be the
library related other than 64-bit instruction or addressing related.
Then I stored the 64-bit libraries in nfs, and mount it on the target
board, after adding the path to ld.so.conf and 'ldconfig', the program
compiled without -static still does not run. Shall I miss something?

Thanks!
BR/Dominic


On Fri, Apr 23, 2010 at 1:11 AM, Jan Rovins <janr@adax.com> wrote:
> Jian Wang wrote:
>>
>> Hi,
>>
>>  I have a 64-bit mips cpu, and compiled a 64-bit application, but this
>>  application could not run. (the target is running Linux)
>>  The details is:
>>  1)if I compile the application with -mabi=n64, this program could not
>>  run, when I run it in the shell, it prompts "command not found"
>>  2)but if I compile the application with -mabi=n32, it runs well and
>>  gives the correct result.
>>
>>  I am wondering why with "-mabi=n64", this program could not run? I
>>  checked the CP0(status register), Bit px=0b0, KX=0b1, SX=0b1, UX=0b1,
>>  it seems that in User Mode, it accepts 64-bit operation.
>>
>>  Anybody could give me some help? Any comments is much appreciated!!
>>
>>  BR/Dominic
>>
>>
>
> Perhaps you do not have the "n64" system libraries set up correctly in
> userspace.
> I have seen the "command not found" error when some fundamental libraries or
> the loader was missing.
>
> Do you have a /lib64 & /user/lib64?
> Run the file command on some of those libraries & see if they are n64 or n32
> libs.
>
> double check your ld.so.conf to make sure it points to every thing you need.
> re run ldconfig if you change something.
>
>
> Jan
>
>
