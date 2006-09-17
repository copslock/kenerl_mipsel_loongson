Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2006 21:34:26 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:24330 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20027658AbWIQUeY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 Sep 2006 21:34:24 +0100
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Sun, 17 Sep 2006 13:34:08 -0700
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 A6D6B2AF; Sun, 17 Sep 2006 13:34:08 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 80DF12AE; Sun, 17 Sep
 2006 13:34:08 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EFG44303; Sun, 17 Sep 2006 13:34:08 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 33F2720501; Sun, 17 Sep 2006 13:34:08 -0700 (PDT)
Received: from NT-SJCA-0752.brcm.ad.broadcom.com ([10.16.192.222]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Sun, 17 Sep 2006 13:34:08 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Kernel debugging contd.
Date:	Sun, 17 Sep 2006 13:34:07 -0700
Message-ID: <710F16C36810444CA2F5821E5EAB7F2305D9C3@NT-SJCA-0752.brcm.ad.broadcom.com>
In-Reply-To: <20060917010142.GA23646@linux-mips.org>
Thread-Topic: Kernel debugging contd.
Thread-Index: AcbZ9NV/zD7mfj6DSUGjMVfzufk6mgAokH0A
From:	"Manoj Ekbote" <manoje@broadcom.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Mark E Mason" <mark.e.mason@broadcom.com>
cc:	"Jonathan Day" <imipak@yahoo.com>, linux-mips@linux-mips.org
X-OriginalArrivalTime: 17 Sep 2006 20:34:08.0075 (UTC)
 FILETIME=[9FFE11B0:01C6DA98]
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006091707; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230322E34353044414637302E303030312D412D;
 ENG=IBF; TS=20060917203412; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006091707_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 69136ECA3CC7683758-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <manoje@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manoje@broadcom.com
Precedence: bulk
X-list: linux-mips

If I may add, the changes made when the flush_icache_page call was
retired seems to cause this problem.
I reversed some of the changes and the kernel boots fine atleast on
1480.

commit id : 4bbd62a93a1ab4b7d8a5b402b0c78ac265b35661


/manoj

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Ralf Baechle
Sent: Saturday, September 16, 2006 6:02 PM
To: Mark E Mason
Cc: Jonathan Day; linux-mips@linux-mips.org
Subject: Re: Kernel debugging contd.

On Fri, Sep 15, 2006 at 03:54:06PM -0700, Mark E Mason wrote:

> FWIW - this is the same place my boards are hanging (right after
freeing
> kernel memory).  I'd tracked it down to the commit that changed the
> cache/page handling for the sibyte parts from the sb1 specific to the
> generic codes -- but haven't found time to look into it further as
yet.

Got a commit ID?

  Ralf
