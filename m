Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2006 06:38:39 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.202]:1116 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133383AbWAFGiT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jan 2006 06:38:19 +0000
Received: by wproxy.gmail.com with SMTP id 36so2791421wra
        for <linux-mips@linux-mips.org>; Thu, 05 Jan 2006 22:40:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VSeGgt4S2M4PxIGqPsI+fIZSkBdqnlmfNAmpCFTItSHin11lDhZVDw2hqyTPIw1Z1mbnlq1cvYzqCAn9cLVRZkVPMANFUovk7rnnNdfQ3ltwfAHOqxljD5GXAw9Qd6LSwbsn4Cs1VR4GUJEWxILtLOsnEwV90NJkuwQ0L9gS3ZY=
Received: by 10.54.149.8 with SMTP id w8mr4557050wrd;
        Thu, 05 Jan 2006 22:40:58 -0800 (PST)
Received: by 10.54.156.1 with HTTP; Thu, 5 Jan 2006 22:40:58 -0800 (PST)
Message-ID: <50c9a2250601052240n5696e353teb2b798ecbf802f0@mail.gmail.com>
Date:	Fri, 6 Jan 2006 14:40:58 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: sometimes get "crc error" while uncompressed ramdisk
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i make a ramdisk by myself, and sometimes the kernel boot the ramdisk
correctly but sometimes it printk "crc error" while uncompressed
ramdisk, did someone meet this situation?
thanks for any hints

Best regards


zhuzhenhua
