Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 17:48:38 +0000 (GMT)
Received: from mms2.broadcom.com ([IPv6:::ffff:63.70.210.59]:49412 "EHLO
	mms2.broadcom.com") by linux-mips.org with ESMTP
	id <S8225250AbTBTRsh>; Thu, 20 Feb 2003 17:48:37 +0000
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.0)); Thu, 20 Feb 2003 09:45:39 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id JAA06738; Thu, 20 Feb 2003 09:48:22 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 h1KHmUER017276; Thu, 20 Feb 2003 09:48:30 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id JAA22100; Thu,
 20 Feb 2003 09:48:30 -0800
Message-ID: <3E5514EE.C22C82D@broadcom.com>
Date: Thu, 20 Feb 2003 09:48:30 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [patch] Coalesce duplicated SiByte settings
References: <Pine.GSO.3.96.1030220183613.25777I-100000@delta.ds2.pg.gda.pl>
X-WSS-ID: 124BCBC91421539-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

"Maciej W. Rozycki" wrote:
> 
> Hello,
> 
>  There is quite a lot identical entries for SiByte board variations in the
> top-level architecture Makefiles.  They look confusing and I don't think
> they are necessary.  Following is a proposal to remove duplicated entries.
> OK?

Mmm, cool.  No objection here.  I think they'll continue to share the
subdirectories/code that they do now.

Kip
