Received:  by oss.sgi.com id <S553646AbRBHU3i>;
	Thu, 8 Feb 2001 12:29:38 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:14331 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553651AbRBHU3L>;
	Thu, 8 Feb 2001 12:29:11 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f18KPR829704;
	Thu, 8 Feb 2001 12:25:27 -0800
Message-ID: <3A830135.B1304041@mvista.com>
Date:   Thu, 08 Feb 2001 12:27:33 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: config option vs. run-time detection (the debate continues ...)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I love this topic!

Instead of replying to 10 different emails, I decide to sort out my best
understanding of this topic and list them here, including some of MY responses
to some of the issues.

Definition:
------------

1. Config option approach :

	In the kernel config menu, one picks one or more CPUs.  One also specifies
whether the CPU(s) have a FPU.

	All FPU related code in kernel is configured in or out based on the CONFIG
setting.

2. run-time detection approach:

	CPU probing code probes CPU and sets has_fpu field in the mips_cpu structure.

	All FPU related code is on a conditional branch based on has_fpu value.


Run-time Detection Approach
---------------------------

Plus:
	. the same kernel image can run on CPUs either with or without a FPU.

Minus:
	. run-time overhead
		a) cpu detection
		b) conditional checking for FPU related code
	. extra code size (FPU detection and conditional branch for FPU related code)
	. do we have a reliable detection method without any help from CONFIG (I am
not 100% sure here)


Config Option Approach
----------------------

Plus:
	. The reverse of the minus for run-time detection approach

Minus:
	. The same kernel image cannot run on CPUs both with and without a FPU.


My Conclusion
--------------

Clearly, it is a trade-off decision based how much one values the minuses and
pluses of both approaches.

While I do agree the minus for run-time detection are not serious ones, I
think the minus for config option is even less serious.  Having the same
kernel image runs on multiple CPUs is very nice.  I just doubt about the
usefulness of requiring the same kernel image to run on CPUs both with a FPU
and without a FPU.  Therefore in the light of minus of the run-time detection
approach, I still favor config option.

(aha, I proved my intuition. It is a theory now. :-0)

Jun
