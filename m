Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2005 19:14:17 +0000 (GMT)
Received: from natnoddy.rzone.de ([IPv6:::ffff:81.169.145.166]:13018 "EHLO
	natnoddy.rzone.de") by linux-mips.org with ESMTP
	id <S8227840AbVCWTOC>; Wed, 23 Mar 2005 19:14:02 +0000
Received: from excalibur.cologne.de (cable-195-14-198-241.netcologne.de [195.14.198.241])
	by post.webmailer.de (8.13.1/8.13.1) with ESMTP id j2NJE0i2028093
	for <linux-mips@linux-mips.org>; Wed, 23 Mar 2005 20:14:01 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.36 #1 (Debian))
	id 1DEBIn-0001b2-00
	for <linux-mips@linux-mips.org>; Wed, 23 Mar 2005 20:14:01 +0100
Date:	Wed, 23 Mar 2005 20:14:01 +0100
From:	Karsten Merker <karsten@excalibur.cologne.de>
To:	linux-mips@linux-mips.org
Subject: Re: defkeymap.c Compile Warnings . . .
Message-ID: <20050323191400.GA6038@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
References: <54AC63178735ED46BAC5F5E668A9F224046AAC@alfalfa.fortresstech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54AC63178735ED46BAC5F5E668A9F224046AAC@alfalfa.fortresstech.com>
X-No-Archive: yes
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

On Wed, Mar 23, 2005 at 01:56:50PM -0500, Dennis Daniels wrote:

> I'm having a compile problem with the generated file defkeymap.c for Linux
> 64-bit MIPS on the BCM1250, and was wondering if anyone has seen or heard
> of it. The structures in defkeymap.c are all coming out 2x what they
> should be . . .

AFAICS the reason is a change in the kernel headers between 2.4 and 2.6.

In 2.4, the file linux/keyboard.h has 

#define NR_KEYS         128

while in 2.6 it has

#define NR_KEYS         256

The loadkeys command that is used to generate the defkeymap.c
file has probably been built against 2.6 headers -> it generates
arrays with 256 instead of 128 entries, which would lead to the
"excess elements in array initializer" error you are
experiencing.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
