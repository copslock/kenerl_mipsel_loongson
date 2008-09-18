Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2008 22:17:26 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:21711 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S28773447AbYIRVQY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2008 22:16:24 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8ILGJHH019012;
	Thu, 18 Sep 2008 23:16:19 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8ILGHbP019010;
	Thu, 18 Sep 2008 23:16:17 +0200
Date:	Thu, 18 Sep 2008 23:16:17 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: execve errno setting on MIPS
Message-ID: <20080918211617.GA780@linux-mips.org>
References: <7B7EF7F090B9804A830ACC82F2CDE95D53F553@insardxms01.ap.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7B7EF7F090B9804A830ACC82F2CDE95D53F553@insardxms01.ap.sony.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 18, 2008 at 05:09:35PM +0530, Sadashiiv, Halesh wrote:
> From: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
> Date: Thu, 18 Sep 2008 17:09:35 +0530
> To: linux-mips@linux-mips.org
> Subject: execve errno setting on MIPS
> Content-Type: multipart/alternative;
> 	boundary="----_=_NextPart_001_01C91983.39F24AAB"
> 
> Hi all,
>  
> Please find the below testcase..
>  
> #include <stdio.h>
> #include <limits.h>
> #include <errno.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/types.h>
> #include <sys/stat.h>
>  
> #define EXE_NAME "./exe"
>  
> char e2BIG[ARG_MAX+1][10];
> char *envList[]={NULL};
>  
> int main(void)
> {
>   int ret,ind;
>  
>   for(ind = 0; ind < ARG_MAX+1; ind++)
>     strcpy(e2BIG[ind], "helloword");
>  
>   if ((ret = chmod(EXE_NAME,0744)) != 0){
>     printf("chmod failed\n");
>     exit(1);
>   }
>  
>   /* whne arg list is too long */
>   if ((ret = execve(EXE_NAME,e2BIG,envList)) == -1) {
>     if ( errno == E2BIG)
>       printf("Test Pass\n");
>     else
>       printf("Test Fail : Got Errno %d\n", errno);
>     exit(0);
>   }
>   else
>     printf("execve worked out of limit\n");
>   exit(1);
> }
>  
> On MIPS E2BIG is not getting set as errno instead EFAULT is set, while
> on 
> other archs like ARM, PowerPC and i686 I am able to get E2BIG.
>  
> Please let me know about the issue...
>  
> Let EXE_NAME be any executable....

Let there be light:

  char *foo[] != char foo[][]

char *e2BIG[ARG_MAX + 1] = {
        [0 ... ARG_MAX] = "helloword"
};

        for (ind = 0; ind < ARG_MAX + 1; ind++)
                strcpy(e2BIG[ind], "helloword");

is different from

char *e2BIG[ARG_MAX + 1] = {
        [0 ... ARG_MAX] = "helloword"
};

The one is two dimensional array, the other an array of pointers to char.

  Ralf
