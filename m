Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Oct 2002 00:07:07 +0200 (CEST)
Received: from mms3.broadcom.com ([63.70.210.38]:63505 "HELO mms3.broadcom.com")
	by linux-mips.org with SMTP id <S1123253AbSJDWHG>;
	Sat, 5 Oct 2002 00:07:06 +0200
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS-3 SMTP Relay (MMS v4.7);); Fri, 04 Oct 2002 15:06:29 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id PAA00429 for <linux-mips@linux-mips.org>; Fri, 4 Oct 2002 15:06:29
 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 g94M6NER016770 for <linux-mips@linux-mips.org>; Fri, 4 Oct 2002 15:06:
 28 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id PAA06214 for
 <linux-mips@linux-mips.org>; Fri, 4 Oct 2002 15:06:23 -0700
Message-ID: <3D9E10DF.C4C305B2@broadcom.com>
Date: Fri, 04 Oct 2002 15:06:23 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: do_ri and EPC adjustment
X-WSS-ID: 1180CF6F74208-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

Sorry if this has already been discussed, but why does do_ri() adjust
the EPC in compute_return_epc() before delivering the SIGILL to a user
process?

Kip
