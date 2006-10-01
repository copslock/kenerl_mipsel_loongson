Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Oct 2006 18:29:53 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.238]:62341 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038653AbWJAR3v (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 1 Oct 2006 18:29:51 +0100
Received: by wx-out-0506.google.com with SMTP id h30so1612313wxd
        for <linux-mips@linux-mips.org>; Sun, 01 Oct 2006 10:29:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=HdH+jmK7b9bbe7VfRh51OCmgmfpUpZGBxwChATbFbN8/n8ukVhVRHFlqH/0XU9V2TQye7+z+ZxQAe4AGEH5RCOFNTqRGLMfZZ9oqbb6ObkjnGBbTRJ5WXbjc6uxQXENPTX3BF2ajHMkBHBZ8RbiBmq0SKR1kn+cCmsWzPx/EDRk=
Received: by 10.90.72.10 with SMTP id u10mr2496533aga;
        Sun, 01 Oct 2006 10:29:49 -0700 (PDT)
Received: by 10.90.31.10 with HTTP; Sun, 1 Oct 2006 10:29:49 -0700 (PDT)
Message-ID: <5ee285ba0610011029y13932410ueb27669000086a65@mail.gmail.com>
Date:	Mon, 2 Oct 2006 01:29:49 +0800
From:	"David Lee" <receive4me@gmail.com>
To:	linux-mips@linux-mips.org
Subject: depmod: Segmentation Fault
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_32989_26988842.1159723789504"
Return-Path: <receive4me@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: receive4me@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_32989_26988842.1159723789504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I downloaded modutils-2.4.27 and compiled it with no error on my mipsel
linux-2.4.30. lsmod works fine. However, running depmod -v shown the
following errors:

# ./depmod -v
xftw starting at /lib/modules/boot lstat on /lib/modules/boot failed
xftw starting at /lib/modules/2.4.30
xftw_readdir /lib/modules/2.4.30
pruned build
type 2 /lib/modules/2.4.30/kernel
xftw_readdir /lib/modules/2.4.30/kernel
user function /lib/modules/2.4.30/kernel
type 2 /lib/modules/2.4.30/kernel/crypto
xftw_readdir /lib/modules/2.4.30/kernel/crypto
user function /lib/modules/2.4.30/kernel/crypto
user function /lib/modules/2.4.30/kernel/crypto/aes.o
user function /lib/modules/2.4.30/kernel/crypto/arc4.o
user function /lib/modules/2.4.30/kernel/crypto/deflate.o
.................
.................
xftw starting at /lib/modules/2.4 lstat on /lib/modules/2.4 failed
xftw starting at /lib/modules/kernel lstat on /lib/modules/kernel failed
xftw starting at /lib/modules/fs lstat on /lib/modules/fs failed
xftw starting at /lib/modules/net lstat on /lib/modules/net failed
xftw starting at /lib/modules/scsi lstat on /lib/modules/scsi failed
xftw starting at /lib/modules/block lstat on /lib/modules/block failed
xftw starting at /lib/modules/cdrom lstat on /lib/modules/cdrom failed
xftw starting at /lib/modules/ipv4 lstat on /lib/modules/ipv4 failed
xftw starting at /lib/modules/ipv6 lstat on /lib/modules/ipv6 failed
xftw starting at /lib/modules/sound lstat on /lib/modules/sound failed
xftw starting at /lib/modules/fc4 lstat on /lib/modules/fc4 failed
xftw starting at /lib/modules/video lstat on /lib/modules/video failed
xftw starting at /lib/modules/misc lstat on /lib/modules/misc failed
xftw starting at /lib/modules/pcmcia lstat on /lib/modules/pcmcia failed
xftw starting at /lib/modules/atm lstat on /lib/modules/atm failed
xftw starting at /lib/modules/usb lstat on /lib/modules/usb failed
xftw starting at /lib/modules/ide lstat on /lib/modules/ide failed
xftw starting at /lib/modules/ieee1394 lstat on /lib/modules/ieee1394 failed

xftw starting at /lib/modules/mtd lstat on /lib/modules/mtd failed
xftw starting at /lib/modules/boot lstat on /lib/modules/boot failed
Segmentation fault

Kernel was compiled with kmod. I could load modules by busybox.

Please help. Thanks.

David

------=_Part_32989_26988842.1159723789504
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>I downloaded modutils-2.4.27 and compiled it with no error on my mipsel linux-2.4.30. lsmod works fine. However,&nbsp;running depmod -v shown the following errors:</div>
<div>&nbsp;</div>
<div># ./depmod -v<br>xftw starting at /lib/modules/boot lstat on /lib/modules/boot failed<br>xftw starting at /lib/modules/2.4.30<br>xftw_readdir /lib/modules/2.4.30<br>pruned build<br>type 2 /lib/modules/2.4.30/kernel<br>
xftw_readdir /lib/modules/2.4.30/kernel<br>user function /lib/modules/2.4.30/kernel<br>type 2 /lib/modules/2.4.30/kernel/crypto<br>xftw_readdir /lib/modules/2.4.30/kernel/crypto<br>user function /lib/modules/2.4.30/kernel/crypto
<br>user function /lib/modules/2.4.30/kernel/crypto/aes.o<br>user function /lib/modules/2.4.30/kernel/crypto/arc4.o<br>user function /lib/modules/2.4.30/kernel/crypto/deflate.o<br>.................</div>
<div>.................</div>
<div>xftw starting at /lib/modules/2.4 lstat on /lib/modules/2.4 failed<br>xftw starting at /lib/modules/kernel lstat on /lib/modules/kernel failed<br>xftw starting at /lib/modules/fs lstat on /lib/modules/fs failed<br>xftw starting at /lib/modules/net lstat on /lib/modules/net failed 
<br>xftw starting at /lib/modules/scsi lstat on /lib/modules/scsi failed<br>xftw starting at /lib/modules/block lstat on /lib/modules/block failed<br>xftw starting at /lib/modules/cdrom lstat on /lib/modules/cdrom failed<br>
xftw starting at /lib/modules/ipv4 lstat on /lib/modules/ipv4 failed<br>xftw starting at /lib/modules/ipv6 lstat on /lib/modules/ipv6 failed<br>xftw starting at /lib/modules/sound lstat on /lib/modules/sound failed<br>xftw starting at /lib/modules/fc4 lstat on /lib/modules/fc4 failed 
<br>xftw starting at /lib/modules/video lstat on /lib/modules/video failed<br>xftw starting at /lib/modules/misc lstat on /lib/modules/misc failed<br>xftw starting at /lib/modules/pcmcia lstat on /lib/modules/pcmcia failed 
<br>xftw starting at /lib/modules/atm lstat on /lib/modules/atm failed<br>xftw starting at /lib/modules/usb lstat on /lib/modules/usb failed<br>xftw starting at /lib/modules/ide lstat on /lib/modules/ide failed<br>xftw starting at /lib/modules/ieee1394 lstat on /lib/modules/ieee1394 failed 
<br>xftw starting at /lib/modules/mtd lstat on /lib/modules/mtd failed<br>xftw starting at /lib/modules/boot lstat on /lib/modules/boot failed<br>Segmentation fault<br>&nbsp;</div>
<div>Kernel was compiled with kmod. I could load modules by busybox.</div>
<div>&nbsp;</div>
<div>Please help. Thanks.</div>
<div>&nbsp;</div>
<div>David</div>
<div>&nbsp;</div>

------=_Part_32989_26988842.1159723789504--
