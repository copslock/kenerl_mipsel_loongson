Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1IA5at14953
	for linux-mips-outgoing; Mon, 18 Feb 2002 02:05:36 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1IA5R914950
	for <linux-mips@oss.sgi.com>; Mon, 18 Feb 2002 02:05:27 -0800
Message-Id: <200202181005.g1IA5R914950@oss.sgi.com>
Received: (qmail 6316 invoked from network); 18 Feb 2002 09:08:05 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 18 Feb 2002 09:08:05 -0000
Date: Mon, 18 Feb 2002 17:2:22 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Hartvig Ekner <hartvige@mips.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: math broken on mips
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g1IA5S914951
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,

  Thank you very much.

  I will gather all the problems and examples to show them i know and post them
today. Please wait for some time.

ÔÚ 2002-02-18 09:16:00 you wrote£º
>Hi Zhang,
>
>we're talking to Algorithmics about the possibility of productizing their
>SDE compiler for Linux. If this materializes, we should be able to get the
>GCC issues you mention fixed.
>
>Could you therefore pls. send me examples showing all the GCC issues you
>mention:
>
>1) SNan & QNan handling wrong
>2) Wrong code generated with -O2 (exception handling problem)
>3) Wrong code generated with -O2 (long long type problem)
>
>I would like (small!) examples suitable for inclusion directly in a work 
I like small one too:). 
>specification, so items like "Mozilla doesn't run" is not good enough :-)
>
>Finally, Kjeld E. at MIPS is spending some time on math-emu. So if you have
>specific issues, you can try to mail him as well (kjelde@mips.com).
>
>Problem #4 you report could be either in glibc or math-emu. If it's math-emu
>we'll fix it.
>
>/Hartvig
>
>
>Zhang Fuxin writes:
>> 
>> hi,
>>    There are so many problems on math handling for linux-mips,including:
>> 1. SNaN & QNan handling(both gcc & glibc)
>> 2. gcc2.96 generates wrong code with -O2,at least 
>>      one will lead to exception handling problem(reported by me)
>>      one will lead to some 'long long' type mishandling(reported by Atsushi Nemoto)
>> 
>>    (gcc3.1 seems a lot better,but it has problem to compile glibc.I can't even compile
>>  current glibc cvs code(with dl-conflict.c etc patched) with it. The best result is
>>  a segment fault when using ld.so.1:
>>       ../elf/ld.so.1 --library-path ..:../math:../elf:../dlfcn:../nss:../nis:../rt:../resolv:
>>   ../crypt:../linuxthreads ./rpcgen -Y ../scripts -c rpcsvc/bootparam_prot.x -o 
>>   xbootparam_prot.T
>>   make[1]: *** [xbootparam_prot.stmp] Segmentation fault
>>   )     
>> 3. problems with math-emu
>> 4. other problems to be investigated for its cause,including this one,
>>   
>>        pow(2,7) = 128.0 when rounding = TONEAREST or UPWARD
>>                 = 64.1547.. when rounding = DOWNWARD or TOWARDZERO
>> 
>>  when today i find out the above problem I was feeling almost despaired:(
>> 
>>  I want to fix these problems,if i could.But it concerns so many things that i am not
>>  expert on and no time to dig:(. So any help will be highly appreciated.
>> 
>>  
>> 
>> 
>> Regards
>>             Zhang Fuxin
>>             fxzhang@ict.ac.cn

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
