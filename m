Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 15:28:02 +0000 (GMT)
Received: from mms1.broadcom.com ([IPv6:::ffff:63.70.210.58]:48395 "EHLO
	mms1.broadcom.com") by linux-mips.org with ESMTP
	id <S8225203AbTCGP2B>; Fri, 7 Mar 2003 15:28:01 +0000
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.0)); Fri, 07 Mar 2003 07:27:35 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id HAA18732; Fri, 7 Mar 2003 07:27:39 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 h27FRoER004876; Fri, 7 Mar 2003 07:27:50 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id HAA15923; Fri, 7
 Mar 2003 07:27:50 -0800
Message-ID: <3E68BA76.2A54D7CF@broadcom.com>
Date: Fri, 07 Mar 2003 07:27:50 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Juan Quintela" <quintela@mandrakesoft.com>
cc: linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] add CONFIG_DEBUG_INFO
References: <20030220113404.E7466@mvista.com>
 <3E63B047.D3BA2A2C@broadcom.com> <86d6l8fcvv.fsf@trasno.mitica>
 <3E677B94.AE22C65D@broadcom.com> <86u1efp9rr.fsf@trasno.mitica>
X-WSS-ID: 127665ED1214491-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

> I have no idea what the Corelis debugger is, but I assume that putting
> it configuration out of the CONFIG_KGDB is intentional?  It doesn't
> require the -g option?

Yes -- the patch didn't include it, but the Corelis option will depend
on DEBUG_INFO.  I just thought removing the nested ifdef was more
attractive, and have the configure magic deal with the dependence.
