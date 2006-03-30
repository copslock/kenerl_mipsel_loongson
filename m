Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2006 15:53:41 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:20180 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133422AbWC3Oxd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Mar 2006 15:53:33 +0100
Received: (qmail 31116 invoked from network); 30 Mar 2006 19:04:31 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 30 Mar 2006 19:04:31 -0000
Message-ID: <442BF30C.5020508@ru.mvista.com>
Date:	Thu, 30 Mar 2006 19:02:36 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Freddy Spierenburg <freddy@dusktilldawn.nl>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] small time list process error in prom_getenv()
References: <20060327074352.GC4781@dusktilldawn.nl> <4427A31F.9080801@ru.mvista.com>
In-Reply-To: <4427A31F.9080801@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Sergei Shtylylov wrote:

>> I found a small time bug in prom_getenv() for which I like to
>> share the fix with y'all.

>> prom_envp is an array with two elements per environment variable.
>> So for instance element 0 is memsize and element 1 is 0x08000000
>> for the environment variable memsize=0x08000000.

>> The code for prom_getenv() only skips one element when it's in
>> search for the next environment variable. It should of course
>> step two elements.

>> I found this error in two files and for both I include a patch to
>> fix the problem.

>> ------------------------------------------------------------------------
>>
>> diff -Naur linux.orig/arch/mips/philips/pnx8550/common/prom.c 
>> linux/arch/mips/philips/pnx8550/common/prom.c
>> --- linux.orig/arch/mips/philips/pnx8550/common/prom.c    2006-03-22 
>> 15:25:58.000000000 +0000
>> +++ linux/arch/mips/philips/pnx8550/common/prom.c    2006-03-22 
>> 15:25:23.000000000 +0000
>> @@ -70,7 +70,7 @@
>>          if(strncmp(envname, env->name, i) == 0) {
>>              return(env->name + strlen(envname) + 1);
>>          }
>> -        env++;
>> +        env+=2;
>>      }
>>      return(NULL);
>>  }

>    Not sure what loader the Philips target uses...

    It uses some kind of Philips' own loader, so this code should be better 
left alone...

WBR, Sergei
