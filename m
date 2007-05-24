Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2007 05:32:18 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.177]:27756 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021600AbXEXEcP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 May 2007 05:32:15 +0100
Received: by wa-out-1112.google.com with SMTP id m16so120747waf
        for <linux-mips@linux-mips.org>; Wed, 23 May 2007 21:31:41 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=b9kfEOJ5Q6hosw2H8aOQwtoorEdYUwE82vfSo/OY7U9Jdqg+bY/sKxg57l6x1vMPvroV9R51ep3Ypm0jQ2z7Rd/MPqEx+cFLqPLLfvgIgPSYxSdEobxT/JIoBbSoUXUOh+50AxNjlKUmZzErhVvmpCt7ymDQzSe9D9g44+Edj68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KVJlkmhHNvQcV/qiilFbM3z93PLOdcFPK0bwwaEif0Ebbx7zqvwHv4xP3hyb0Zs78Xxa4LmTon8xgt96ZIeGHEcqgge5RE83nOQtjrtumZ/W7N/jnKzBxDv6YHab5mYl34pUSRP1BV/LBpLJ9WC8utTdt+PJlPmn01h00ym6xv8=
Received: by 10.114.78.1 with SMTP id a1mr671048wab.1179981101381;
        Wed, 23 May 2007 21:31:41 -0700 (PDT)
Received: by 10.114.177.11 with HTTP; Wed, 23 May 2007 21:31:41 -0700 (PDT)
Message-ID: <7b5da6b00705232131l54db9bbbl53e7730e3296d6c3@mail.gmail.com>
Date:	Wed, 23 May 2007 21:31:41 -0700
From:	"Y Yang" <yyang702@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Q: vailable memory when initrd exists?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <yyang702@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yyang702@gmail.com
Precedence: bulk
X-list: linux-mips

In "arch/mips/kernel/setup.c", it appears that the "free memory" pool
is the memory area after kernel code and initrd if configured. Since
the location of "initrd" is set by "rd_start", it is possible that
there will be "memory hole" between the kernel and "initrd". It is my
understanding that the memory area up to the "free memory" pool will
not be available, even after "initrd" is freed later in the boot
process. I am curious as why it is necessary to do it this way? What
if we treat the whole area after the kernel code as the "free memory"
pool? This shouldn't affect "initrd", as the memory used by "initrd"
is reserved.

I looked at both older 2.6.14 and the latest kernel code. That part of
the logic seems largely unchanged. I suspect I must have missed
something.

Thanks for your help in advance.

Regards,

Steve.
