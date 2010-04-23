Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2010 07:59:12 +0200 (CEST)
Received: from mail-bw0-f226.google.com ([209.85.218.226]:42424 "EHLO
        mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491190Ab0DWF65 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Apr 2010 07:58:57 +0200
Received: by bwz26 with SMTP id 26so9268673bwz.27
        for <linux-mips@linux-mips.org>; Thu, 22 Apr 2010 22:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5BIZ2B/mUmw9WPikzDppICX00EpYQ9eZ/U3B32KHZeQ=;
        b=WmAL92zUibfQeMF3WevHdDCOPgCPUxxm6VqqDvKmGEP0MJXP6tXNrJfyMldyIkj8l/
         uZQKZt9+M/EgwEvZRmWzrmfEe97eoRcCutYWsqVrz+jZ1DllcHCC8iyQmHX+qI+ZK05W
         rcUrDt2MSz4iFQW5G8vjLZ7cZNagwTc//IpAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q7FoU+uPCG3nFy1uJVcZpdv/LeaBg7I2tXBZ1H2dkY9laOqaFYY8QhUzBdnkGiu9Dc
         EPKrKX/cNVudND1B1xdMmlOKetCjbZpxpE2fLp6CQpK9hDUQHPPEv/kdxPHZ3vNh7Qih
         YkXZfkimWTNJ2yK5Nve5sdK75akjRvig9nV6w=
MIME-Version: 1.0
Received: by 10.223.106.12 with HTTP; Thu, 22 Apr 2010 22:58:51 -0700 (PDT)
In-Reply-To: <5858DE952C53A441BDA3408A0524130104CCE08F@mkegmal01>
References: <5858DE952C53A441BDA3408A0524130104CCE08F@mkegmal01>
Date:   Fri, 23 Apr 2010 07:58:51 +0200
Received: by 10.103.82.17 with SMTP id j17mr2795819mul.101.1272002331954; Thu, 
        22 Apr 2010 22:58:51 -0700 (PDT)
Message-ID: <l2uf861ec6f1004222258tc07032az966b174ebd94e92d@mail.gmail.com>
Subject: Re: Porting U-boot on MIPS (Au1350)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Gurumurthy G M <Gurumurthy.Gowdar@gmobis.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

>       we are porting U-boot 1.2.0 to MIPS32 Au1350 Processor. i am using ELDK 4.1 for MIPS32.
>
> We have a MIPS CPU which has reset address 0xBFC00000 , this is mapped to NOR flash with XIP in place. The boot block  ( ie 0xBFC00000) is in the top block of the NOR flash and its of 16KB. U-Boot shall be put from address 0xBFC00000 in the NOR flash for CPU boot up , since it is the last block (16KB only) we cannot put complete U-Boot , some part of the U-Boot should go to lower blocks . To do this u-boot need to be divided into blocks and we shall provide a jump from the top block to other blocks of NOR flash. We have BDI3000 debugger for flashing the NOR flash and bdiGDB for MIPS.
>
> Is there any NOR flash drivers available which can support the below chip?
>
> NOR Flash chip : M29W160ET --> AM29BX16
> NOR Flash chip size is 0x00200000 --> 2MB

I believe you need to change CS0# decoded range (staddr0 reg) very
early to enable
access to the whole chip.  Put init code at bfc00000, and let it load
the main bootloader
binary from a predefined ROM address to a predefined RAM address and execute.

Manuel
