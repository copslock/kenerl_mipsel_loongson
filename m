Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Apr 2010 14:01:06 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:61200 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492475Ab0DZMBD convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Apr 2010 14:01:03 +0200
Received: by vws16 with SMTP id 16so186958vws.36
        for <linux-mips@linux-mips.org>; Mon, 26 Apr 2010 05:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OprkUIdpGXVj/LWoT8hEHruiI5xdaQRCUUAutyscCEA=;
        b=BiPTgTRHxOo1grIje5He7qWKosCfTKECb8gcSExcZXPRbnFBOV22a+6bQX6l3DR4gR
         Ht9NwDKN4stsart3l/Ytcq5chgZViKyOzwBFJod4oRK7vPmsAT4nMHWkcT4VeDJ7k9Hi
         vJfS98bg6s9FZ3ts8GDdBBSZO+/lrtw5/uvSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q9CnTF5g3n+X5NLUGTUjIGaHbyICy1RVLRT1kcK97QwFe4yygFZqnLGk6SGOLGiiyh
         4JR9bSt2SZhtR7XIKc3sEIiNil11f3S9U6y48lUdU4K9Zu5mJoQGMHOfsLDwJTD4WZQm
         UbuJL83danQCPHou11mAGWz7XAXKwaiEydZFI=
MIME-Version: 1.0
Received: by 10.220.124.210 with SMTP id v18mr2693094vcr.106.1272283255638; 
        Mon, 26 Apr 2010 05:00:55 -0700 (PDT)
Received: by 10.220.17.141 with HTTP; Mon, 26 Apr 2010 05:00:51 -0700 (PDT)
In-Reply-To: <v568a7-oj5.ln1@chipmunk.wormnet.eu>
References: <j2sdf5e30c51004172251z9fd01867h562b99c1f1044c26@mail.gmail.com>
         <q2odf5e30c51004220901l8bfa979ftc9c6a7b633569460@mail.gmail.com>
         <4BD08329.80804@adax.com>
         <h2hdf5e30c51004230142q21184429pffcaa9351510bc2d@mail.gmail.com>
         <v568a7-oj5.ln1@chipmunk.wormnet.eu>
Date:   Mon, 26 Apr 2010 20:00:51 +0800
Message-ID: <q2xdf5e30c51004260500t15cc000g3391808fed24fb95@mail.gmail.com>
Subject: Re: Ask help:why my 64-bit ELF file could not run at the 64-bit mips 
        cpu
From:   Dominic <dominicwj@gmail.com>
To:     Alexander Clouter <alex@digriz.org.uk>, Jan Rovins <janr@adax.com>,
        geert@linux-m68k.org
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dominicwj@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dominicwj@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Alexander, Jan & Greet

Much thanks for your advice, I have solve this problem, thanks a lot!

BR/Dominic

On Fri, Apr 23, 2010 at 5:34 PM, Alexander Clouter <alex@digriz.org.uk> wrote:
> Dominic <dominicwj@gmail.com> wrote:
>>
>> Thanks a lot for your precious reply! I try to use -static to compile
>> the program, then the 64-bit program can run, so it should be the
>> library related other than 64-bit instruction or addressing related.
>> Then I stored the 64-bit libraries in nfs, and mount it on the target
>> board, after adding the path to ld.so.conf and 'ldconfig', the program
>> compiled without -static still does not run. Shall I miss something?
>>
> On your host, you can type something like:
> ----
> alex@berk:/usr/src/wag54g$ readelf -d buildroot/output/target/usr/sbin/ip6tables-multi  | grep Shared
>  0x00000001 (NEEDED)                     Shared library: [libip6tc.so.0]
>  0x00000001 (NEEDED)                     Shared library: [libxtables.so.4]
>  0x00000001 (NEEDED)                     Shared library: [libdl.so.0]
>  0x00000001 (NEEDED)                     Shared library: [libm.so.0]
>  0x00000001 (NEEDED)                     Shared library: [libc.so.0]
> ----
>
> This will list all the libraries that you need installed[1], I'm guessin
> you have missed one.
>
> You can look at the output of 'readelf -a' to try to see what might be
> missing.
>
> Cheers
>
> [1] in addition to the interpreter required (for example 'ld-uClibc')
>        and the main C library being used:
>        readelf -l buildroot/output/target/usr/sbin/ip6tables-multi
>
> --
> Alexander Clouter
> .sigmonster says: "Ninety percent of baseball is half mental."
>                                -- Yogi Berra
>
>
>
