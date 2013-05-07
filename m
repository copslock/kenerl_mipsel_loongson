Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 May 2013 18:41:03 +0200 (CEST)
Received: from mail-out.m-online.net ([212.18.0.10]:51424 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825883Ab3EGQk5qO4S0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 May 2013 18:40:57 +0200
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 3b4mlr6jZZz3hhrt;
        Tue,  7 May 2013 18:40:56 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3b4mlr1Dy0zbc0f;
        Tue,  7 May 2013 18:40:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id SxGd-AQ2NHVR; Tue,  7 May 2013 18:40:55 +0200 (CEST)
X-Auth-Info: 2IOpTnQHcf2QKkM9wToEjxgCrGhZ9M3a9dmS0ZrdMWA=
Received: from hase.home (ppp-88-217-124-55.dynamic.mnet-online.de [88.217.124.55])
        by mail.mnet-online.de (Postfix) with ESMTPA;
        Tue,  7 May 2013 18:40:55 +0200 (CEST)
Received: by hase.home (Postfix, from userid 1000)
        id 4AFBC105158; Tue,  7 May 2013 18:40:54 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org
Subject: Re: Build errors caused by modalias generation patch
References: <20130506160253.GA27181@linux-mips.org>
X-Yow:  I'm EXCITED!!  I want a FLANK STEAK WEEK-END!!  I think I'm JULIA
 CHILD!!
Date:   Tue, 07 May 2013 18:40:54 +0200
In-Reply-To: <20130506160253.GA27181@linux-mips.org> (Ralf Baechle's message
        of "Mon, 6 May 2013 18:02:54 +0200")
Message-ID: <874neeu4ix.fsf@hase.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <whitebox@nefkom.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwab@linux-m68k.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Ralf Baechle <ralf@linux-mips.org> writes:

> cobalt_defconfig:
>
>   CC [M]  drivers/hid/usbhid/hid-quirks.o
>   LD [M]  drivers/hid/usbhid/usbhid.o
> FATAL: drivers/hid/usbhid/usbhid: sizeof(struct usb_device_id)=32 is not a modulo of the size of section __mod_usb_device_table=48.
> Fix definition of struct usb_device_id in mod_devicetable.h

What are the contents of devicetable-offsets.[sh]?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
