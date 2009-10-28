Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 08:17:50 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:34258 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492030AbZJ1HRn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 08:17:43 +0100
Received: by pwi11 with SMTP id 11so661452pwi.24
        for <linux-mips@linux-mips.org>; Wed, 28 Oct 2009 00:17:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=oRA1P0+xTr9XuFi+m3N8FT5/XIsWCpTqFtd3JTZLIrc=;
        b=b0Kq2kM/7fIjC6v4j0+x8ilv58TTfCAqPyAdrxHHVYrkUfYQXl7jmDse+U9JTMNAdk
         nn5hPXw4bZCuOiYi+gX7uHJ1/lQxePeeymXM7l0KUONmvvM7NYWXnAvaJkRo9K9dEKBB
         AREoE3Ws9AFUAViTF/UnM/8Em86XdxGkH8uNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=MZRiFxuEReWfXUnLf+lWggnZkFA4QvGcijG1SIT+odlbZQFjEdo+xvfL3JuS436FoB
         0nq2ynUWnYvraNPUCCzRwjccC0/1NCvm84fgqs9AUo/2l30duZvJkh2pZzOfztSrn+jI
         SsFSfXmaZb88vmtbDLLs12skmMl3uAEeg7oJ0=
MIME-Version: 1.0
Received: by 10.142.118.9 with SMTP id q9mr1382456wfc.49.1256714256833; Wed, 
	28 Oct 2009 00:17:36 -0700 (PDT)
Date:	Wed, 28 Oct 2009 15:17:36 +0800
Message-ID: <3a665c760910280017o11af6412n5fd3abdeda369bf3@mail.gmail.com>
Subject: where we get handle_ades_int
From:	loody <miloody@gmail.com>
To:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

Dear all:
I try to grep handle_ades_int in kernel source code, and I get nothing.
But I can see the function name in System.map.
How do we make this function?
Is this function generate from compiler marco?
appreciate your help,
miloody
