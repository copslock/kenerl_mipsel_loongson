Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 May 2007 12:57:10 +0100 (BST)
Received: from ik-out-1112.google.com ([66.249.90.179]:34399 "EHLO
	ik-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20023987AbXESL5J (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 19 May 2007 12:57:09 +0100
Received: by ik-out-1112.google.com with SMTP id c21so765835ika
        for <linux-mips@linux-mips.org>; Sat, 19 May 2007 04:56:58 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Fc3CfuUoLHWKfxvn+qZdhaxcj1DaSPH0wNyO6kMBRyeChP5OtHSsn1Vtzvj2g5JOLi7hRvx1WRG7lZKiUO7G6UgqSoZLOYEhr11FrlV547rdlX4xWoQrVYCsfFBvm1ZfYtju1pG6Yk8LnE5g/qZljQ92054diJh3wV+VAQ5YNp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SNYfrQfLyxdJS4PTG/KP5eG01m3xGLb+CSAe91TEq4Vu576k7tAPTJ4I5SLkLoF1ivjqAu5RqNzpW+aLjdX+jUzyO2kRIQQ0gIdY51v0qNseoheSWmsOhEjtc5YvgEn0lWFacPCytyTo2kl7krG/triZOJ9w6uv4nA4LhbQyUWs=
Received: by 10.82.187.16 with SMTP id k16mr4801081buf.1179575818237;
        Sat, 19 May 2007 04:56:58 -0700 (PDT)
Received: by 10.82.123.1 with HTTP; Sat, 19 May 2007 04:56:58 -0700 (PDT)
Message-ID: <f69849430705190456n4ae74be9m3be0b57ef7f54a5b@mail.gmail.com>
Date:	Sat, 19 May 2007 04:56:58 -0700
From:	"kernel coder" <lhrkernelcoder@gmail.com>
To:	linux-mips@linux-mips.org
Subject: system call implementation for 64 bit
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

hi,

I'm trying to implement a system call for x86_64. Mine processor is
dual core opetron.There is very little material on web for
implementing system calls for x86_64 processor for 2.6 series kernel.I
tried to implement a new system call by observing the existing
implementation but to no success.Following are files names and changes
made.

//////////////////////////////////////////////////
file-> include/asm-x86_64/unistd.h

#define __NR_newcall        273
__SYSCALL(__NR_newcall, sys_newcall)

#define __NR_syscall_max __NR_newcall

//////////////////////////////////////////////////
file-> include/linux/syscalls.h

asmlinkage unsigned long sys_newcall(char __user *buf);

/////////////////////////////////////////////
file--> fs/read_write.c

asmlinkage unsigned long sys_newcall(char __user * buf){

     printk("new system call \n");
     ret 0;
}

EXPORT_SYMBOL_GPL(sys_write)


Please let me know where i'm doing wrong .Following is program which
is calling mine system call


#include <stdlib.h>
#include <stdio.h>
#include <sys/unistd.h>
#include <sys/syscall.h>

  long int ret;
   int num = 243;
  char  buffer=[20];

int main() {


  asm ("syscall;"
       : "=a" (ret)
       : "0" (num),
         "D" (buffer),
      );
 return ret;
}

When i call this ,nothing gets printed in file /var/log/messages.Am i
missing something ?

Actually i wana pass a pointer to kernel from user space.Later on data
will be copied to that memory location .i am thinking of using
copy_to_user for copying data.Buffer passed through system call will
be used by kernel function as circular ring.And portions of this ring
will get updated frequently even after system call has returned.

Is there any better way to do this?


shahzad
