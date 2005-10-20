Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 16:31:26 +0100 (BST)
Received: from qproxy.gmail.com ([72.14.204.198]:11141 "EHLO qproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3465710AbVJTPbK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 16:31:10 +0100
Received: by qproxy.gmail.com with SMTP id e12so350024qba
        for <linux-mips@linux-mips.org>; Thu, 20 Oct 2005 08:31:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aFAqpgw2OeUIDeqLyUi7csapecz9AfdL8uKeKAUOPaxrZKiUn9AL7xoZMsH9TbiTKZdEaKD1GNG7GyfVk8TTX8B6EeH0yJkrlYPvmQGO4sxbUtzdM7KKzOT3876VFCwB3new60RsvdTrvltEx9o/bB+LgHDBM0ZhyjVkFmMtIPc=
Received: by 10.64.183.2 with SMTP id g2mr1618373qbf;
        Thu, 20 Oct 2005 08:31:01 -0700 (PDT)
Received: by 10.64.204.10 with HTTP; Thu, 20 Oct 2005 08:31:01 -0700 (PDT)
Message-ID: <132d4af90510200831p2750709el8a8765ed8f9e38cb@mail.gmail.com>
Date:	Thu, 20 Oct 2005 11:31:01 -0400
From:	Sachin Kulkarni <write2sck@gmail.com>
To:	linux-kernel@vger.kernel.org
Subject: kdb patch
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <write2sck@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: write2sck@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I want to remotely debug the arm linux kernel on a Intel XScale board.
I am currently using kernel 2.6. Which version/patch of kdb should I
use for the same?

Thanks,
Sachin
