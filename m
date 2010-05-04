Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 15:05:35 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:62450 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492181Ab0EDM4P convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 May 2010 14:56:15 +0200
Received: by vws8 with SMTP id 8so1025034vws.36
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=haJAor6uk6i7dggpbjKmgukAwtf3Iy9KXCovjQg42ls=;
        b=V6J6LJ0soxkWKU8gebSGQiGo5LEtR8esPmjyo3Nh102XGxRK22C7DQKNSbxfIg9LYA
         8RUq9lcWBReG1sRjOK0UiYfgKU1MH8U7CVRW1MxYplVcAbRQ07c8r8VsND0g+qz/KGJI
         FsgbR79aaG4Qlih5i9sTOcsfm78J/sDf5x0Ns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gZg2gC/jZE5klrKMVd5OhEE8hF6YORKts4BaY5JdWpcD5LbllylGwovYOhBTdZDhdF
         sAaKdamlqSOZu9v0gXDFdpadyNrMpCa3i/ZHj31P9CaxE+/CnA4EWHI7ncjpoPiRIWpc
         +CV5t4oAAf+wYkRFUL4aVBZwz4K782VLLCRSA=
MIME-Version: 1.0
Received: by 10.220.124.84 with SMTP id t20mr5460611vcr.114.1272977768698; 
        Tue, 04 May 2010 05:56:08 -0700 (PDT)
Received: by 10.220.19.212 with HTTP; Tue, 4 May 2010 05:56:08 -0700 (PDT)
In-Reply-To: <4BE00207.6030506@paralogos.com>
References: <E1O8lDn-0000Sk-86@localhost> <4BDF366E.5000501@paralogos.com>
         <k2hb2b2f2321005031843l87f39f36h960153cae3ec5020@mail.gmail.com>
         <4BDF8092.1060401@paralogos.com>
         <n2pb2b2f2321005032049h56cd72ceh3ac7120c547b59c5@mail.gmail.com>
         <n2rb2b2f2321005032135ze807a2aft8811a7937288de53@mail.gmail.com>
         <m2rb2b2f2321005032356j854934d9v42a9e50683b085a8@mail.gmail.com>
         <4BE00207.6030506@paralogos.com>
Date:   Tue, 4 May 2010 06:56:08 -0600
Message-ID: <m2zb2b2f2321005040556g80eed954p7ac11e2cd05921c6@mail.gmail.com>
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
X-archive-position: 26579
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, May 4, 2010 at 5:16 AM, Kevin D. Kissell <kevink@paralogos.com> wrote:
> Shane McDonald wrote:
>> When I'm inside my handler, I see the FCSR register has the value 0x8420,
>> indicating that the Z bit is set in each of the Cause, Enables, and Flags
>> fields.  When longjmp() is called, it tries to write the old FCSR value
>> of 0x400 (just the Z bit of the Enables field).  In the emulation code,
>> at lines 392 - 394 of file cp1emu.c, is the code:
>>
>>     if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
>>             return SIGFPE;
>>     }
>>
>> Given the original FCSR value of 0x8420 and the new value to set
>> of 0x400, the Z bit of the Cause field is still set, and as a result, the
>> above code causes the SIGFPE exception to be thrown.
>>
> That's not how I read the code.  If ctx->fcr31 is 0x400, then the result
> of the AND should be zero.

Sorry, I should have been more clear.

In the following chunk of code from cp1emu.c:

                case ctc_op:{
                        /* copregister rd <- rt */
                        u32 value;

                        if (MIPSInst_RT(ir) == 0)
                                value = 0;
                        else
                                value = xcp->regs[MIPSInst_RT(ir)];

                        /* we only have one writable control reg
                         */
                        if (MIPSInst_RD(ir) == FPCREG_CSR) {
#ifdef CSRTRACE
                                printk("%p gpr[%d]->csr=%08x\n",
                                        (void *) (xcp->cp0_epc),
                                        MIPSInst_RT(ir), value);
#endif
                                value &= (FPU_CSR_FLUSH |
FPU_CSR_ALL_E | FPU_CSR_ALL_S | 0x03);
                                ctx->fcr31 &= ~(FPU_CSR_FLUSH |
FPU_CSR_ALL_E | FPU_CSR_ALL_S | 0x03);
                                /* convert to ieee library modes */
                                ctx->fcr31 |= (value & ~0x3) |
ieee_rm[value & 0x3];
                        }
                        if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {
                                return SIGFPE;
                        }
                        break;

value gets set to an initial value of 0x400, and ctx->fcr31
comes in with an initial value of 0x8420.
By the time we hit the if statement around the return SIGFPE, ctx->fcr31
has been set to 0x8400, not the 0x400 I implied.

Nevertheless, that's not the problem.  You've given me some good pointers
for where to begin searching for the problem.

If anyone out there has a verification suite they can run on the emulator,
that would be much appreciated!

Shane
