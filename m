Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jun 2004 19:47:36 +0100 (BST)
Received: from mms1.broadcom.com ([IPv6:::ffff:63.70.210.58]:61968 "EHLO
	mms1.broadcom.com") by linux-mips.org with ESMTP
	id <S8225781AbUFXSrc>; Thu, 24 Jun 2004 19:47:32 +0100
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.6.0)); Thu, 24 Jun 2004 11:46:59 -0700
X-Server-Uuid: 97B92932-364A-4474-92D6-5CFE9C59AD14
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id LAA03858; Thu, 24 Jun 2004 11:46:20 -0700 (PDT)
Received: from ldt-sj3-010.sj.broadcom.com (ldt-sj3-010 [10.21.64.10])
 by mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 i5OIkrov009252; Thu, 24 Jun 2004 11:46:54 -0700 (PDT)
Received: (from cgd@localhost) by ldt-sj3-010.sj.broadcom.com (
 8.11.6/8.9.3) id i5OIkrA10130; Thu, 24 Jun 2004 11:46:53 -0700
X-Authentication-Warning: ldt-sj3-010.sj.broadcom.com: cgd set sender to
 cgd@broadcom.com using -f
To: macro@ds2.pg.gda.pl
cc: "Richard Sandiford" <rsandifo@redhat.com>,
	"David Daney" <ddaney@avtrex.com>,
	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
References: <40C9F5A4.2050606@avtrex.com> <40C9F5FE.8030607@avtrex.com>
 <40C9F7F0.50501@avtrex.com>
 <Pine.LNX.4.55.0406112039040.13062@jurand.ds.pg.gda.pl>
 <mailpost.1086981251.16853@news-sj1-1>
 <yov57juduc7q.fsf@ldt-sj3-010.sj.broadcom.com>
 <Pine.LNX.4.55.0406222304340.23178@jurand.ds.pg.gda.pl>
 <87y8mdgryp.fsf@redhat.com>
 <Pine.LNX.4.55.0406242031020.8569@jurand.ds.pg.gda.pl>
 <mailpost.1088102121.25381@news-sj1-1>
From: cgd@broadcom.com
Date: 24 Jun 2004 11:46:53 -0700
In-Reply-To: <mailpost.1088102121.25381@news-sj1-1>
Message-ID: <yov5eko4okte.fsf@ldt-sj3-010.sj.broadcom.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
X-WSS-ID: 6CC5FE292QW12723715-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <cgd@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cgd@broadcom.com
Precedence: bulk
X-list: linux-mips

At Thu, 24 Jun 2004 18:35:21 +0000 (UTC), "Maciej W. Rozycki" wrote:
>  Well, this is essentially what the patch does.  Or do you mean: "drop it
> and if anyone screams, consider an alternative?"  I'd find it acceptable,
> actually, but it's not my opinion that really matters here.

(it's fine w/ me.)
