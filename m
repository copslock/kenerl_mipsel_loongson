Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 18:54:13 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:5641 "EHLO mms1.broadcom.com")
	by ftp.linux-mips.org with ESMTP id S20039897AbWJJRyL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Oct 2006 18:54:11 +0100
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.2)); Tue, 10 Oct 2006 10:53:52 -0700
X-Server-Uuid: 8BFFF8BB-6D19-4612-8F54-AA4CE9D0539E
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 75B5C2AE; Tue, 10 Oct 2006 10:53:52 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 29C6A2AF; Tue, 10 Oct
 2006 10:53:52 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EHE35030; Tue, 10 Oct 2006 10:53:19 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 0E02620501; Tue, 10 Oct 2006 10:53:19 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: CFE problem: starting secondary CPU.
Date:	Tue, 10 Oct 2006 10:53:18 -0700
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D07011FE47D@NT-SJCA-0750.brcm.ad.broadcom.com>
In-Reply-To: <66910A579C9312469A7DF9ADB54A8B7D3E73D2@exchange.ZeugmaSystems.local>
Thread-Topic: CFE problem: starting secondary CPU.
Thread-Index: Acbpo1bBhY91FwuRSxSoPT5JCpbUywCN3gGQACzu07AAAY2jIA==
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Kaz Kylheku" <kaz@zeugmasystems.com>, linux-mips@linux-mips.org
cc:	mason@broadcom.com
X-TMWD-Spam-Summary: TS=20061010175355; SEV=2.0.2; DFV=A2006101008;
 IFV=2.0.4,4.0-8; RPD=4.00.0004; ENG=IBF;
 RPDID=303030312E30413031303230362E34353242444446332E303035312D412D;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: A2006101008_4.00.0004_4.0-8
X-WSS-ID: 693501BA09W3189711-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello, 

> Mark E Mason: 
> > Kaz Kylheku:
> > > 
> > > Anyone seen a problem like this? cfe_cpu_start() works fine on a
> > > 32 bit kernel, but not on 64.
> > 
> > Which version of CFE are you using?  We'd seen something like 
> > this with
> > the 1480 eval boards, some specific versions of CFE, and 64-bit SMP
> > Linux.
> 
> I see in the release notes that something was fixed in 1.2.4 
> that could
> prevent 64 bit SMP from booting: a bug that was preventing the upper
> halves of registers from being saved. Is that what you are talking
> about?
> 
> We are on 1.3.0.

Yes, I was thinking of the one fixed in 1.2.4.

Definitely sounds like a [new] bug then.  Have you filed a bug report
with sibyte-software@broadcom.com?

Thx,
Mark

> 
> Thanks.
> 
> 
> 
