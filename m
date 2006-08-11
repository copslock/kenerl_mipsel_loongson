Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 03:24:25 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:47117 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20044478AbWHKCYV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Aug 2006 03:24:21 +0100
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Thu, 10 Aug 2006 19:24:04 -0700
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 2A20F2AF; Thu, 10 Aug 2006 19:24:04 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 088A22AE; Thu, 10 Aug
 2006 19:24:04 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id ECG97069; Thu, 10 Aug 2006 19:24:03 -0700 (PDT)
Received: from NT-SJCA-0751.brcm.ad.broadcom.com (nt-sjca-0751
 [10.16.192.221]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 B433F20501; Thu, 10 Aug 2006 19:24:03 -0700 (PDT)
Received: from NT-SJCA-0752.brcm.ad.broadcom.com ([10.16.192.222]) by
 NT-SJCA-0751.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 10 Aug 2006 19:24:03 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: 2.6.17 on Broadcom BigSur (BCM91x80 A/B)
Date:	Thu, 10 Aug 2006 19:24:02 -0700
Message-ID: <710F16C36810444CA2F5821E5EAB7F230A0203@NT-SJCA-0752.brcm.ad.broadcom.com>
In-Reply-To: <66910A579C9312469A7DF9ADB54A8B7D33AEC6@exchange.ZeugmaSystems.local>
Thread-Topic: 2.6.17 on Broadcom BigSur (BCM91x80 A/B)
Thread-Index: Aca83+BUY44lzVI3SJuaFZU85vKM6wACzYew
From:	"Manoj Ekbote" <manoje@broadcom.com>
To:	"Kaz Kylheku" <kaz@zeugmasystems.com>, linux-mips@linux-mips.org
X-OriginalArrivalTime: 11 Aug 2006 02:24:03.0660 (UTC)
 FILETIME=[36A398C0:01C6BCED]
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006081011; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230322E34344442453939362E303031352D412D;
 ENG=IBF; TS=20060811022406; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006081011_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 68C535CE0HW64771523-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <manoje@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manoje@broadcom.com
Precedence: bulk
X-list: linux-mips


Hi Kaz,

Kindly make sure that the below 2 patches have been applied.
 
http://www.linux-mips.org/archives/linux-mips/2006-07/msg00021.html
http://www.linux-mips.org/archives/linux-mips/2006-07/msg00020.html

HTH,
/manoj

>-----Original Message-----
>From: linux-mips-bounce@linux-mips.org 
>[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Kaz Kylheku
>Sent: Thursday, August 10, 2006 5:49 PM
>To: linux-mips@linux-mips.org
>Subject: 2.6.17 on Broadcom BigSur (BCM91x80 A/B)
>
>Anyone running 2.6.17 on the above Broadcom board or derivative?
>
>I'm trying to run it an our hardware that is based on this 
>board. It's slightly patched so that it builds :), and so that 
>certain things work right on our board.
>
>Kernel 2.6.14 works, and the patches migrated to 2.6.17 
>without too many difficulties.
>
>It hangs on startup around the point where dynamic IP 
>configuration is done.
>
>Sometimes the last output that is seen is the printk message
>
>  Sending DHCP and RARP requests .
>
>Sometimes it doesn't appear.
>
>So before I dive into it head first, I thought I'd poke the 
>mailing list.
>
>
>
