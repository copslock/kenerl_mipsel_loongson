Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 08:19:18 +0200 (CEST)
Received: from wr-out-0506.google.com ([64.233.184.239]:927 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S8133435AbWEZGTK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 May 2006 08:19:10 +0200
Received: by wr-out-0506.google.com with SMTP id i21so152wra
        for <linux-mips@linux-mips.org>; Thu, 25 May 2006 23:19:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KDGUSKAEyXiCQFUIa/9VAG1q31F/J+rc83lvXQl153Zbi7h6B6pXEnix+SzLLrXeIae8/pTNPLAfTV6xxZ0yt75rN0TfP7FBfyBc7KPFGPt9ujLCkJmtK17z77/nlJJAQfJCm4jGvusdxn9wOvhOuYC2v/Qdj+9Ufo0NaE1uaeE=
Received: by 10.54.70.17 with SMTP id s17mr176951wra;
        Thu, 25 May 2006 23:19:08 -0700 (PDT)
Received: by 10.54.156.9 with HTTP; Thu, 25 May 2006 23:19:08 -0700 (PDT)
Message-ID: <5800c1cc0605252319l1fe2954amcd649fd4798259a2@mail.gmail.com>
Date:	Fri, 26 May 2006 14:19:08 +0800
From:	"Bin Chen" <binary.chen@gmail.com>
To:	linux-mips@linux-mips.org
Subject: how does these two instruction mean?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <binary.chen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: binary.chen@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

In my program the gcc produce two lines of binary code:

100020e0:       ffc20000        sd      v0,0(s8)
100020e4:       dfc20000        ld      v0,0(s8)

first store v0->[s8], then load from [s8]->v0, why?

Thanks.

B.C
