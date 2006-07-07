Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2006 06:12:33 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.173]:34154 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8127208AbWGGFMY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Jul 2006 06:12:24 +0100
Received: by ug-out-1314.google.com with SMTP id k3so2416516ugf
        for <linux-mips@linux-mips.org>; Thu, 06 Jul 2006 22:12:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=B9CkXO+oIzVK5npAJRsm8Ofz46Rh1YLOuGPHOixYobLSAnkQtSP/BI6JbplMEhpTvhJuzgluo/k6E3dZGvPArEXCBJ1A8CtO8wkdTWoCJfOVAb13IYimQY82T2MQfbyxo8rtrTM78Bba9wBbgEm9zlz5DBzQ39Um36x9yE8I5vQ=
Received: by 10.67.29.12 with SMTP id g12mr1549838ugj;
        Thu, 06 Jul 2006 22:12:23 -0700 (PDT)
Received: by 10.66.242.15 with HTTP; Thu, 6 Jul 2006 22:12:23 -0700 (PDT)
Message-ID: <50c9a2250607062212w70de956ax7aefd4f131ae9396@mail.gmail.com>
Date:	Fri, 7 Jul 2006 13:12:23 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: "Error -3 while decompressing!" while use cramfs as rootfs
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i have write a rootfs.cramfs to mtdblock2, and if i use nfsroot, and
can mount /dev/mtdblock2 correctly.but if i use /dev/mtdblock2 as
rootfs with bootargs
"root/dev/mtdblock2 rootfstype=cramfs"
the kernel output next messages
....
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 144k freed
Error -3 while decompressing!
805bf6a8(-2046512)->81218000(4096)
Error -3 while decompressing!
803cc4fc(26)->8121e000(4096)
Error -3 while decompressing!
803cc516(26)->8121f000(4096)
Error -3 while decompressing!
803cc530(26)->803a0000(4096)
....

my kernel version is 2.6.14, flash is SST39VF3201, nor flash, 4M Byte

does anyone have idea about this situation?

thanks for any hints

Best Regards

zhuzhenhua
