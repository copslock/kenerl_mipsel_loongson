Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Nov 2006 01:27:50 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.189]:8594 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039045AbWKPB1p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Nov 2006 01:27:45 +0000
Received: by nf-out-0910.google.com with SMTP id l24so821750nfc
        for <linux-mips@linux-mips.org>; Wed, 15 Nov 2006 17:27:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=e5PjfRCGa/YyOBmd0WkdSb95voiK/Svm4aMQdkGQ9p1kPdMZKmzHZT8Nk0O6burroK4vLVK2uOc2qBsGSljFa6dnAYbAuJSH2bIWfPsJzQhFQWMo+Mkdsou3MbqnB53dQYRs91DLs/XRu6tZ1Vr8qbiST3xl+z3Jy2N62DGfkgQ=
Received: by 10.49.1.12 with SMTP id d12mr1770563nfi.1163640464866;
        Wed, 15 Nov 2006 17:27:44 -0800 (PST)
Received: by 10.48.217.19 with HTTP; Wed, 15 Nov 2006 17:27:44 -0800 (PST)
Message-ID: <71a06cc90611151727k32422c9bg75eb993fee821e12@mail.gmail.com>
Date:	Thu, 16 Nov 2006 09:27:44 +0800
From:	WhiteFox <wyh817@gmail.com>
To:	linux-mips@linux-mips.org
Subject: A promble about driver
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <wyh817@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wyh817@gmail.com
Precedence: bulk
X-list: linux-mips

i wrote a simple driver in broadcom7111(use MIPSs3000),it works in the topbox.
the linux kernel is 2.4.25
the compiler is uclibc-3.3.5
when i insmod the driver,it say:unresolved symbol _gp_disp
what is this mean?
thak you

my code  is:

#define MODULE
#include <linux/module.h>
int init_module(void)
{
  printk("<1>Hello,world\n");
  return 0;
}
void cleanup_module(void)
{
  printk("<1>Good Bye\n");
}
