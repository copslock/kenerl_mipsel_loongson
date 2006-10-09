Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 20:42:43 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:6160 "EHLO mms2.broadcom.com")
	by ftp.linux-mips.org with ESMTP id S20039691AbWJITmj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Oct 2006 20:42:39 +0100
Received: from 10.10.64.154 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.2)); Mon, 09 Oct 2006 12:42:25 -0700
X-Server-Uuid: 79DB55DB-3CB4-423E-BEDB-D0F268247E63
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 D50222AF; Mon, 9 Oct 2006 12:42:24 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id B08032AE; Mon, 9 Oct
 2006 12:42:24 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EHC21974; Mon, 9 Oct 2006 12:42:24 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 3A80C20501; Mon, 9 Oct 2006 12:42:24 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: CFE problem: starting secondary CPU.
Date:	Mon, 9 Oct 2006 12:42:23 -0700
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D07011FE3A6@NT-SJCA-0750.brcm.ad.broadcom.com>
In-Reply-To: <66910A579C9312469A7DF9ADB54A8B7D3E7324@exchange.ZeugmaSystems.local>
Thread-Topic: CFE problem: starting secondary CPU.
Thread-Index: Acbpo1bBhY91FwuRSxSoPT5JCpbUywCN3gGQ
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Kaz Kylheku" <kaz@zeugmasystems.com>, linux-mips@linux-mips.org
cc:	mason@broadcom.com
X-TMWD-Spam-Summary: TS=20061009194227; SEV=2.0.2; DFV=A2006100907;
 IFV=2.0.4,4.0-8; RPD=4.00.0004; ENG=IBF;
 RPDID=303030312E30413031303230322E34353241413542462E303035312D412D;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: A2006100907_4.00.0004_4.0-8
X-WSS-ID: 693479AB2I02791255-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Kaz Kylheku
> Sent: Friday, October 06, 2006 4:59 PM
> To: linux-mips@linux-mips.org
> Subject: CFE problem: starting secondary CPU.
> 
> Anyone seen a problem like this? cfe_cpu_start() works fine on a
> 32 bit kernel, but not on 64.

Which version of CFE are you using?  We'd seen something like this with
the 1480 eval boards, some specific versions of CFE, and 64-bit SMP
Linux.

Thx,
Mark
