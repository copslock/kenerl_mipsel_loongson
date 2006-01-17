Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 12:09:03 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.204]:45132 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3465570AbWAQMIq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 12:08:46 +0000
Received: by wproxy.gmail.com with SMTP id 36so1398601wra
        for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 04:12:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jUZl932vBcZ6noXg4fg/cQ+Vsj+dArupcrnr6SR/rZA9iyQPGPfTjPKfSU7WqmWiCWrl+0K3p2zqmWKjc+WSn5Hqx46ZanHqnkrWiM/gZa4ZROn8agKQ9QKdUPkpW+xMcxrF8A/lHuue1/Vs8addrhIL9zFwOsVxit5dN7Bz2DA=
Received: by 10.54.128.16 with SMTP id a16mr5550925wrd;
        Tue, 17 Jan 2006 04:12:17 -0800 (PST)
Received: by 10.54.132.12 with HTTP; Tue, 17 Jan 2006 04:12:17 -0800 (PST)
Message-ID: <f69849430601170412y5d870504n55dcde38c7cce80f@mail.gmail.com>
Date:	Tue, 17 Jan 2006 04:12:17 -0800
From:	kernel coder <lhrkernelcoder@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Observation on IDE read operation
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

hi,

I was analyzing the IDE i/o mechanism in linux kernel 2.4.32.I
observed following sequence of read requests to read a particular file
with size around 13kb.

1) block no=9706		 number of sectors=20

2) block no=9723		 number of sectors=4

3) block no=9725		 number of sectors=2

4) block no=9726		 number of sectors=2

As u can see 4 different requests were made to read blocks 9706 to
9715 , 9723 to 9724 , 9725 , 9726.

The function __make_request ensures that requests are rearranged and
merged so that consective blocks are read in one request.So please
tell me why separete requests were made for reading blocks 9723 to
9724 , 9725 , 9726 ,when requests from 9724 to 9726 can be merged into
one.

Is it suitable that instead of generating separte requests for reading
 9706 to 9715 and 9723 to 9726 blocks ,just one request for reading
9706 to 9726 blocks is issued.This will cause irrelevant blocks (9716
to 9722) to be read as well but they can be discarded.

 If all data blocks of that particular file are read in one
request,will it increase  the speed of read operation on that file.

shahzad
