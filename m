Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2007 06:23:52 +0100 (BST)
Received: from hu-out-0506.google.com ([72.14.214.232]:39352 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022769AbXI1FXn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Sep 2007 06:23:43 +0100
Received: by hu-out-0506.google.com with SMTP id 31so1375357huc
        for <linux-mips@linux-mips.org>; Thu, 27 Sep 2007 22:23:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=dGKn1X/yEUx6iK+BANb/U5Bn6IWmSm6cZ3zOacw/Aco=;
        b=FlkSs1P6ppp/gQlnt8/8ldN/j1FS0r5HyEWIqmNasjrnjrk+n5GitpSLHt/IXqLqkv50eJ9e9R/v0qdl0E0zUJLuR2qMK5w9dUs/7GULw/4EyPMT7skOZwmCggBkGp0M+xtlZHP2QkHXJjRETtGSNMm5654bX0js8Ni/ENrlpxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gqx1kTGreCobz7MDK33qTL0gvDtD+03fOjQp8OskUsH26rEShpy3pxQyTrBPPUJjVYVWN+cDt4or5IeM2ud5+wO1RdrVAV3kNEAxYFC7lldXd1Lue1QBmG3dk/6Cnvzmdygv6zpeZ7VB9yHPk2qp9wZp/63BlG5pt/+88EuldSE=
Received: by 10.66.219.16 with SMTP id r16mr4541826ugg.1190957005367;
        Thu, 27 Sep 2007 22:23:25 -0700 (PDT)
Received: by 10.86.71.18 with HTTP; Thu, 27 Sep 2007 22:23:25 -0700 (PDT)
Message-ID: <52163af60709272223n72212e2bh197c7e622e3ba155@mail.gmail.com>
Date:	Fri, 28 Sep 2007 10:53:25 +0530
From:	"Suprasad Mutalik Desai" <suprasad.desai@gmail.com>
To:	linux-mips@linux-mips.org
Subject: mapping a userspace thread to a kernelspace thread
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <suprasad.desai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: suprasad.desai@gmail.com
Precedence: bulk
X-list: linux-mips

Hi list ,

            I want to know how can we map a userspace thread to a
kernel thread as mentioned in 1:1 threading model (linuxthreads) or
M:N model (NPTL)  . Does this happen by just calling a
pthread_create() in the userspace program or i need to do something
more in the kernel space . i am using 2.6.20 kernel  .
       I want to use this for multi threading operation in a SMP
environment where in i want to schedule a userspace program on another
processor by spawning a thread  . Can anyone help me in this.

Thanks and regards,
Suprasad.
