Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2007 07:04:30 +0000 (GMT)
Received: from web8408.mail.in.yahoo.com ([202.43.219.156]:39761 "HELO
	web8408.mail.in.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20039214AbXABHEZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Jan 2007 07:04:25 +0000
Received: (qmail 57041 invoked by uid 60001); 2 Jan 2007 07:04:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=sWg6u/oJGP2VR1KHeTXckjUKhHTRsT7nCDTOVGBPONm6krVqL/4zGbMH/KCm0T7xjdFlj/ZJaDODL6KsKYH3G7P4nRT3pHWCxPgsXWQc2nTvbRAiFKnnJPF7+ACXBJAIGmC2U0eH2F8x7HsXQ86J9P0r5AUQkDKM/QAgmzPfSuM=;
X-YMail-OSG: itk0oPkVM1ki95d9946TbF.B1d4bb5ZUBpophv5UVQHLG6anOQTcnw6ADaEqX_1RULiKzXQNNIFAp1Q6pQWULWQswt7T7SWy5MJ2SRcGakx8qjgz32bdhPTF2QOfw.0ToAugsx2FVAPnOrh1Xi7aaMBTAA--
Received: from [61.246.223.98] by web8408.mail.in.yahoo.com via HTTP; Tue, 02 Jan 2007 07:04:15 GMT
Date:	Tue, 2 Jan 2007 07:04:15 +0000 (GMT)
From:	veerasena reddy <veerasena_b@yahoo.co.in>
Subject: problem with starting an application daemon from rcS script in case of lnux-2.6.18 kernel version.
To:	linux-mips <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <201707.54244.qm@web8408.mail.in.yahoo.com>
Return-Path: <veerasena_b@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: veerasena_b@yahoo.co.in
Precedence: bulk
X-list: linux-mips

Hi,

I wrote a small appication "test_shell" and started
the same as a background process ("test_shell&") from
"rcS" script to print a message "This is to test the
shell for daemon processes" on console for every ten
seconds.

For this, the rcS script contains the below command:
"test_shell &"

I have built two images for the target with the kernel
versions linux-2.6.18 and linux-mips-2.6.12.

In case of linux-mips-2.6.12 i am able to see the
prints on the console.

In case of linux-2.6.18 i am not getting the prints
on the console. if i try "ps" command i am able to see
the process running in the background.

In both kernel versions libraries and shell used are
same.

What could be the reason for this?
Please suggest me some solution for this.

Thanks in advance.

Regards,
veeru.

Send free SMS to your Friends on Mobile from your Yahoo! Messenger. Download Now! http://messenger.yahoo.com/download.php
