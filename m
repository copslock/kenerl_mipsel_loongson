Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2007 19:37:05 +0000 (GMT)
Received: from mms3.broadcom.com ([216.31.210.19]:34566 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20032268AbXKGTg5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2007 19:36:57 +0000
Received: from [10.10.64.154] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.1)); Wed, 07 Nov 2007 11:36:40 -0800
X-Server-Uuid: 20144BB6-FB76-4F11-80B6-E6B2900CA0D7
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 981772AF; Wed, 7 Nov 2007 11:36:40 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 83FB62AE; Wed, 7 Nov
 2007 11:36:40 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id FXL41467; Wed, 7 Nov 2007 11:36:40 -0800 (PST)
Received: from NT-SJCA-0751.brcm.ad.broadcom.com (nt-sjca-0751
 [10.16.192.221]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 C536920501; Wed, 7 Nov 2007 11:36:39 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Deleting read-only environment variable on Sibyte board.
Date:	Wed, 7 Nov 2007 11:36:38 -0800
Message-ID: <03235919BBDE634289BB6A0758A20B36025B79F4@NT-SJCA-0751.brcm.ad.broadcom.com>
In-Reply-To: <20071106222834.GA4079@linux-mips.org>
Thread-Topic: Deleting read-only environment variable on Sibyte board.
Thread-Index: AcggxGuHpOTKGJIQQ0qeipED5zRbugAq0JnA
From:	"Manoj Ekbote" <manoj.ekbote@broadcom.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
X-WSS-ID: 6B2CCC424QC16690235-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <manoj.ekbote@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manoj.ekbote@broadcom.com
Precedence: bulk
X-list: linux-mips

It looks like the variable was set with 'setenv -ro' command. This will
need a manual delete.
Bad news -  This would probably require a new firmware build.  There is
no current command to remove -ro variables (non-existing feature).

>-----Original Message-----
>From: Ralf Baechle [mailto:ralf@linux-mips.org] 
>Sent: Tuesday, November 06, 2007 2:29 PM
>To: Manoj Ekbote
>Cc: linux-mips@linux-mips.org
>Subject: Re: Deleting read-only environment variable on Sibyte board.
>
>On Tue, Nov 06, 2007 at 12:18:51PM -0800, Manoj Ekbote wrote:
>
>> Hi Ralf,
>>  
>> Can you try 'Unsetenv [NAME]'?
>
>I'm getting an error message, something about the variable 
>being read-only.
>
>Thanks anyway,
>
>  Ralf
>
>
