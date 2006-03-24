Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 12:03:41 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:27020 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133900AbWCXMDe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2006 12:03:34 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k2O8IX1M031478;
	Fri, 24 Mar 2006 08:18:34 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k2O8ITdD031477;
	Fri, 24 Mar 2006 08:18:29 GMT
Date:	Fri, 24 Mar 2006 08:18:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Gowri Satish Adimulam <gowri@bitel.co.kr>
Cc:	linux-mips@linux-mips.org
Subject: Re: compilartion error   : label at end of compound statement
Message-ID: <20060324081829.GA3170@linux-mips.org>
References: <20060216.234519.82087885.anemo@mba.ocn.ne.jp> <20060324.131809.115639866.nemoto@toshiba-tops.co.jp> <1143184072.3249.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143184072.3249.26.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 24, 2006 at 04:07:52PM +0900, Gowri Satish Adimulam wrote:

> Hi ,
> Iam trying to compile simple application with mips cross compiler ,

You didn't say which one.

(Fortunately it's obvious enough in this case)

> Iam getting the below error , 
> i tried to google but unable to find relavent solution
> 
> any pointers will be helpful , 
> 
> ===============error==========
> 
> mipsel-linux-uclibc-gcc -Wall    -c -o ls.o ls.c
> ls.c: In function `donlist':
> ls.c:591: error: label at end of compound statement

Something like:

        switch (x) {
        case 3:
        }

will result in this error message in C9x.  Solution:  insert a semicolon
like:

        switch (x) {
        case 3:
	;
        }

The reason is that the C stanadard requires - and thus gcc since 3.4 (?) -
a label to be followed by a statement and a semicolon alone is already
an statement.

  Ralf
