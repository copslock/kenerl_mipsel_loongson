Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 12:12:28 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.199]:31301 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133572AbWCAMME convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 12:12:04 +0000
Received: by nproxy.gmail.com with SMTP id c2so76465nfe
        for <linux-mips@linux-mips.org>; Wed, 01 Mar 2006 04:18:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sGVbt1EL9dwx7YNJd7w0c1Ugr0iCy5eJEUCn6PCrcnBELUc5zK2APd6iqHDvTcYBaCSvbqZZqPCZ2fMD7IaKySnSxgQrL8C2yInZMNoGMZgAFl/R9BHb42rvJYJUccWNjmyiQaf004wIdpDGnGNnWiFNPf9xMEZHD6ZJoVm52Wo=
Received: by 10.49.87.6 with SMTP id p6mr60999nfl;
        Wed, 01 Mar 2006 04:18:50 -0800 (PST)
Received: by 10.48.249.14 with HTTP; Wed, 1 Mar 2006 04:18:50 -0800 (PST)
Message-ID: <50c9a2250603010418s6f778c25s799d79cee2b79333@mail.gmail.com>
Date:	Wed, 1 Mar 2006 20:18:50 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: how to select a rootfs for embedded linux based hardisk?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

dear all
          i want to port the linux to our board based hardisk with
mips arch. i do not find too much file sytem for rootfs on hardisk
besides ext2/ext3.
but it seems ext2/ext3 is not suitable for embedded system.
 does someone have idea or experience with these products?

thanks for any hints.

Best regards

zhuzhenhua
