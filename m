Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2005 07:13:12 +0100 (BST)
Received: from wproxy.gmail.com ([64.233.184.204]:35374 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133414AbVJYGMq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Oct 2005 07:12:46 +0100
Received: by wproxy.gmail.com with SMTP id i6so8457wra
        for <linux-mips@linux-mips.org>; Mon, 24 Oct 2005 23:12:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mEmKwYPVAEKVYpBQo41KeSj2bK9OEjulHiVcfqVCKP64zp+H3tfiseKMVsZ6eB59BPTjJMcdCxnUaiQd2mvalSO3UD/Oy4mGCgWULjLT7lpImxK69Vvhckm0PEhXY2Zd/1l15iFnoMt/giTmHZHhNEwGTYWLNdsJ14ElVVxkf/g=
Received: by 10.54.34.7 with SMTP id h7mr98636wrh;
        Mon, 24 Oct 2005 23:12:45 -0700 (PDT)
Received: by 10.54.133.2 with HTTP; Mon, 24 Oct 2005 23:12:45 -0700 (PDT)
Message-ID: <f69849430510242312j5e943bbcj4d1b50e0b236662a@mail.gmail.com>
Date:	Mon, 24 Oct 2005 23:12:45 -0700
From:	kernel coder <lhrkernelcoder@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Problem in "copy_to_user"
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

hi,
   i'm trying to run oprofile on 2.6 kernel running on mips board.But
when oprofile makes a system call to "sys_lookup_dcookie" function to
find the file path of a particular sample,the function "copy_to_user"
fails and no byte of path is copied to user sapce.

I checked all combinations for source buffer like using array instead
of pointer but no success.
Please suggest me what might be the cause of failure.

regards,
kernelcoder
