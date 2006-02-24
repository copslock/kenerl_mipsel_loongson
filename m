Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2006 19:36:51 +0000 (GMT)
Received: from mms2.broadcom.com ([216.31.210.18]:35598 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133750AbWBXTgj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2006 19:36:39 +0000
Received: from 10.10.64.154 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Fri, 24 Feb 2006 11:43:58 -0800
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 513F02AF; Fri, 24 Feb 2006 11:43:41 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 127442AE; Fri, 24 Feb
 2006 11:43:41 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id CZL01022; Fri, 24 Feb 2006 11:43:35 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 AFEF220501; Fri, 24 Feb 2006 11:43:35 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [RFC] SMP initialization order fixes.
Date:	Fri, 24 Feb 2006 11:43:35 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D077D618E@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: [RFC] SMP initialization order fixes.
Thread-Index: AcY43V4zwRxcOLinQmK+oGBBBfgRNgAnQQsQ
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Stuart Anderson" <anderson@netsweng.com>,
	"Ralf Baechle" <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006022406; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230332E34334646363142462E303037392D412D;
 ENG=IBF; TS=20060224194400; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006022406_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FE1BE740QO8165-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello Stuart,

Um - define "hung"...  There's some networking issues in 2.6.14 and
later kernels that only seem to show up in non-NAPI GigE drivers.  Do
you simply lose your NFS server & it never comes back, or does the
console stop responding to echo as well?

Thx,
Mark
 

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Stuart Anderson
> Sent: Thursday, February 23, 2006 4:57 PM
> To: Ralf Baechle
> Cc: linux-mips@linux-mips.org
> Subject: Re: [RFC] SMP initialization order fixes.
> 
> On Thu, 23 Feb 2006, Ralf Baechle wrote:
> 
> >> I'm not sure if this is the specific fix or not, but I can report 
> >> that git as of today (approx 2pm est) is working better 
> than is has 
> >> since 2.6.14 for me on a bcm1480. I had tried git a couple 
> of weeks 
> >> ago, and it still hung when I stressed it.
> >
> > Seems unrelated then.  This fix should make the difference between 
> > working perfectly or not at all.  There have been numerous 
> other fixes 
> > since 2.6.14 so hard to say what made the difference.
> 
> You're right, it is unrelated. Shortly after this message 
> wnet out & came back, it hung up again like it had been doing 
> 8-(. I should have just kept my mouth shut and then it would 
> still be working.
> 
> It really did run much longer that one time, but I haven't 
> been able to reproduce a run that lasted that long again. Sigh....
> 
> 
>                                  Stuart
> 
> Stuart R. Anderson                               anderson@netsweng.com
> Network & Software Engineering                   
> http://www.netsweng.com/
> 1024D/37A79149:                                  0791 D3B8 
> 9A4C 2CDC A31F
>                                                   BD03 0A62 
> E534 37A7 9149
> 
> 
> 
