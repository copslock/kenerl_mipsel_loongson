Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Feb 2004 14:53:42 +0000 (GMT)
Received: from natsmtp01.rzone.de ([IPv6:::ffff:81.169.145.166]:55004 "EHLO
	natsmtp01.rzone.de") by linux-mips.org with ESMTP
	id <S8225523AbUBAOxl>; Sun, 1 Feb 2004 14:53:41 +0000
Received: from excalibur.cologne.de (pD9E40BF7.dip.t-dialin.net [217.228.11.247])
	by post.webmailer.de (8.12.10/8.12.10) with ESMTP id i11EracF025330;
	Sun, 1 Feb 2004 15:53:36 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 1AnIzo-0000W4-00; Sun, 01 Feb 2004 15:54:48 +0100
Date: Sun, 1 Feb 2004 15:54:48 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: Linux MIPS Mailing list <linux-mips@linux-mips.org>
Subject: Re: Problems with LCD panel & SCSI support with Linux 2.4.24-pre2 on Cobalt Qube II
Message-ID: <20040201145448.GA1945@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	Stuart Longland <stuartl@longlandclan.hopto.org>,
	Linux MIPS Mailing list <linux-mips@linux-mips.org>
References: <401D06A6.4050905@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401D06A6.4050905@longlandclan.hopto.org>
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips

On Mon, Feb 02, 2004 at 12:01:10AM +1000, Stuart Longland wrote:

> 	Just the other day, I dragged out the old Gateway Microserver I have
> here (a rebadged Cobalt Qube II) with the idea of setting it up as a
> fileserver.
[snip]
> January, 2004) -- This seems to have corrected the hard lockups I had
> previously, however, the SCSI card still doesn't work and now the LCD
> panel on the back no-longer functions.

The device id for the LCD panel has changed in newer kernel versions;
the minor device id seems to be selected dynamically now:

static struct miscdevice lcd_dev = {
        MISC_DYNAMIC_MINOR,
        "lcd",
        &lcd_fops
};

HTH,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
