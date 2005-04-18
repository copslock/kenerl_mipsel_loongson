Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2005 10:45:46 +0100 (BST)
Received: from mail.ultranet.ru ([IPv6:::ffff:213.33.170.34]:36528 "EHLO
	mail.ultranet.ru") by linux-mips.org with ESMTP id <S8225477AbVDRJpb>;
	Mon, 18 Apr 2005 10:45:31 +0100
Received: from [194.154.83.194] ([194.154.83.194] verified)
  by mail.ultranet.ru (CommuniGate Pro SMTP 4.2.9)
  with ESMTP id 24748302; Mon, 18 Apr 2005 13:30:57 +0400
Date:	Mon, 18 Apr 2005 13:32:46 +0400
From:	Pavel Kiryukhin <vksavl@cityline.ru>
X-Mailer: The Bat! (v2.10) UNREG / CD5BF9353B3B7091
Reply-To: Pavel Kiryukhin <vksavl@cityline.ru>
X-Priority: 3 (Normal)
Message-ID: <1807918959.20050418133246@cityline.ru>
To:	linux-mips@linux-mips.org
CC:	Manish Lachwani <mlachwani@mvista.com>
Subject: Preemption in do_cpu      (Re: [PATCH]Preemption patch for 2.6)
In-Reply-To: <1098468403.4266.42.camel@prometheus.mvista.com>
References: <1098468403.4266.42.camel@prometheus.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=Windows-1251
Content-Transfer-Encoding: 8bit
Return-Path: <vksavl@cityline.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vksavl@cityline.ru
Precedence: bulk
X-list: linux-mips

Hi,
the preempt_disable/preempt_enable sequence in do_cpu() [traps.c]
exists quite long (patch submitted in Oct. 2004), so it should be nothing
wrong there.

Can somebody please comment why use of preempt_disable/enable in do_cpu
will not result in "scheduling while atomic" for fpu-less cpu (with enabled
preemption).

The sequence looks like

do_cpu()
| preempt_disable()
| fpu_emulator_cop1Handler()
| | cond_reshed()
| | | schedule()  <------ scheduling while atomic


The proposed patch was tested for Sibyte, but it has fpu (AFAIK) and has no
fpu_emulator_cop1Handler called.

--
Thank you,
Pavel Kiryukhin                   mailto:vksavl@cityline.ru



Friday, October 22, 2004, 10:06:43 PM, you wrote:

ML> Hello !

ML> The attached patch incorporates preemption enable/disable in some parts
ML> of the kernel. I have tested this on the Broadcom Sibyte. Please review
ML> ...

ML> Thanks
ML> Manish Lachwani


<skip>

ML> Index: linux-2.6.8.1/arch/mips/kernel/traps.c
ML> ===================================================================
ML> --- linux-2.6.8.1.orig/arch/mips/kernel/traps.c
ML> +++ linux-2.6.8.1/arch/mips/kernel/traps.c

<skip>

ML>  case 1:
ML> +preempt_disable();
ML> +
ML>  own_fpu();
ML>  if (current->used_math) {	/* Using the FPU again.  */
ML>  restore_fp(current);
ML> @@ -674,6 +690,8 @@
ML>  force_sig(sig, current);
ML>  }
 
ML> +preempt_enable();
ML> +
ML>  return;
 
ML>  case 2:

<skip>
