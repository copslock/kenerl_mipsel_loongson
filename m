Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2010 06:27:50 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:2870 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491033Ab0CQF1q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Mar 2010 06:27:46 +0100
Received: from [10.16.192.224] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Tue, 16 Mar 2010 22:27:26 -0700
X-Server-Uuid: B55A25B1-5D7D-41F8-BC53-C57E7AD3C201
Received: from SJEXCHCCR01.corp.ad.broadcom.com ([10.252.49.130]) by
 SJEXCHHUB01.corp.ad.broadcom.com ([10.16.192.224]) with mapi; Tue, 16
 Mar 2010 22:27:26 -0700
From:   "Ramgopal Kota" <rkota@broadcom.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:   Tue, 16 Mar 2010 22:27:24 -0700
Subject: RE: MIPS raw_local_irq_restore flags
Thread-Topic: MIPS raw_local_irq_restore flags
Thread-Index: AcrBK3wkk2FBNl+9TaOxNHDqJxz80AEZusdw
Message-ID: <6C370B347C3FE8438C9692873287D2E1109DDF0057@SJEXCHCCR01.corp.ad.broadcom.com>
References: <4BEA3FF3CAA35E408EA55C7BE2E61D0546AC862322@xmail3.se.axis.com>
In-Reply-To: <4BEA3FF3CAA35E408EA55C7BE2E61D0546AC862322@xmail3.se.axis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
X-WSS-ID: 67BEB7B431G62138311-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <rkota@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkota@broadcom.com
Precedence: bulk
X-list: linux-mips

Hi ,

Is there any moderation done to the messages posted to this mailing list. I posted couple of messages but none has come , just wondering what is wrong ? 

Thanks & Regards,
Ramgopal Kota
-----Original Message-----
From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Mikael Starvik
Sent: Thursday, March 11, 2010 8:30 PM
To: linux-mips@linux-mips.org
Subject: MIPS raw_local_irq_restore flags

For the common case CONFIG_CPU_MIPSR2 && CONFIG_IRQ_CPU raw_local_irq_restore_flags is defined as:

"       beqz    \\flags, 1f                                     \n"
"       di                                                      \n"
"       ei                                                      \n"
"1:                                                             \n"

Doesn't this imply that you can't do recursive local_irq_save() (with different locks ofcourse)? 

Best Regards
/Mikael
