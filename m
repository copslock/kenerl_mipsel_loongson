Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 09:19:06 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.152]:1717 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20021569AbZA0JTE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Jan 2009 09:19:04 +0000
Received: by fg-out-1718.google.com with SMTP id 16so41291fgg.32
        for <linux-mips@linux-mips.org>; Tue, 27 Jan 2009 01:19:03 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vQJJWP7pMdY779Il1HZesa3G6k9aIgyYe9wAgtnhOYM=;
        b=Yw66/5C3v34DNVYs4yMVEY7QD07N4KCmzMVo9x6WNShmCn8zg600w75+Me88f+2kRE
         VIU12S6ZWGMfMWXa91hsvET+HMqk2UQf33fbahh7Ac8AR9i0odwOoyqFj3EC+RJkX9IE
         iTqaWmtoGgKwxQXzBJC2bq2wll8PuJ1l5r0DI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HxLiPJ9hYMGR6O+RdTUMVFD531ZBP6etenKnGO1XDVQ8WGhLv/7lnqX6ktsj2vZ9/M
         LZrmXSYn6jvjxWJaKc2SL2cq0xay4ojz9LMFboAAqJKrpmTOYQJK57l4PJAB6e2bcTWR
         RJEOCL2y6sncHBEI4ZIFb87SVeZzeJRdKkkJg=
Received: by 10.86.93.19 with SMTP id q19mr301259fgb.62.1233047943423;
        Tue, 27 Jan 2009 01:19:03 -0800 (PST)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id l19sm6187471fgb.42.2009.01.27.01.19.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 01:19:02 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: AU1550 Kernel bug detected[#1]  clockevents_register_device
Date:	Tue, 27 Jan 2009 10:18:30 +0100
User-Agent: KMail/1.9.9
Cc:	Frank Neuber <linux-mips@kernelport.de>,
	Linux-MIPS <linux-mips@linux-mips.org>
References: <1233045842.28527.459.camel@t60p> <20090127091107.GA15890@roarinelk.homelinux.net>
In-Reply-To: <20090127091107.GA15890@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200901271018.31863.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Tuesday 27 January 2009 10:11:07 Manuel Lauss, vous avez écrit :
> On Tue, Jan 27, 2009 at 09:44:02AM +0100, Frank Neuber wrote:
> > Hi,
> > to find my PCI problem I want to use git to find the last working
> > version.
> > I just start with head and found a compile error:
> > arch/mips/alchemy/common/time.c:93: error: incompatible types in
> > initialization
> > I comment this line ".cpumask        = CPU_MASK_ALL,"
>
> you need to change it to "CPU_MASK_ALL_PTR".  Commenting it is not a very
> good idea ;-)

This build failure also happens on linux-queue. Patch below.
--
From: Florian Fainelli
Subject: [PATCH] alchemy: fix build failure on time.c

This patch fixes the following build failure :

arch/mips/alchemy/common/time.c:93: error: incompatible types in
initialization

Reported-by: Frank Neuber <linux-mips@kernelport.de>
Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index 3288014..6fd441d 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -89,7 +89,7 @@ static struct clock_event_device au1x_rtcmatch2_clockdev = {
 	.irq		= AU1000_RTC_MATCH2_INT,
 	.set_next_event	= au1x_rtcmatch2_set_next_event,
 	.set_mode	= au1x_rtcmatch2_set_mode,
-	.cpumask	= CPU_MASK_ALL,
+	.cpumask	= CPU_MASK_ALL_PTR,
 };
 
 static struct irqaction au1x_rtcmatch2_irqaction = {
