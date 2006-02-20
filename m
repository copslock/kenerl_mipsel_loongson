Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 14:30:53 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:46297 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133764AbWBTOan
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 14:30:43 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k1KEbTXI020267;
	Mon, 20 Feb 2006 06:37:30 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with SMTP id k1KEbS89018765;
	Mon, 20 Feb 2006 06:37:29 -0800 (PST)
Message-ID: <001d01c6362b$8af89b80$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Kevin D. Kissell" <kevink@mips.com>,
	"Rojhalat Ibrahim" <imr@rtschenk.de>
Cc:	"Mark E Mason" <mark.e.mason@broadcom.com>,
	<linux-mips@linux-mips.org>
References: <7E000E7F06B05C49BDBB769ADAF44D0773A636@NT-SJCA-0750.brcm.ad.broadcom.com> <43F9B168.6090105@rtschenk.de> <43F9C58E.4020606@mips.com>
Subject: Re: Tracking down exception in sched.c
Date:	Mon, 20 Feb 2006 15:40:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

>... if your phys_cpu_present_map
> (which is by default what gets used in MIPS as cpu_possible_map
> for the purposes of sched.c) is being properly initialized and
> maintained, the behavior of the two loops should be the same.
> Have you double-checked that?  Secondary CPUs turn generally
> set their bits in that mask in prom_build_cpu_map().

Correction.  I misremembered this.  prom_build_cpu_map()
is called only by the primary/boot CPU, prior to SMP initialization.
It's still the place where phys_cpu_present gets set up, but it
can't be set up by the secondaries.

            Regards,

            Kevin K.
