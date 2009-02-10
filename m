Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2009 15:17:04 +0000 (GMT)
Received: from rv-out-0708.google.com ([209.85.198.246]:59573 "EHLO
	rv-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S21365134AbZBJPRA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Feb 2009 15:17:00 +0000
Received: by rv-out-0708.google.com with SMTP id c5so2271229rvf.24
        for <multiple recipients>; Tue, 10 Feb 2009 07:16:58 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=oE8xYcVDzdoAFTp5vWfRehkz7wFAbfOjpGvfcsIdVCw=;
        b=d5eiEpgbEYIr4Nl30wZRBv3aS9+4jxuPDz4TCBY8cXMDbKe1bffXwoRzBOeBFeGRJR
         /AhXShet7zyl8G+s4zO5O6zRsgLE+syNODL0Te+1yhomukz6qAzhqHufj1cb6wsCVCNy
         iTTLE4qnLho5S8LtuaBrU9mRUBYBILRVelWwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=amdv6Ov8MTEda3ZCmTFyhrG32/e7IeRssD5jXK/SEnHieMf5LZqAnJgIF/0apSPAo8
         hHvLK/defuDT9JEPjSiZFYhMxAY+WJ3XOiunUffEo9y5fxg7oQLiA6JM1XbnZz7gO8tn
         DcfzYoxOM1PjmW2wVn643ihRV9TaAuAHs8/0U=
MIME-Version: 1.0
Received: by 10.141.28.2 with SMTP id f2mr4680769rvj.170.1234279018294; Tue, 
	10 Feb 2009 07:16:58 -0800 (PST)
Date:	Tue, 10 Feb 2009 20:46:58 +0530
Message-ID: <f5a7b3810902100716t2658ce95t2dcc7f85634522@mail.gmail.com>
Subject: cacheflush system call-MIPS
From:	naresh kamboju <naresh.kernel@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=000e0cd210c6706c82046291fa36
Return-Path: <naresh.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: naresh.kernel@gmail.com
Precedence: bulk
X-list: linux-mips

--000e0cd210c6706c82046291fa36
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Mr. Ralf,

I have tried to test cacheflush system call to generate EINVAL

on Toshiba RBTX4927/RBTX4937 board with 2.6.23 kernel.

I have referred latest Man pages there is a bug column.

Please let me know whether this is bug in source code or in the man page.

(arch/mips/mm/cache.c)



Thanks & regards

Naresh Kamboju

--000e0cd210c6706c82046291fa36
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



<p>Hi Mr. Ralf,</p>

<p>I have tried to test cacheflush
system call to generate EINVAL <br></p><p>on Toshiba RBTX4927/RBTX4937 board with 2.6.23 kernel.<br></p>

<p>I have referred latest Man pages
there is a bug column.</p>

<p>Please let me know whether this is
bug in source code or in the man page.</p><p>(arch/mips/mm/cache.c)<br></p>

<p>&nbsp;</p>

<p>Thanks &amp; regards</p>

<p>Naresh Kamboju </p>


--000e0cd210c6706c82046291fa36--
