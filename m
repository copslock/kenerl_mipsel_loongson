Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2004 16:19:36 +0100 (BST)
Received: from mms1.broadcom.com ([IPv6:::ffff:63.70.210.58]:29713 "EHLO
	mms1.broadcom.com") by linux-mips.org with ESMTP
	id <S8225009AbUGSPTb>; Mon, 19 Jul 2004 16:19:31 +0100
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.6.0)); Mon, 19 Jul 2004 08:19:18 -0700
X-Server-Uuid: 97B92932-364A-4474-92D6-5CFE9C59AD14
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id IAA19526; Mon, 19 Jul 2004 08:18:43 -0700 (PDT)
Received: from ldt-sj3-010.sj.broadcom.com (ldt-sj3-010 [10.21.64.10])
 by mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 i6JFJHov029224; Mon, 19 Jul 2004 08:19:17 -0700 (PDT)
Received: (from cgd@localhost) by ldt-sj3-010.sj.broadcom.com (
 8.11.6/8.9.3) id i6JFJHI03530; Mon, 19 Jul 2004 08:19:17 -0700
X-Authentication-Warning: ldt-sj3-010.sj.broadcom.com: cgd set sender to
 cgd@broadcom.com using -f
To: macro@linux-mips.org
cc: binutils@sources.redhat.com, ddaney@avtrex.com,
	linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>,
	"Richard Sandiford" <rsandifo@redhat.com>
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
References: <200406281519.IAA29663@mail-sj1-2.sj.broadcom.com>
 <Pine.LNX.4.55.0407191612160.3667@jurand.ds.pg.gda.pl>
 <mailpost.1090246948.15046@news-sj1-1>
From: cgd@broadcom.com
Date: 19 Jul 2004 08:19:17 -0700
In-Reply-To: <mailpost.1090246948.15046@news-sj1-1>
Message-ID: <yov5k6x0vxca.fsf@ldt-sj3-010.sj.broadcom.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
X-WSS-ID: 6CE539FC2QW21899679-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <cgd@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cgd@broadcom.com
Precedence: bulk
X-list: linux-mips

At Mon, 19 Jul 2004 14:22:29 +0000 (UTC), "Maciej W. Rozycki" wrote:
> (this has led to an address shift enlarging the
> patch significantly, unfortunately).

maybe add nops to pad, instead?


cgd
