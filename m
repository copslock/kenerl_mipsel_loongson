Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2006 11:07:46 +0000 (GMT)
Received: from wx-out-0506.google.com ([66.249.82.235]:971 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038878AbWLMLHm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 13 Dec 2006 11:07:42 +0000
Received: by wx-out-0506.google.com with SMTP id t14so136405wxc
        for <linux-mips@linux-mips.org>; Wed, 13 Dec 2006 03:07:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E/DxvkccEbnZOcJzbxEt4biowBc+bPorGt5zGTGsasSERaZfvxHj+hjkOtb2PC1j2bljGEwz0WRE/7v+BALwVm6K+zFblsH7HbtN1WbHukQj0Wih4vrPIRgwJm6e6seRlrVxo3sWHViN+TiAyneKxl0bKiGscdxcHvysgwY32IE=
Received: by 10.90.103.2 with SMTP id a2mr427497agc.1166008060590;
        Wed, 13 Dec 2006 03:07:40 -0800 (PST)
Received: by 10.90.101.14 with HTTP; Wed, 13 Dec 2006 03:07:40 -0800 (PST)
Message-ID: <b647ffbd0612130307q4ea221d0l3daf34ef0048abcb@mail.gmail.com>
Date:	Wed, 13 Dec 2006 12:07:40 +0100
From:	"Dmitry Adamushko" <dmitry.adamushko@gmail.com>
To:	linux-mips@linux-mips.org
Subject: unwind_stack() and an exception at the last instruction (after the epilogue)
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Dmitry Adamushko" <dmitry.adamushko@gmail.com>
In-Reply-To: <b647ffbd0612121342y5b188be0o5ccce1b2c57a9725@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b647ffbd0612121342y5b188be0o5ccce1b2c57a9725@mail.gmail.com>
Return-Path: <dmitry.adamushko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.adamushko@gmail.com
Precedence: bulk
X-list: linux-mips

[ resend: probably, my previouse one had been rejected as it was not
in plain-text :]


 Hello,

 unwind_stack() explicitly handles a case when an exception takes
place at the first instruction, i.e. before the prologue.

 But what's about another corner case - when an exception is caused by
an instruction placed after the epilogue.

 example:

 00400e8c <cause_oops>:
   400e8c:       3c1c0fc0        lui     gp,0xfc0
   400e90:       279c71c4        addiu   gp,gp,29124
   400e94:       0399e021        addu    gp,gp,t9
   400e98:       27bdffe0        addiu   sp,sp,-32
   400e9c:       afbf0018        sw      ra,24(sp)
   400ea0:       afbc0010        sw      gp,16(sp)
   400ea4:       8f84801c        lw      a0,-32740(gp)
   400ea8:       8f9980ac        lw      t9,-32596(gp)
   400eac:       00000000        nop
   400eb0:       0320f809        jalr    t9
   400eb4:       24841984        addiu   a0,a0,6532
   400eb8:       8fbc0010        lw      gp,16(sp)
   400ebc:       8fbf0018        lw      ra,24(sp)
   400ec0:       27bd0020        addiu   sp,sp,32
   400ec4:       03e00008        jr      ra
   400ec8:       ac000000        sw      zero,0(zero)
<----------- <epc> will be here when an exception happens


 In this case, <sp> already points to the caller's stack frame so
unwind_stack() will take a wrong assumption (as it looks at the
epilogue of the callee).

 btw, the first and last instructions are just corner cases of an
instruction being placed before the prologue and after the epilogue,
right?

 so something like

 - if (unlikely(ofs == 0)) {
 + if (unlikely(offs == 0 || offs == size - sizeof_mips_instruction))
         pc = *ra;
         *ra = 0;
         return pc;
 }

 won't be a generic solution.

 Did I miss something? Hm... <epc> is always guaranted to be right
when the instruction is in the branch delay slot?

 p.s. yep, the example is a part of user-space code (optimization:
-Os) or is there anything (compiler options etc.) preventing similar
code from being generated for kernel-space code?


Thanks in advance for any comments.


-- 
Best regards,
Dmitry Adamushko
