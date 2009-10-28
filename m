Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2009 00:52:05 +0100 (CET)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:53947 "EHLO
	mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493117AbZJ1Xv6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2009 00:51:58 +0100
Received: by gxk2 with SMTP id 2so747683gxk.4
        for <linux-mips@linux-mips.org>; Wed, 28 Oct 2009 16:51:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=7hxxltjS8q58RR5p60lUjRXrZUNyy83lAJzc8kMhHvE=;
        b=c0L//NOp5iHB5Ar8+2rm7olh03EJB2+vDOV+ZyH2llZnxKBzuvQK37EEWO36RqeKFG
         kY0OWVf8I9YXz+A+B3QxILdtJ9QbKVawJdjv83R42qr1djp9/z+7iI5LhLwm1yBKQo2H
         03fcB3PxRsxXpx+jTwBU2VHbZjsxbYqsIT5aI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=QNK34M5q5Yiof6qEYBagsoZunRMvg4ZX9nSMO3g+vonHZeTBdo6feCkw74cU+M8Pg1
         qMTQdIN4+tzo9M0SrJes6sh7AGXfIzXWOu7d0XVUtzKhfUjyjB54tO62fFFaZ8XWybEB
         zI0dY0h72Bes8ZZB0LHoNYzviqGOuOYqiV4Rs=
MIME-Version: 1.0
Received: by 10.90.226.13 with SMTP id y13mr1207026agg.107.1256773912210; Wed, 
	28 Oct 2009 16:51:52 -0700 (PDT)
Date:	Thu, 29 Oct 2009 07:51:52 +0800
Message-ID: <e997b7420910281651p24b8e367m1e2ddbc1b95ac623@mail.gmail.com>
Subject: Problem in booting when calling calibrate_delay
From:	"wilbur.chan" <wilbur512@gmail.com>
To:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

I was going to boot mips64  xlr408, which has 8 cores.

Howerver, the code seemd to stop before calling 'start_kernel--->

calibrate_delay ' .

So Iadded some 'printk' in  calibrate_delay,  to check out why it failed.


 However,  if I added a 'printk' in any 'if  branches'  in

'calibrate_delay '  function  , the kernel would halt  before calling


'j  start_kernel'  in head.S. (in this situation ,printk seemed

unavailable, so  I  wrote directlly to serial address  to trace the

kernel).


Can anyone tell me why this happed?

Thank you
