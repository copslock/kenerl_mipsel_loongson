Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 08:05:06 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.171]:54937 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20037666AbWLFIFC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Dec 2006 08:05:02 +0000
Received: by ug-out-1314.google.com with SMTP id 40so76168uga
        for <linux-mips@linux-mips.org>; Wed, 06 Dec 2006 00:05:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=I3F3rRbJUaaUm3/Vpgm42VKb93E28/tyMwssAtdEMlBtKohlrMo24XmlINDHHXIA4uat7LMiXHZ8Rj55QPIbW5G5AXf7yLn5qgfTlDGn07ZmONPHGxt+vnsi1urDAzYv0uoLXbT426DRxBlMvCHM/MbTSa0/c4vSAWKH4kcucQI=
Received: by 10.78.17.1 with SMTP id 1mr324601huq.1165392301698;
        Wed, 06 Dec 2006 00:05:01 -0800 (PST)
Received: by 10.78.199.6 with HTTP; Wed, 6 Dec 2006 00:05:01 -0800 (PST)
Message-ID: <38dc7fce0612060005o6807e347re182171214c2501a@mail.gmail.com>
Date:	Wed, 6 Dec 2006 17:05:01 +0900
From:	"Youngduk Goo" <ydgoo9@gmail.com>
To:	linux-mips@linux-mips.org
Subject: USB 2.0 error
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <ydgoo9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ydgoo9@gmail.com
Precedence: bulk
X-list: linux-mips

I have tested the USB 2.0 and 1.1 on my set based on the mips core.
The kernel version is 2.6.15 (not the uclinux) with uClibc.

The port 0 of USB is working fine as a EHCI(2.0) when I put the storage.
But In case of port 1, it fails to identify the device.
It can read the device information but cannot read partition table.
I don't know how to debug it. ans where to start it.
Please give me a advice.

Thanks in advance.

This is the error message.

Vendor: I0MEGA    Model: Mini128MB*IOM2B5  Rev: 2.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
aSCSI device sda: 256000 512-byte hdwr sectors (131 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 256000 512-byte hdwr sectors (131 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
usb 1-2: reset high speed USB device using hcd and address 2
sd 0:0:0:0: SCSI error: return code = 0x70000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
usb 1-2: reset high speed USB device using hcd and address 2
sd 0:0:0:0: SCSI error: return code = 0x70000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
 unable to read partition table
sd 0:0:0:0: Attached scsi removable disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
usb-storage: device scan complete
