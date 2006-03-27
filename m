Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2006 02:04:57 +0100 (BST)
Received: from www.haninternet.co.kr ([211.63.64.4]:10259 "EHLO
	www.haninternet.co.kr") by ftp.linux-mips.org with ESMTP
	id S8133572AbWC0BEs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Mar 2006 02:04:48 +0100
Received: from [211.63.70.179] ([211.63.70.179])
	by www.haninternet.co.kr (8.9.3/8.9.3) with ESMTP id KAA19329
	for <linux-mips@linux-mips.org>; Mon, 27 Mar 2006 10:12:49 +0900
Subject: Re: compilartion error   : label at end of compound statement
From:	Gowri Satish Adimulam <gowri@bitel.co.kr>
Reply-To: gowri@bitel.co.kr
To:	linux-mips@linux-mips.org
In-Reply-To: <20060324081829.GA3170@linux-mips.org>
References: <20060216.234519.82087885.anemo@mba.ocn.ne.jp>
	 <20060324.131809.115639866.nemoto@toshiba-tops.co.jp>
	 <1143184072.3249.26.camel@localhost.localdomain>
	 <20060324081829.GA3170@linux-mips.org>
Content-Type: text/plain
Organization: Bitel Co Ltd
Date:	Mon, 27 Mar 2006 10:15:02 +0900
Message-Id: <1143422102.3028.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Return-Path: <gowri@bitel.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gowri@bitel.co.kr
Precedence: bulk
X-list: linux-mips

Thanks every body 

On Fri, 2006-03-24 at 08:18 +0000, Ralf Baechle wrote:
> On Fri, Mar 24, 2006 at 04:07:52PM +0900, Gowri Satish Adimulam wrote:
> 
> > Hi ,
> > Iam trying to compile simple application with mips cross compiler ,
> 
> You didn't say which one.
> 
> (Fortunately it's obvious enough in this case)
> 
> > Iam getting the below error , 
> > i tried to google but unable to find relavent solution
> > 
> > any pointers will be helpful , 
> > 
> > ===============error==========
> > 
> > mipsel-linux-uclibc-gcc -Wall    -c -o ls.o ls.c
> > ls.c: In function `donlist':
> > ls.c:591: error: label at end of compound statement
> 
> Something like:
> 
>         switch (x) {
>         case 3:
>         }
> 
> will result in this error message in C9x.  Solution:  insert a semicolon
> like:
> 
>         switch (x) {
>         case 3:
> 	;
>         }
> 
> The reason is that the C stanadard requires - and thus gcc since 3.4 (?) -
> a label to be followed by a statement and a semicolon alone is already
> an statement.
> 
>   Ralf
