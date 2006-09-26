Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 05:53:12 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:4109 "EHLO MMS3.broadcom.com")
	by ftp.linux-mips.org with ESMTP id S20027696AbWIZExL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Sep 2006 05:53:11 +0100
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.2)); Mon, 25 Sep 2006 21:52:53 -0700
X-Server-Uuid: 450F6D01-B290-425C-84F8-E170B39A25C9
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 9B3812AF; Mon, 25 Sep 2006 21:52:53 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 76B3A2AE; Mon, 25 Sep
 2006 21:52:53 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EFW57046; Mon, 25 Sep 2006 21:52:53 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 1684420501; Mon, 25 Sep 2006 21:52:53 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Kernel debugging contd.
Date:	Mon, 25 Sep 2006 21:52:51 -0700
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D07011FD8C2@NT-SJCA-0750.brcm.ad.broadcom.com>
In-Reply-To: <20060919180645.8122.qmail@web31501.mail.mud.yahoo.com>
Thread-Topic: Kernel debugging contd.
Thread-Index: AcbcFm6FNQ6D9e09T3KChFxMJ2v1FQFERoHQ
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Jonathan Day" <imipak@yahoo.com>, linux-mips@linux-mips.org
X-TMWD-Spam-Summary: TS=20060926045258; SEV=2.0.2; DFV=A2006092510;
 IFV=2.0.4,4.0-8; RPD=4.00.0004; ENG=IBF;
 RPDID=303030312E30413031303230332E34353138423031392E303033322D452D42494266314252712B51595268337955544B6A5A6E413D3D;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: A2006092510_4.00.0004_4.0-8
X-WSS-ID: 69066DAF2304155563-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello, 

> -----Original Message-----
> From: Jonathan Day [mailto:imipak@yahoo.com] 
> Sent: Tuesday, September 19, 2006 11:07 AM
> To: Mark E Mason; linux-mips@linux-mips.org
> Subject: RE: Kernel debugging contd.
> 
> I would guess I can fix the problem by simply
> cutting-and-pasting the SB1 codes back in and then
> changing the calls. (If there's a patch for this out
> there, that would be even easier...! :)
> 
> Out of curiosity, any idea why the code was switched
> to a generic implementation?

Ralf will have to answer that one, but I believe it was caught up in a
general housecleaning of the MMU/cache code.

/Mark

> 
> --- Mark E Mason <mark.e.mason@broadcom.com> wrote:
> 
> > Hello,
> > 
> > FWIW - this is the same place my boards are hanging
> > (right after freeing
> > kernel memory).  I'd tracked it down to the commit
> > that changed the
> > cache/page handling for the sibyte parts from the
> > sb1 specific to the
> > generic codes -- but haven't found time to look into
> > it further as yet.
> > 
> > /Mark 
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> 
> 
