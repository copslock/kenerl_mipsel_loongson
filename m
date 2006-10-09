Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 17:29:47 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.236]:49733 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039698AbWJIQ3q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Oct 2006 17:29:46 +0100
Received: by wx-out-0506.google.com with SMTP id h30so1732884wxd
        for <linux-mips@linux-mips.org>; Mon, 09 Oct 2006 09:29:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=rvJO1sZvyksVtXlou4hArCmdR7M1x5M0z+8EB5URQVvwIjin550X5aWPagZsIpcYqiW8JZtJk59uLseEF8G+crYVUUsAmcTYXMbyR3kcAJWabvWxN79QlQFoYVpYRLz1QyL9TXxSVRKgfB48bySR4kONyqhweX7TudOfQXZI66Y=
Received: by 10.90.79.6 with SMTP id c6mr2807661agb;
        Mon, 09 Oct 2006 09:29:44 -0700 (PDT)
Received: by 10.90.66.14 with HTTP; Mon, 9 Oct 2006 09:29:44 -0700 (PDT)
Message-ID: <103e245f0610090929i35c2033budaac2fae10ec7277@mail.gmail.com>
Date:	Mon, 9 Oct 2006 18:29:44 +0200
From:	"Igal Chernobelsky" <igalch@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Math-Emu Issue
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_38729_17194111.1160411384634"
Return-Path: <igalch@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: igalch@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_38729_17194111.1160411384634
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I started to use LinuxThread in Linux 2.4 (version
2.4.17_mvl21-malta-mips_fp_le) and sometimes encounter a problem of
arithmetic exception while performing dividing of two variables of double
type. Our MIPS core does not include FPU coprocessor so math-emu is used. Is
there any known problems/patches for kernel math emulation when LinuxThreads
is used?

------=_Part_38729_17194111.1160411384634
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I started to use LinuxThread in Linux 2.4 (version
2.4.17_mvl21-malta-mips_fp_le) and sometimes encounter a problem of
arithmetic exception while performing dividing of two variables of
double type. Our MIPS core does not include FPU coprocessor so math-emu
is used. Is there any known problems/patches for kernel math emulation
when LinuxThreads is used?

------=_Part_38729_17194111.1160411384634--
