Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 13:58:18 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.224]:45248 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039322AbXB1N6N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Feb 2007 13:58:13 +0000
Received: by wr-out-0506.google.com with SMTP id i30so201193wra
        for <linux-mips@linux-mips.org>; Wed, 28 Feb 2007 05:57:12 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=D0tRYFshwY+F7t0hE1K/rCMG+k/oGbtmfkmlrG65XmdfZerSmTm9PNZI2PLInASTaexpy+8OnLLse4C3Xok0dCPD/DuSoEv/we7YhfHMJFfZQ3Mv/rvKmLy+42APPpFS9bZgRBGJ9XRii4PW/5Xhtniena8UGX8+EIppzaUOf1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aA2kV+IuhyEijSJ6rAF6QG+qt6jYIcQd+/B408tXLbTxhD8ptpBlTq6zKLASymdYgWFs5v83Aa5dK2TVD9Bgksy7ryB6Si14fchC7a71dKa8zQFXpehY8pQBQJ3X+2qO5MHt4jT+HuFQn4xJ1nQcvLaDaLIbkFUgJoUwndyaEOM=
Received: by 10.114.132.5 with SMTP id f5mr717012wad.1172671028268;
        Wed, 28 Feb 2007 05:57:08 -0800 (PST)
Received: by 10.114.168.17 with HTTP; Wed, 28 Feb 2007 05:57:08 -0800 (PST)
Message-ID: <50c9a2250702280557r3b4e3594r360fa7c24465d0b8@mail.gmail.com>
Date:	Wed, 28 Feb 2007 21:57:08 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: how to switch rootfs from initrd to new rootfs manualy?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i used to switch rootfs from initrd to nfs by use "pivot_root" and
"exec chroot" with kernel cmdline having "init=/linuxrc".
But if i do not set "init=/linuxrc", and bootup with the ramdisk as
rootfs. after that, i manualy execute "pivot_root" and "exec chroot"
etc. it seems switching rootfs umcompletely. the /etc/init.d/rcS is
not executed while "exec chroot . /sbin/init <dev/console >dev/console
2>&1".
does anyone have some similiar experience ?

thanks for any hints

Best Regards

zhuzhenhua
