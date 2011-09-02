Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2011 09:59:24 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:58683 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490992Ab1IBH7U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2011 09:59:20 +0200
Received: by fxd20 with SMTP id 20so1798038fxd.36
        for <linux-mips@linux-mips.org>; Fri, 02 Sep 2011 00:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=mHqstqRTAWTzu2fjAbDGWwiw6Sw8P1gx3cnBNZF0tbg=;
        b=Q12WRuL1ohCS/mK+ejUIJphhZab4e/gdJx219eAcW4ZzXGsEa/gCqHksZUwSXMEKDC
         rV0GkfuMfY8/P9j1sYQ/oCSxg7XKXISB6l43hpwl4c7D6/GA4XWGxY5C+ktzYAhygJd5
         qIMX46CokCWT/xsWpABA6B2rfZNLHo5hxCwg0=
MIME-Version: 1.0
Received: by 10.223.87.204 with SMTP id x12mr1303121fal.27.1314950354931; Fri,
 02 Sep 2011 00:59:14 -0700 (PDT)
Received: by 10.223.83.203 with HTTP; Fri, 2 Sep 2011 00:59:14 -0700 (PDT)
Date:   Fri, 2 Sep 2011 13:29:14 +0530
Message-ID: <CAFsuBjWNqi_eE=_1OCFbM5sNdf-46jOfV3Kkk7gCLXifK=_J9g@mail.gmail.com>
Subject: MIPS:Octeon: mailbox_interrupt is not registered as per cpu
From:   SAURABH MALPANI <saurabh140585@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=001517447e8ecd907804abf0bc78
X-archive-position: 31028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: saurabh140585@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1103

--001517447e8ecd907804abf0bc78
Content-Type: text/plain; charset=UTF-8

mailbox_interrupt is not registered with IRQF_PERCPU but it is supposed to
be percpu interrupt. Is that on purpose or a miss? I am porting some code
from x86 to octeon which requires special handling for per cpu interrupts.

void octeon_prepare_cpus(unsigned int max_cpus)
{
        cvmx_write_csr(CVMX_CIU_MBOX_CLRX(cvmx_get_core_num()), 0xffffffff);
        if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt, IRQF_DISABLED,
                        "mailbox0", mailbox_interrupt)) {
                panic("Cannot request_irq(OCTEON_IRQ_MBOX0)\n");
        }
        if (request_irq(OCTEON_IRQ_MBOX1, mailbox_interrupt, IRQF_DISABLED,
                        "mailbox1", mailbox_interrupt)) {
                panic("Cannot request_irq(OCTEON_IRQ_MBOX1)\n");
        }
}


-- 
Saurabh

--001517447e8ecd907804abf0bc78
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

mailbox_interrupt is not registered with IRQF_PERCPU but it is supposed to =
be percpu interrupt. Is that on purpose or a miss? I am porting some code f=
rom x86 to octeon which requires special handling for per cpu interrupts.=
=C2=A0<div>
<br></div><div><div>void octeon_prepare_cpus(unsigned int max_cpus)</div><d=
iv>{</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 cvmx_write_csr(CVMX_CIU_MBOX_CLR=
X(cvmx_get_core_num()), 0xffffffff);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt, IRQF_DISABLED,</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &quot;mailbox0&quot;, mailbox_interrupt)) {</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 panic(&quot;Cannot request=
_irq(OCTEON_IRQ_MBOX0)\n&quot;);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (request_irq(OCTEON_IRQ_MBOX1, mailb=
ox_interrupt, IRQF_DISABLED,</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &quot;mailbox1&quot;, mailbox_interrupt)) {</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 panic(&quot;Cannot request=
_irq(OCTEON_IRQ_MBOX1)\n&quot;);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</d=
iv><div>}</div><div><br></div><div><br></div>
-- <br>Saurabh <br>
</div>

--001517447e8ecd907804abf0bc78--
