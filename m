Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2004 16:42:16 +0000 (GMT)
Received: from mms3.broadcom.com ([IPv6:::ffff:63.70.210.38]:28935 "EHLO
	mms3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225229AbUCQQmP>; Wed, 17 Mar 2004 16:42:15 +0000
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.6.0)); Wed, 17 Mar 2004 08:41:56 -0800
X-Server-Uuid: 8D569F9F-42CF-4602-970D-AACC4BD5D310
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id IAA17356; Wed, 17 Mar 2004 08:41:15 -0800 (PST)
Received: from ldt-sj3-010.sj.broadcom.com (ldt-sj3-010 [10.21.64.10])
 by mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 i2HGfmov012103; Wed, 17 Mar 2004 08:41:48 -0800 (PST)
Received: (from cgd@localhost) by ldt-sj3-010.sj.broadcom.com (
 8.11.6/8.9.3) id i2HGfm112569; Wed, 17 Mar 2004 08:41:48 -0800
X-Authentication-Warning: ldt-sj3-010.sj.broadcom.com: cgd set sender to
 cgd@broadcom.com using -f
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "Eric Christopher" <echristo@redhat.com>, linux-mips@linux-mips.org
Subject: Re: gcc support for mips32 release 2]
References: <1078525778.3353.2.camel@dzur.sfbay.redhat.com>
 <Pine.LNX.4.55.0403171714410.14525@jurand.ds.pg.gda.pl>
From: cgd@broadcom.com
Date: 17 Mar 2004 08:41:47 -0800
In-Reply-To: <Pine.LNX.4.55.0403171714410.14525@jurand.ds.pg.gda.pl>
Message-ID: <yov5ish3zar8.fsf@ldt-sj3-010.sj.broadcom.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
X-WSS-ID: 6C46A05E1NC6530244-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <cgd@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cgd@broadcom.com
Precedence: bulk
X-list: linux-mips

At Wed, 17 Mar 2004 17:18:37 +0100 (CET), Maciej W. Rozycki wrote:
>  Well, I think this can be handled by creating an artificial processor
> entry (e.g. "PROCESSOR_MIPS64R2" in this case) and replacing it with a
> real one once an implementation is publicly available.

yeah.  doing that, but introducing known "to be removed" code bugs me.

it's probably better than not getting the rest of the infrastructure
in, though.


cgd
