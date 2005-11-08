Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2005 10:48:52 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.201]:55235 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8135811AbVKHKse convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Nov 2005 10:48:34 +0000
Received: by zproxy.gmail.com with SMTP id l8so502514nzf
        for <linux-mips@linux-mips.org>; Tue, 08 Nov 2005 02:49:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lhqEyAMSgcpJbveFu1bguGsCYhuSc1ENgHSLNOInZ11Uq2K1UJlNeq3pe3jQSDLKCc4q6RBbxE1Pz4ohS88Xq1i5qUyvz01TAahxCp3aKIFUDv9PE+14bPQgATPeN1gpCJ4F8HJ9Q+HKBvn2W12aztqY4Qu8rIZ1V2duf8U1ims=
Received: by 10.36.101.3 with SMTP id y3mr2279372nzb;
        Tue, 08 Nov 2005 02:49:48 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Tue, 8 Nov 2005 02:49:48 -0800 (PST)
Message-ID: <cda58cb80511080249w7d902821n@mail.gmail.com>
Date:	Tue, 8 Nov 2005 11:49:48 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Subject: git and tags...
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm trying to retrieve a linux kernel by tag using git. Let's say for
example I want my working tree to be a linux 2.6.12 copy from git
repository. How can I do that ?

I tried these commands but it seems that there's no tag in git repository

git clone rsync://ftp.linux-mips.org/git/linux.git linux.git
git pull http://www.linux-mips.org/pub/scm/linux.git tag linux_2_6_12


Thanks
--
               Franck
