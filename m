Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 06:58:11 +0000 (GMT)
Received: from www.haninternet.co.kr ([211.63.64.4]:46607 "EHLO
	www.haninternet.co.kr") by ftp.linux-mips.org with ESMTP
	id S8133596AbWCXG6C (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Mar 2006 06:58:02 +0000
Received: from [211.63.70.179] ([211.63.70.179])
	by www.haninternet.co.kr (8.9.3/8.9.3) with ESMTP id QAA12677
	for <linux-mips@linux-mips.org>; Fri, 24 Mar 2006 16:05:57 +0900
Subject: compilartion error   : label at end of compound statement
From:	Gowri Satish Adimulam <gowri@bitel.co.kr>
Reply-To: gowri@bitel.co.kr
To:	linux-mips@linux-mips.org
In-Reply-To: <20060324.131809.115639866.nemoto@toshiba-tops.co.jp>
References: <20060216.234519.82087885.anemo@mba.ocn.ne.jp>
	 <20060324.131809.115639866.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain
Organization: Bitel Co Ltd
Date:	Fri, 24 Mar 2006 16:07:52 +0900
Message-Id: <1143184072.3249.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Return-Path: <gowri@bitel.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gowri@bitel.co.kr
Precedence: bulk
X-list: linux-mips

Hi ,
Iam trying to compile simple application with mips cross compiler ,
Iam getting the below error , 
i tried to google but unable to find relavent solution

any pointers will be helpful , 

===============error==========

mipsel-linux-uclibc-gcc -Wall    -c -o ls.o ls.c
ls.c: In function `donlist':
ls.c:591: error: label at end of compound statement

==============end of error============
Thanks 
Gowri 
