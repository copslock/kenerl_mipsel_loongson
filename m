Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2010 17:52:09 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:58449 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491019Ab0JPPwG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Oct 2010 17:52:06 +0200
Received: by pwi2 with SMTP id 2so596682pwi.36
        for <linux-mips@linux-mips.org>; Sat, 16 Oct 2010 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=J0uL34lTORjDmWyvZJwZAnt6cvyciwuwOklIaOq3eu4=;
        b=dJqDi1tYM4scUKap11oArOL5XlmAx+PUF8MQJfw+XSYJL4bL1d1/VUwFMV6FJfyUoS
         0uwoBwF/nzgf9zWDAKt+Sd5s27G4JB8mUWfweQyR3RMhh3Tctyb21Kdvr7Y5cyjULyJW
         StZ/XcyEZwpVKEKhzwbwD+pidkW8n6bWEQ1TM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nnvZ+ltuqcDGlriH0N/cDIwm9Uhyml8K+f4mEjBNk67yLIXmHHMh3ft12UWUPpX+Wf
         h/q+YS73t0Kr4UcNoVMOmlpkZfX170NQNaT0mcZnHaApcjy8vLloOapEX/13AHPyn06P
         BE0Oi9ow/TxzyLZpKdkxxQjBr63SrBZi8VE8c=
Received: by 10.142.226.1 with SMTP id y1mr1730731wfg.292.1287244319053;
        Sat, 16 Oct 2010 08:51:59 -0700 (PDT)
Received: from localhost (KD118154228076.ppp-bb.dion.ne.jp [118.154.228.76])
        by mx.google.com with ESMTPS id e14sm11876411wfg.8.2010.10.16.08.51.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 08:51:58 -0700 (PDT)
Date:   Sun, 17 Oct 2010 00:55:52 +0900
From:   Adam Jiang <jiang.adam@gmail.com>
To:     "wilbur.chan" <wilbur512@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Where is the definition of i_j macro ?
Message-ID: <20101016155552.GE23119@capricorn-x61>
References: <AANLkTik4BddKpVm0x4EpCKCdUff0L=XiYRjfhJaPmX23@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTik4BddKpVm0x4EpCKCdUff0L=XiYRjfhJaPmX23@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jiang.adam@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.adam@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, Oct 16, 2010 at 08:59:37PM +0800, wilbur.chan wrote:
> Hi all
> 
> I'm reading build_r4000_tlb_refill_handler , but found   some macro
> like i_j , i_beq undefined in  tlbex.c ( grep linux source code )
> 
Please dig into 

arch/mips/include/asm/uasm.h

You'd better try "make cscope" and use emacs with the cscope
database. It allows you to surfing the source code very fast.

Best regards,
/Adam
> 
>  Can anyone tell me where  they come from?  Thank you
> 
