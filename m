Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 18:05:48 +0000 (GMT)
Received: from mail.baslerweb.com ([IPv6:::ffff:145.253.187.130]:47233 "EHLO
	mail.baslerweb.com") by linux-mips.org with ESMTP
	id <S8225196AbUKWSFo>; Tue, 23 Nov 2004 18:05:44 +0000
Received: (from mail@localhost)
	by mail.baslerweb.com (8.12.10/8.12.10) id iANI3Hvq009824
	for <linux-mips@linux-mips.org>; Tue, 23 Nov 2004 19:03:17 +0100
Received: from unknown by gateway id /var/KryptoWall/smtpp/kwlnxehC; Tue Nov 23 19:03:15 2004
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id X3RVK2FN; Tue, 23 Nov 2004 19:05:27 +0100
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: Manish Lachwani <mlachwani@prometheus.mvista.com>
Subject: Re: [PATCH] Comments in the titan ethernet driver for IP header
  alignment
Date: Tue, 23 Nov 2004 19:10:02 +0100
User-Agent: KMail/1.6.2
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
References: <20041123171421.GA30451@prometheus.mvista.com>
In-Reply-To: <20041123171421.GA30451@prometheus.mvista.com>
MIME-Version: 1.0
Message-Id: <200411231910.02427.thomas.koeller@baslerweb.com>
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Hi Manish,

register 0x103c is not documented in any but the newest version of
the processor's user manual, and the function documented there has
_nothing_ to do with header alignment. So either the docs are wrong,
or the register implements both the documented and undocumented
functions. In this case, however, the code would be wrong because it
permanently modifies the register's contents, which could screw up
packet priority processing.

Thomas

On Tuesday 23 November 2004 18:14, Manish Lachwani wrote:
> Hi Ralf,
>
> Attached patch puts comments around the section that programs register
> 0x103C for IP header alignment. Please review ...
>
> Thanks
> Manish Lachwani

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
