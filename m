Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2006 15:06:52 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.188]:6920 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038493AbWKMPGs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Nov 2006 15:06:48 +0000
Received: by nf-out-0910.google.com with SMTP id l24so2027776nfc
        for <linux-mips@linux-mips.org>; Mon, 13 Nov 2006 07:06:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Eu++uvNEvkff4Q0Fu9ylYc+DdRK0jnSKrjK6lGJeoAslGFrA65my2mO1ttsnpQw65v8cEcPaDoJ7yYcDEp52atx7RhEqRjExmYqBGf8/FdM+wjQnv9MJvvBVOQFrOijQAaW4kOtVWUe39ANeEdaKruo+GSAczEN4qEgl30mwEFI=
Received: by 10.48.142.8 with SMTP id p8mr9992481nfd.1163430404743;
        Mon, 13 Nov 2006 07:06:44 -0800 (PST)
Received: by 10.48.163.3 with HTTP; Mon, 13 Nov 2006 07:06:44 -0800 (PST)
Message-ID: <2e134a330611130706u4b8da444w469b88e96d3c55f0@mail.gmail.com>
Date:	Mon, 13 Nov 2006 10:06:44 -0500
From:	"s c" <steve.carren@gmail.com>
To:	linux-mips@linux-mips.org
Subject: au1500 USB does not recover from flash drive removal during operations
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <steve.carren@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steve.carren@gmail.com
Precedence: bulk
X-list: linux-mips

Hello All,

I was testing the USB capabilities of the au1500 and discovered that
when a USB flash drive is removed during a copy operation twice, the
USB host controller/root hub will no longer detect if the device is
plugged in a third time.  I am assuming there is a bug in the au1xxx
parts of the USB drivers because Linux has been able to handle this
case for some time with the standard  EHCI/OHCI/UHCI host controllers.

I am testing using the dbau1500 development board and the 2.6.12
kernel with the fs in ram.

I would be interested if anyone has experienced anything similar with
the au1500 and the 2.6.12 or other (earlier or later) kernels.

The test goes something like this:

Plug in the USB drive - it gets detected.

(it does not seem to matter whether the drive is mounted or not, I
tested both ways.)

At the command prompt:
#dd if=/dev/zero of=/dev/sda bs=1k count=50k

after some time un-plug the drive.

Error messages (too many to post)

Repeat

Third time device is not detected.

I did not want to post a huge list of error messages, but I did notice
differences between the first and second try.

In the first, I got a lot of "rejecting I/O to device being removed"
from scsi, while after the second removal I did not. Instead I got a
lot of "Buffer I/O error on device sda" from scsi.

I am actively looking in to the problem and wanted to post to the list
in case someone else had come across this behaviour. I could list the
error messages if anyone is interested.

Any feedback would be appreciated.

Thanks
