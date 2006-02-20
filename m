Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 14:43:35 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:47321 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133769AbWBTOn1
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 14:43:27 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k1KEoGMt020320;
	Mon, 20 Feb 2006 06:50:16 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with SMTP id k1KEoE89018952;
	Mon, 20 Feb 2006 06:50:15 -0800 (PST)
Message-ID: <003c01c6362d$53ea4c90$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Rojhalat Ibrahim" <imr@rtschenk.de>
Cc:	"Mark E Mason" <mark.e.mason@broadcom.com>,
	<linux-mips@linux-mips.org>
References: <7E000E7F06B05C49BDBB769ADAF44D0773A636@NT-SJCA-0750.brcm.ad.broadcom.com> <43F9B168.6090105@rtschenk.de> <43F9C58E.4020606@mips.com> <43F9D215.3090506@rtschenk.de>
Subject: Re: Tracking down exception in sched.c
Date:	Mon, 20 Feb 2006 15:52:52 +0100
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
X-archive-position: 10568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> The behavior of the two loops is not the same because sched_init
> is called long before smp_prepare_cpus. Therefore for_each_cpu
> only loops once for CPU 0. I know this is not a great fix.
> I simply reverted the code to what's worked before.

It's certainly the code that I'm still using!  ;o)  So prom_build_cpu_map
needs to be called earlier (as in maybe from smp_prepare_boot_cpu?).
Either that, or each secondary needs to take responsibility for initializing 
its own run queue, but I find the thought of having the system up and
running SMP with some run queues not yet initialized makes me nervous.

        Regards,

        Kevin K.
