Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2009 20:42:04 +0100 (BST)
Received: from ey-out-1920.google.com ([74.125.78.148]:24809 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20026696AbZD3Tl6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2009 20:41:58 +0100
Received: by ey-out-1920.google.com with SMTP id 13so462546eye.54
        for <linux-mips@linux-mips.org>; Thu, 30 Apr 2009 12:41:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=iD6teZbyfUdUd+TpH9eaYhNaLy8cHK2PSWRLX4lh0cM=;
        b=gsqbkAk1Mehr52hXgTAPbmEo1mxX9afdbxDrS+jqGuACvamuHGXsBa5gnFyZFZeAcx
         UxOhv23HLNfB6l6+s8+LwsYpB57i3pFLH4lGQx7eSTR6yjZ3GnAwZ8mukQyGLoVP/9fw
         n2s263XCrDF8Bkk0DgacZgt4uoYs7xq5etdNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=ls5prXQvK+rg34Drqq71KgU259YYCoZvqoQMT+yx8S7QSeQpiPe3WvlWOr1QuZpT9o
         AYXi1+shA1A9VeQatVODakx8ExeC+nGQvFhUfhXZi53DQHu5o2muP9k4/izfu/6/ls5X
         KqOt4JB89kItQSMLVu6ocbKgKM/YLzd+mzF4c=
Received: by 10.210.33.3 with SMTP id g3mr2356703ebg.33.1241120516000;
        Thu, 30 Apr 2009 12:41:56 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 28sm4626748eye.46.2009.04.30.12.41.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Apr 2009 12:41:55 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	linux-mips@linux-mips.org
Subject: initramfs breakage with 64-bits kernels?
Date:	Thu, 30 Apr 2009 21:41:52 +0200
User-Agent: KMail/1.9.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904302141.53025.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi all,

I have been trying to get a 2.6.29 64-bits kernel for Cavium Octeon to work 
with a 32-bits userland in an initramfs. While booting, the kernel does not 
find the initramfs due to the check against initrd_start in populate_rootfs 
(init/initramfs.c) failing.

Do you have any idea about what could be wrong here ? Is this a regression ?
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
