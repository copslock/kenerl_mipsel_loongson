Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6UJPmRw001467
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Jul 2002 12:25:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6UJPmcu001466
	for linux-mips-outgoing; Tue, 30 Jul 2002 12:25:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms3.broadcom.com (mms3.broadcom.com [63.70.210.38])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6UJPhRw001451
	for <linux-mips@oss.sgi.com>; Tue, 30 Jul 2002 12:25:44 -0700
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS-3 SMTP Relay (MMS v4.7)); Tue, 30 Jul 2002 12:27:09 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id MAA26966; Tue, 30 Jul 2002 12:27:09 -0700 (PDT)
Received: from dt-sj3-118.sj.broadcom.com (dt-sj3-118 [10.21.64.118]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 g6UJR9ER028048; Tue, 30 Jul 2002 12:27:09 -0700 (PDT)
Received: (from cgd@localhost) by dt-sj3-118.sj.broadcom.com (
 8.9.1/SJ8.9.1) id MAA22536; Tue, 30 Jul 2002 12:27:08 -0700 (PDT)
To: dant@mips.com
cc: "Carsten Langgaard" <carstenl@mips.com>, hjl@lucon.org,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com,
   binutils@sources.redhat.com
Subject: Re: PATCH: Update E_MIP_ARCH_XXX (Re: [patch] linux: RFC:
 elf_check_arch() rework)
References: <3D44F31D.55155E24@mips.com>
 <Pine.LNX.4.44.0207301606350.31951-100000@coplin18.mips.com>
 <mailpost.1028038253.3155@news-sj1-1> <yov5n0s9koo6.fsf@broadcom.com>
From: cgd@broadcom.com
Date: 30 Jul 2002 12:27:08 -0700
In-Reply-To: cgd@broadcom.com's message of "30 Jul 2002 12:20:57 -0700"
Message-ID: <yov5k7ndkodv.fsf@broadcom.com>
X-Mailer: Gnus v5.7/Emacs 20.4
MIME-Version: 1.0
X-WSS-ID: 115837071178017-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-3.7 required=5.0 tests=IN_REP_TO,NO_REAL_NAME,PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

At 30 Jul 2002 12:20:57 -0700, Chris G. Demetriou wrote:
> I've made an inquiry, and my understanding is that Cygnus/RedHat
> internally use the same values as the public tools
> (i.e. EF_MIPS_ARCH_MIPS32 == 5, ..._MIPS64 == 6).

Of course, i typo'd most of the names of the constants in my msg.  I
meant E_MIPS_ARCH_32, etc., obviously.  8-)



chris
